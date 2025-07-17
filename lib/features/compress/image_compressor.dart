import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class ImageCompressor {
  static Future<File?> compressImage(String path, {int quality = 65}) async {
    try {
      // 1. Validar existencia del archivo original
      final originalFile = File(path);
      if (!await originalFile.exists()) {
        throw Exception("El archivo original no existe: $path");
      }

      // 2. Crear directorio objetivo si no existe
      final dir = await getApplicationDocumentsDirectory();
      if (!await dir.exists()) {
        await dir.create(recursive: true);
      }

      // 3. Generar ruta objetivo con nombre único
      final targetPath = 
          '${dir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';

      // 4. Comprimir y guardar
      final result = await FlutterImageCompress.compressAndGetFile(
        path,
        targetPath,
        quality: quality,
        format: CompressFormat.jpeg,
        keepExif: false,
      );

      // 5. Convertir XFile a File
      return result != null ? File(result.path) : null;
    } catch (e) {
      debugPrint('Error al comprimir: $e');
      throw Exception('Error al comprimir la imagen: $e'); // Lanzar excepción
    }
  }
}
