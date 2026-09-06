import 'package:flutter/services.dart';

class GallerySaveException implements Exception {
  const GallerySaveException(this.code, {this.message});

  final String code;
  final String? message;

  @override
  String toString() => message == null
      ? 'GallerySaveException($code)'
      : 'GallerySaveException($code): $message';
}

class GallerySaveService {
  const GallerySaveService();

  static const _channel = MethodChannel('com.killstreak.killqr/gallery');

  Future<void> savePng(Uint8List bytes) async {
    try {
      final permission = await _channel.invokeMethod<bool>(
        'requestGalleryPermission',
      );
      if (permission != true) {
        throw const GallerySaveException('permission_denied');
      }

      final fileName = 'killqr_${DateTime.now().millisecondsSinceEpoch}.png';
      final uri = await _channel.invokeMethod<String>('savePngToGallery', {
        'bytes': bytes,
        'fileName': fileName,
      });
      if (uri == null || uri.isEmpty) {
        throw const GallerySaveException('save_failed');
      }
    } on PlatformException catch (error) {
      throw GallerySaveException(error.code, message: error.message);
    } on MissingPluginException {
      throw const GallerySaveException('unsupported_platform');
    }
  }
}
