import 'dart:async';
import 'dart:math';

import 'package:camera/camera.dart' as camera;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zxing/flutter_zxing.dart' as zxing;

/// Camera reader that supports an independently resizable rectangular crop.
///
/// `flutter_zxing`'s stock ReaderWidget only exposes a square crop. This
/// widget keeps its camera lifecycle and decoding path, while passing the
/// selected rectangle directly to ZXing through DecodeParams.
class RectangularReaderWidget extends StatefulWidget {
  const RectangularReaderWidget({
    required this.onScan,
    required this.onControllerCreated,
    required this.multiple,
    required this.lensDirection,
    required this.scanAreaWidth,
    required this.scanAreaHeight,
    this.onMultiScan,
    this.onError,
    this.resolution = camera.ResolutionPreset.high,
    this.loading = const DecoratedBox(
      decoration: BoxDecoration(color: Colors.black),
    ),
    super.key,
  });

  final ValueChanged<zxing.Code> onScan;
  final ValueChanged<zxing.Codes>? onMultiScan;
  final void Function(camera.CameraController?, Exception?) onControllerCreated;
  final ValueChanged<Object>? onError;
  final bool multiple;
  final camera.CameraLensDirection lensDirection;
  final camera.ResolutionPreset resolution;
  final double scanAreaWidth;
  final double scanAreaHeight;
  final Widget loading;

  @override
  State<RectangularReaderWidget> createState() =>
      _RectangularReaderWidgetState();
}

