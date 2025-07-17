import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

import 'package:image_compressor_app/core/utils/app_strings.dart';
import 'package:image_compressor_app/features/compress/image_compressor.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<PickImage>(_onPickImage);
    on<CompressImage>(_onCompressImage);
    on<UpdateQuality>(_onUpdateQuality);
    on<ShareCompressedImage>(_onShareCompressedImage);
  }

  Future<void> _onPickImage(PickImage event, Emitter<HomeState> emit) async {
    // Permissions are now handled in the UI layer before dispatching the event
    // to allow showing SnackBar with context.
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      emit(state.copyWith(
        originalImage: file,
        originalImageSize: file.lengthSync(),
        compressedImage: null,
        compressedImageSize: null,
        errorMessage: null,
        successMessage: null,
      ));
    }
  }

  Future<void> _onCompressImage(CompressImage event, Emitter<HomeState> emit) async {
    if (state.originalImage == null) {
      emit(state.copyWith(errorMessage: AppStrings.selectImageFirst));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null, successMessage: null));

    try {
      final compressedFile = await ImageCompressor.compressImage(
        state.originalImage!.path,
        quality: event.quality,
      );

      if (compressedFile == null) {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: AppStrings.compressionError,
        ));
      } else {
        emit(state.copyWith(
          compressedImage: compressedFile,
          compressedImageSize: compressedFile.lengthSync(),
          isLoading: false,
          successMessage: AppStrings.compressionSuccess,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: '${AppStrings.compressionError}: ${e.toString()}',
      ));
    }
  }

  void _onUpdateQuality(UpdateQuality event, Emitter<HomeState> emit) {
    emit(state.copyWith(quality: event.quality));
  }

  Future<void> _onShareCompressedImage(ShareCompressedImage event, Emitter<HomeState> emit) async {
    if (state.compressedImage == null) return;
    await Share.shareXFiles([XFile(state.compressedImage!.path)]);
  }
}
