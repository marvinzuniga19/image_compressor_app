import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_compressor_app/core/utils/app_strings.dart';
import 'package:image_compressor_app/core/utils/permission_handler.dart';
import 'package:image_compressor_app/features/home/bloc/home_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.appTitle)),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            _showSnackBar(context, state.errorMessage!);
          } else if (state.successMessage != null) {
            _showSnackBar(context, state.successMessage!);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Select Image Button
                ElevatedButton(
                  onPressed: () async {
                    final hasPermission = await AppPermissionHandler.requestStorageAndPhotosPermissions(context);
                    if (!context.mounted) return;
                    if (hasPermission) {
                      context.read<HomeBloc>().add(PickImage());
                    }
                  },
                  child: const Text(AppStrings.selectImageButton),
                ),
                const SizedBox(height: 20),

                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) =>
                      previous.originalImage != current.originalImage ||
                      previous.originalImageSize != current.originalImageSize,
                  builder: (context, state) {
                    if (state.originalImage != null) {
                      return Column(
                        children: [
                          const Text(AppStrings.originalImageLabel,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Image.file(state.originalImage!, height: 200),
                          if (state.originalImageSize != null)
                            Text(
                                'Tamaño: ${_formatBytes(state.originalImageSize!)}'),
                          const SizedBox(height: 20),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                // Compression Quality Slider
                const Text(AppStrings.compressionQualityLabel),
                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) =>
                      previous.quality != current.quality,
                  builder: (context, state) {
                    return Slider(
                      value: state.quality.toDouble(),
                      min: 1,
                      max: 100,
                      divisions: 99,
                      label: '${state.quality}%',
                      onChanged: (value) {
                        context
                            .read<HomeBloc>()
                            .add(UpdateQuality(value.round()));
                      },
                    );
                  },
                ),

                // Compress Image Button
                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) =>
                      previous.isLoading != current.isLoading ||
                      previous.quality != current.quality ||
                      previous.originalImage != current.originalImage,
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state.isLoading
                          ? null
                          : () async {
                              final hasPermission = await AppPermissionHandler.requestStorageAndPhotosPermissions(context);
                              if (!context.mounted) return;
                              if (hasPermission) {
                                context
                                    .read<HomeBloc>()
                                    .add(CompressImage(state.quality));
                              }
                            },
                      child: state.isLoading
                          ? const CircularProgressIndicator()
                          : const Text(AppStrings.compressImageButton),
                    );
                  },
                ),

                // Compressed Image Display
                BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) =>
                      previous.compressedImage != current.compressedImage ||
                      previous.compressedImageSize != current.compressedImageSize ||
                      previous.isLoading != current.isLoading,
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            Text(AppStrings.compressingMessage),
                          ],
                        ),
                      );
                    } else if (state.compressedImage != null) {
                      return Column(
                        children: [
                          const SizedBox(height: 20),
                          const Text(AppStrings.compressedImageLabel,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Image.file(state.compressedImage!, height: 200),
                          if (state.compressedImageSize != null)
                            Text(
                                'Tamaño: ${_formatBytes(state.compressedImageSize!)}'),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              context
                                  .read<HomeBloc>()
                                  .add(ShareCompressedImage());
                            },
                            child: const Text(AppStrings.shareImageButton),
                          ),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  String _formatBytes(int bytes) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    int i = (bytes > 0) ? (bytes.toString().length - 1) ~/ 3 : 0;
    return '${(bytes / (1 << (i * 10))).toStringAsFixed(2)} ${suffixes[i]}';
  }
}