class _RectangularReaderWidgetState extends State<RectangularReaderWidget>
    with WidgetsBindingObserver {
  static const _teardownTimeout = Duration(seconds: 2);

  final Set<camera.ImageFormatGroup> _reportedFormats =
      <camera.ImageFormatGroup>{};
  List<camera.CameraDescription> _cameras = <camera.CameraDescription>[];
  camera.CameraDescription? _selectedCamera;
  camera.CameraController? _controller;
  Completer<void>? _initializationCompleter;
  String _controllerVersion = '';
  bool _isInitializing = false;
  bool _isCameraOn = false;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    unawaited(_initialize());
  }

  @override
  void didUpdateWidget(covariant RectangularReaderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.lensDirection != widget.lensDirection ||
        oldWidget.resolution != widget.resolution) {
      final selected = _findCamera(widget.lensDirection);
      if (selected != null) unawaited(_selectCamera(selected));
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;

    switch (state) {
      case AppLifecycleState.resumed:
        if (!_isCameraOn) {
          final selected = _selectedCamera;
          if (selected != null) unawaited(_selectCamera(selected));
        }
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        unawaited(_stopCamera());
      case AppLifecycleState.detached:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_initializationCompleter case final completer?
        when !completer.isCompleted) {
      completer.complete();
    }
    unawaited(_disposeController());
    zxing.zx.stopCameraProcessing();
    super.dispose();
  }

  Future<void> _initialize() async {
    unawaited(
      zxing.zx.startCameraProcessing().catchError((Object error) {
        debugPrint('KillQR: failed to start camera processing: $error');
      }),
    );

    try {
      final cameras = await camera.availableCameras();
      if (!mounted) return;
      _cameras = cameras;
      final selected = _findCamera(widget.lensDirection);
      if (selected != null) await _selectCamera(selected);
    } on Object catch (error) {
      _reportError(error);
    }
  }

  camera.CameraDescription? _findCamera(camera.CameraLensDirection direction) {
    if (_cameras.isEmpty) return null;
    return _cameras.firstWhere(
      (item) => item.lensDirection == direction,
      orElse: () => _cameras.first,
    );
  }

  Future<void> _selectCamera(camera.CameraDescription description) async {
    if (_isInitializing || !mounted) return;
    _isInitializing = true;
    _initializationCompleter = Completer<void>();
    await _disposeController(notify: true);

    _selectedCamera = description;
    _isProcessing = false;
    final version = DateTime.now().microsecondsSinceEpoch.toString();
    _controllerVersion = version;
    await Future<void>.delayed(const Duration(milliseconds: 80));

    final controller = camera.CameraController(
      description,
      widget.resolution,
      enableAudio: false,
      imageFormatGroup: _preferredImageFormatGroup(),
    );
    _controller = controller;

    bool isCurrent() =>
        mounted &&
        identical(_controller, controller) &&
        _controllerVersion == version;

    try {
      await controller.initialize();
      if (!isCurrent()) return;
      widget.onControllerCreated(controller, null);
      await controller.startImageStream(
        (image) => _processImageStream(image, version),
      );
      if (!isCurrent()) return;
      if (mounted) setState(() => _isCameraOn = true);
    } on Object catch (error) {
      if (isCurrent()) {
        _reportError(error);
        widget.onControllerCreated(
          null,
          error is Exception ? error : Exception(error.toString()),
        );
      }
    } finally {
      _isInitializing = false;
      final completer = _initializationCompleter;
      if (completer != null && !completer.isCompleted) completer.complete();
      _initializationCompleter = null;
    }
  }

  Future<void> _stopCamera() async {
    final controller = _controller;
    if (controller == null) return;
    if (controller.value.isStreamingImages) {
      try {
        await controller.stopImageStream();
      } on Object catch (error) {
        debugPrint('KillQR: failed to stop camera stream: $error');
      }
    }
    _isCameraOn = false;
    _isProcessing = false;
  }

  Future<void> _disposeController({bool notify = false}) async {
    final controller = _controller;
    _controller = null;
    _isCameraOn = false;
    _isProcessing = false;
    _controllerVersion = 'disposed_${DateTime.now().microsecondsSinceEpoch}';
    if (notify && mounted) setState(() {});
    if (controller == null) return;

    try {
      if (controller.value.isStreamingImages) {
        await controller.stopImageStream().timeout(_teardownTimeout);
      }
    } on Object catch (error) {
      debugPrint('KillQR: failed to stop camera stream: $error');
    }
    try {
      await controller.dispose().timeout(_teardownTimeout);
    } on Object catch (error) {
      debugPrint('KillQR: failed to dispose camera: $error');
    }
  }

  Future<void> _processImageStream(
    camera.CameraImage image,
    String version,
  ) async {
    if (!mounted ||
        !_isCameraOn ||
        _isInitializing ||
        _isProcessing ||
        version != _controllerVersion) {
      return;
    }

    _isProcessing = true;
    try {
      final imageFormat = _imageFormat(image.format.group);
      if (imageFormat == zxing.ImageFormat.none) {
        _reportUnscannableFormat(image.format.group);
        return;
      }

      final crop = _cropFor(image);
      final params = zxing.DecodeParams(
        imageFormat: imageFormat,
        format: zxing.Format.any,
        width: image.width,
        height: image.height,
        cropLeft: crop.left,
        cropTop: crop.top,
        cropWidth: crop.width,
        cropHeight: crop.height,
        tryHarder: true,
        tryRotate: true,
        tryDownscale: true,
        maxNumberOfSymbols: 20,
        isMultiScan: widget.multiple,
      );

      if (widget.multiple) {
        final codes = await zxing.zx.processCameraImageMulti(image, params);
        if (codes.codes.isNotEmpty) widget.onMultiScan?.call(codes);
      } else {
        final code = await zxing.zx.processCameraImage(image, params);
        if (code.isValid) widget.onScan(code);
      }
    } on Object catch (error) {
      debugPrint('KillQR: camera frame processing failed: $error');
    } finally {
      await Future<void>.delayed(
        widget.multiple
            ? const Duration(milliseconds: 120)
            : const Duration(milliseconds: 650),
      );
      _isProcessing = false;
    }
  }

  _CropRect _cropFor(camera.CameraImage image) {
    if (widget.multiple) {
      return _CropRect(0, 0, image.width, image.height);
    }

    final base = min(image.width, image.height).toDouble();
    final requestedWidth = (base * widget.scanAreaWidth).round();
    final requestedHeight = (base * widget.scanAreaHeight).round();
    final swapAxes =
        defaultTargetPlatform == TargetPlatform.android &&
        MediaQuery.orientationOf(context) == Orientation.portrait;
    final cropWidth = (swapAxes ? requestedHeight : requestedWidth)
        .clamp(1, image.width)
        .toInt();
    final cropHeight = (swapAxes ? requestedWidth : requestedHeight)
        .clamp(1, image.height)
        .toInt();
    return _CropRect(
      (image.width - cropWidth) ~/ 2,
      (image.height - cropHeight) ~/ 2,
      cropWidth,
      cropHeight,
    );
  }

  Widget _buildPreview(Size size) {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized || !_isCameraOn) {
      return widget.loading;
    }

    final cameraMaxSize = max(size.width, size.height);
    return SizedBox(
      width: cameraMaxSize,
      height: cameraMaxSize,
      child: ClipRect(
        child: OverflowBox(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: cameraMaxSize,
              child: camera.CameraPreview(controller),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final media = MediaQuery.sizeOf(context);
        final size = Size(
          constraints.hasBoundedWidth ? constraints.maxWidth : media.width,
          constraints.hasBoundedHeight ? constraints.maxHeight : media.height,
        );
        return _buildPreview(size);
      },
    );
  }

  void _reportError(Object error) {
    widget.onError?.call(error);
  }

  void _reportUnscannableFormat(camera.ImageFormatGroup group) {
    if (_reportedFormats.add(group)) {
      final error = Exception(
        'Unsupported camera image format: $group. Use YUV420 on Android or '
        'BGRA8888 on iOS.',
      );
      _reportError(error);
    }
  }

  int _imageFormat(camera.ImageFormatGroup group) {
    switch (group) {
      case camera.ImageFormatGroup.bgra8888:
        return zxing.ImageFormat.bgra;
      case camera.ImageFormatGroup.yuv420:
      case camera.ImageFormatGroup.nv21:
        return zxing.ImageFormat.lum;
      case camera.ImageFormatGroup.jpeg:
      case camera.ImageFormatGroup.unknown:
        return zxing.ImageFormat.none;
    }
  }

  camera.ImageFormatGroup _preferredImageFormatGroup() {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return camera.ImageFormatGroup.yuv420;
      case TargetPlatform.iOS:
        return camera.ImageFormatGroup.bgra8888;
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return camera.ImageFormatGroup.unknown;
    }
  }
}

class _CropRect {
  const _CropRect(this.left, this.top, this.width, this.height);

  final int left;
  final int top;
  final int width;
  final int height;
}
