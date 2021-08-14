part of 'blur_hash_cubit.dart';

abstract class BlurHashState extends Equatable {
  const BlurHashState();

  @override
  List<Object> get props => [];
}

class BlurHashInitial extends BlurHashState {}

class BlurHashLoading extends BlurHashState {}

class BlurHashSuccess extends BlurHashState {
  String hash;
  BlurHashSuccess({@required this.hash});
  @override
  List<Object> get props => [this.hash];
}

class BlurHashFailure extends BlurHashState {}
