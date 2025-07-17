import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart'; // Necesario para SnackBar y openAppSettings

class AppPermissionHandler {
  static Future<bool> requestStorageAndPhotosPermissions(BuildContext context) async {
    // Solicitar permiso de almacenamiento (para versiones antiguas de Android)
    final statusStorage = await Permission.storage.request();
    // Solicitar permiso de acceso a fotos (para Android 13+)
    final statusPhotos = await Permission.photos.request();

    if (statusStorage.isGranted || statusPhotos.isGranted) {
      return true;
    } else if (statusStorage.isPermanentlyDenied || statusPhotos.isPermanentlyDenied) {
      if (!context.mounted) return false;
      _showSnackBar(context, 'Permisos denegados permanentemente. Por favor, habilítalos desde la configuración de la aplicación.');
      openAppSettings(); // Abre la configuración de la aplicación para que el usuario pueda habilitar los permisos
      return false;
    } else {
      if (!context.mounted) return false;
      _showSnackBar(context, 'Permisos de almacenamiento o fotos denegados.');
      return false;
    }
  }

  static void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
