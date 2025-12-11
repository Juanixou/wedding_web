import 'package:video_player/video_player.dart';

// --- Estados (States) ---
abstract class VideoState {}

class VideoInitial extends VideoState {}
class VideoLoading extends VideoState {}
class VideoLoaded extends VideoState {
  final VideoPlayerController controller;
  VideoLoaded(this.controller);
}
class VideoError extends VideoState {
  final String message;
  VideoError(this.message);
}