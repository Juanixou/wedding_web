import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:wedding_web/bloc/video_player/video_state.dart';

class VideoCubit extends Cubit<VideoState> {
  // Cambia 'assets/wedding_video.mp4' por la ruta real de tu video
  final String videoAssetPath;
  VideoPlayerController? _controller;

  VideoCubit({required this.videoAssetPath}) : super(VideoInitial()) {
    initializeVideo();
  }

  Future<void> initializeVideo() async {
    emit(VideoLoading());
    try {
      // 1. Crear el controlador con el asset
      _controller = VideoPlayerController.asset(videoAssetPath);

      // 2. Inicializar el video
      await _controller!.initialize();

      // 3. Configurar loop y muting
      _controller!.setLooping(true); // Para que se repita
      _controller!.setVolume(0.0);   // Inicia silenciado (buena práctica web)

      emit(VideoLoaded(_controller!));
    } catch (e) {
      emit(VideoError('Error al cargar el video: $e'));
    }
  }

  void playPause() {
    if (_controller == null) return;
    _controller!.value.isPlaying ? _controller!.pause() : _controller!.play();
    // No necesitamos emitir un estado aquí, ya que el widget usará ValueListenableBuilder
  }

  void toggleMute() {
    if (_controller == null) return;
    final newVolume = _controller!.value.volume > 0 ? 0.0 : 1.0;
    _controller!.setVolume(newVolume);
  }

  @override
  Future<void> close() {
    _controller?.dispose();
    return super.close();
  }
}