part of 'home_bloc.dart';

class HomeState extends Equatable {
  final File? originalImage;
  final File? compressedImage;
  final int quality;
  final int? originalImageSize;
  final int? compressedImageSize;
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;

  const HomeState({
    this.originalImage,
    this.compressedImage,
    this.quality = 80,
    this.originalImageSize,
    this.compressedImageSize,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
  });

  HomeState copyWith({
    File? originalImage,
    File? compressedImage,
    int? quality,
    int? originalImageSize,
    int? compressedImageSize,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
  }) {
    return HomeState(
      originalImage: originalImage ?? this.originalImage,
      compressedImage: compressedImage ?? this.compressedImage,
      quality: quality ?? this.quality,
      originalImageSize: originalImageSize ?? this.originalImageSize,
      compressedImageSize: compressedImageSize ?? this.compressedImageSize,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
    );
  }

  @override
  List<Object?> get props => [
        originalImage,
        compressedImage,
        quality,
        originalImageSize,
        compressedImageSize,
        isLoading,
        errorMessage,
        successMessage,
      ];
}