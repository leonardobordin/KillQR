package com.killstreak.killqr

import android.Manifest
import android.content.ContentValues
import android.content.pm.PackageManager
import android.graphics.Bitmap
import android.graphics.Color
import android.media.MediaScannerConnection
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Environment
import android.os.ParcelFileDescriptor
import android.provider.MediaStore
import android.graphics.pdf.PdfRenderer
import java.io.File
import java.io.FileOutputStream
import java.io.IOException
import java.util.Locale
import java.util.UUID
import kotlin.math.roundToInt
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private companion object {
        const val GALLERY_CHANNEL = "com.killstreak.killqr/gallery"
        const val DOCUMENT_CHANNEL = "com.killstreak.killqr/documents"
        const val WRITE_STORAGE_REQUEST = 4101
    }

    private var pendingGalleryPermissionResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            GALLERY_CHANNEL,
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "requestGalleryPermission" -> requestGalleryPermission(result)
                "savePngToGallery" -> {
                    val bytes = call.argument<ByteArray>("bytes")
                    if (bytes == null || bytes.isEmpty()) {
                        result.error("invalid_data", "The PNG data is empty.", null)
                        return@setMethodCallHandler
                    }
                    val fileName = call.argument<String>("fileName")
                    try {
                        result.success(savePngToGallery(bytes, fileName))
                    } catch (error: SecurityException) {
                        result.error(
                            "permission_denied",
                            error.message ?: "Storage permission was denied.",
                            null,
                        )
                    } catch (error: Exception) {
                        result.error(
                            "save_failed",
                            error.message ?: "The PNG could not be saved.",
                            null,
                        )
                    }
                }
                else -> result.notImplemented()
            }
        }
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            DOCUMENT_CHANNEL,
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "renderPdf" -> {
                    val bytes = call.argument<ByteArray>("bytes")
                    if (bytes == null || bytes.isEmpty()) {
                        result.error("invalid_data", "The PDF data is empty.", null)
                        return@setMethodCallHandler
                    }
                    val maxPages = call.argument<Int>("maxPages") ?: 50
                    val maxDimension = call.argument<Int>("maxDimension") ?: 2200
                    try {
                        result.success(renderPdf(bytes, maxPages, maxDimension))
                    } catch (error: Exception) {
                        result.error(
                            "pdf_render_failed",
                            error.message ?: "The PDF could not be rendered.",
                            null,
                        )
                    }
                }
                "deleteRenderedFiles" -> {
                    val paths = call.argument<List<String>>("paths").orEmpty()
                    deleteRenderedFiles(paths)
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun requestGalleryPermission(result: MethodChannel.Result) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q ||
            checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE) ==
            PackageManager.PERMISSION_GRANTED
        ) {
            result.success(true)
            return
        }

        if (pendingGalleryPermissionResult != null) {
            result.error(
                "permission_request_in_progress",
                "A storage permission request is already open.",
                null,
            )
            return
        }

        pendingGalleryPermissionResult = result
        requestPermissions(
            arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE),
            WRITE_STORAGE_REQUEST,
        )
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray,
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode != WRITE_STORAGE_REQUEST) return
        val result = pendingGalleryPermissionResult ?: return
        pendingGalleryPermissionResult = null
        result.success(
            grantResults.firstOrNull() == PackageManager.PERMISSION_GRANTED,
        )
    }

    private fun savePngToGallery(bytes: ByteArray, requestedName: String?): String {
        val fileName = normalizedFileName(requestedName)
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
            saveWithMediaStore(bytes, fileName)
        } else {
            saveLegacyGalleryFile(bytes, fileName)
        }
    }

    private fun saveWithMediaStore(bytes: ByteArray, fileName: String): String {
        val values = ContentValues().apply {
            put(MediaStore.Images.Media.DISPLAY_NAME, fileName)
            put(MediaStore.Images.Media.MIME_TYPE, "image/png")
            put(
                MediaStore.Images.Media.RELATIVE_PATH,
                "${Environment.DIRECTORY_PICTURES}/KillQR",
            )
            put(MediaStore.Images.Media.IS_PENDING, 1)
        }
        val collection = MediaStore.Images.Media.getContentUri(
            MediaStore.VOLUME_EXTERNAL_PRIMARY,
        )
        var uri: Uri? = null
        try {
            uri = contentResolver.insert(collection, values)
                ?: throw IOException("The gallery did not accept the PNG.")
            contentResolver.openOutputStream(uri, "w")?.use { output ->
                output.write(bytes)
            } ?: throw IOException("The gallery stream could not be opened.")
            val completed = ContentValues().apply {
                put(MediaStore.Images.Media.IS_PENDING, 0)
            }
            contentResolver.update(uri, completed, null, null)
            return uri.toString()
        } catch (error: Exception) {
            uri?.let { contentResolver.delete(it, null, null) }
            throw error
        }
    }

    @Suppress("DEPRECATION")
    private fun saveLegacyGalleryFile(bytes: ByteArray, fileName: String): String {
        if (checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE) !=
            PackageManager.PERMISSION_GRANTED
        ) {
            throw SecurityException("Storage permission was denied.")
        }
        val pictures = Environment.getExternalStoragePublicDirectory(
            Environment.DIRECTORY_PICTURES,
        )
        val directory = File(pictures, "KillQR")
        if (!directory.exists() && !directory.mkdirs() && !directory.isDirectory) {
            throw IOException("The gallery directory could not be created.")
        }
        val file = File(directory, fileName)
        try {
            file.outputStream().use { output -> output.write(bytes) }
            MediaScannerConnection.scanFile(
                this,
                arrayOf(file.absolutePath),
                arrayOf("image/png"),
                null,
            )
            return file.absolutePath
        } catch (error: Exception) {
            file.delete()
            throw error
        }
    }

    private fun normalizedFileName(requestedName: String?): String {
        val sanitized = requestedName.orEmpty()
            .replace(Regex("[^A-Za-z0-9._-]"), "_")
            .trim('_')
        val base = sanitized.ifBlank { "killqr_${System.currentTimeMillis()}" }
        return if (base.lowercase(Locale.US).endsWith(".png")) {
            base
        } else {
            "$base.png"
        }
    }

    private fun renderPdf(
        bytes: ByteArray,
        requestedMaxPages: Int,
        requestedMaxDimension: Int,
    ): List<String> {
        val root = File(cacheDir, "killqr_documents/${UUID.randomUUID()}")
        if (!root.mkdirs() && !root.isDirectory) {
            throw IOException("The document cache directory could not be created.")
        }
        val pdfFile = File(root, "document.pdf")
        pdfFile.outputStream().use { output -> output.write(bytes) }

        val renderedPaths = mutableListOf<String>()
        var descriptor: ParcelFileDescriptor? = null
        var renderer: PdfRenderer? = null
        try {
            descriptor = ParcelFileDescriptor.open(
                pdfFile,
                ParcelFileDescriptor.MODE_READ_ONLY,
            )
            renderer = PdfRenderer(descriptor)
            val maxPages = requestedMaxPages.coerceIn(1, 50)
            val maxDimension = requestedMaxDimension.coerceIn(512, 3000)
            val pageCount = renderer.pageCount.coerceAtMost(maxPages)
            for (index in 0 until pageCount) {
                val page = renderer.openPage(index)
                try {
                    val scale = minOf(
                        maxDimension.toFloat() / page.width,
                        maxDimension.toFloat() / page.height,
                    )
                    val width = (page.width * scale).roundToInt().coerceAtLeast(1)
                    val height = (page.height * scale).roundToInt().coerceAtLeast(1)
                    val bitmap = Bitmap.createBitmap(
                        width,
                        height,
                        Bitmap.Config.ARGB_8888,
                    )
                    try {
                        bitmap.eraseColor(Color.WHITE)
                        page.render(
                            bitmap,
                            null,
                            null,
                            PdfRenderer.Page.RENDER_MODE_FOR_DISPLAY,
                        )
                        val outputFile = File(root, "page_${index.toString().padStart(3, '0')}.png")
                        FileOutputStream(outputFile).use { output ->
                            if (!bitmap.compress(Bitmap.CompressFormat.PNG, 100, output)) {
                                throw IOException("A PDF page could not be encoded.")
                            }
                        }
                        renderedPaths.add(outputFile.absolutePath)
                    } finally {
                        bitmap.recycle()
                    }
                } finally {
                    page.close()
                }
            }
            return renderedPaths
        } catch (error: Exception) {
            renderedPaths.forEach { path -> File(path).delete() }
            root.delete()
            throw error
        } finally {
            renderer?.close()
            descriptor?.close()
            pdfFile.delete()
        }
    }

    private fun deleteRenderedFiles(paths: List<String>) {
        val directories = paths.mapNotNull { path -> File(path).parentFile }.distinct()
        paths.forEach { path -> File(path).delete() }
        directories.forEach { directory ->
            if (directory.listFiles()?.isEmpty() == true) directory.delete()
            directory.parentFile?.let { parent ->
                if (parent.listFiles()?.isEmpty() == true) parent.delete()
            }
        }
    }
}
