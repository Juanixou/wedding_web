import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wedding_web/bloc/video_player/video_cubit.dart';
import 'package:wedding_web/bloc/video_player/video_state.dart';
import 'package:wedding_web/widgets/video_player.dart';

class VideoSectionContainer extends StatefulWidget {
  final double width;
  final double height;
  final double borderRadius;
  final String videoAssetPath;

  const VideoSectionContainer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 16.0,
    required this.videoAssetPath,
  });

  @override
  State<VideoSectionContainer> createState() => _VideoSectionContainerState();
}

class _VideoSectionContainerState extends State<VideoSectionContainer> {
  // CLAVE: Variable para forzar la reconstrucción del widget del video
  Key _playerKey = UniqueKey();

  // Función de callback que se llamará cuando se vuelva de pantalla completa
  void onVideoExitFullScreen() {
    // Cambiamos la clave para forzar que Flutter destruya y reconstruya el FullScreenVideoPlayer
    // y su contenido (incluido el VideoPlayer).
    setState(() {
      _playerKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    // 1. Provee el Cubit en este nivel.
    return BlocProvider(
      create: (_) => VideoCubit(videoAssetPath: widget.videoAssetPath),
      child: BlocBuilder<VideoCubit, VideoState>(
        builder: (context, state) {
          if (state is VideoLoaded) {
            return Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                color: Colors.black,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                // 2. Insertamos la clave y el callback
                child: FullScreenVideoPlayer(
                  key: _playerKey, // Aplicamos la clave única
                  controller: state.controller,
                  // Pasamos el callback para ejecutarlo al salir de FullScreen
                  onExitFullScreen: onVideoExitFullScreen,
                ),
              ),
            );
          }
          // Maneja los estados de carga y error (se mantienen igual)
          if (state is VideoLoading) {
            return SizedBox(width: widget.width, height: widget.height, child: const Center(child: CircularProgressIndicator()));
          }
          if (state is VideoError) {
            return SizedBox(width: widget.width, height: widget.height, child: Center(child: Text('Error: ${state.message}')));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}