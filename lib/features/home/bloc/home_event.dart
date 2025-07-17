part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class PickImage extends HomeEvent {}

class CompressImage extends HomeEvent {
  final int quality;

  const CompressImage(this.quality);

  @override
  List<Object> get props => [quality];
}

class UpdateQuality extends HomeEvent {
  final int quality;

  const UpdateQuality(this.quality);

  @override
  List<Object> get props => [quality];
}

class ShareCompressedImage extends HomeEvent {}