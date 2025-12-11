import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
// Importa tus cubits y states aquí
import 'package:wedding_web/bloc/video_player/video_cubit.dart';
import 'package:wedding_web/bloc/video_player/video_state.dart';

// 1. Añadimos el callback y lo hacemos opcional (para cuando es FullScreenWrapper)
typedef VideoExitCallback = void Function();

class FullScreenVideoPlayer extends StatelessWidget {
  final VideoPlayerController controller;
  final bool isFullScreen;
  final VideoExitCallback? onExitFullScreen; // Nuevo callback

  const FullScreenVideoPlayer({super.key, required this.controller,
    this.isFullScreen = false,
    this.onExitFullScreen,});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // 1. Área del Video sensible al clic
            GestureDetector(
              onTap: () => context.read<VideoCubit>().playPause(),
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              ),
            ),

            // 2. Overlay de Play/Pause (CORREGIDO: Reemplazado FAB por IconButton)
            AnimatedOpacity(
              opacity: value.isPlaying ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: Container( // Usamos un Container para darle tamaño circular
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    value.isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 40.0,
                    color: Colors.white,
                  ),
                  onPressed: () => context.read<VideoCubit>().playPause(),
                  padding: const EdgeInsets.all(20),
                ),
              ),
            ),

            // 3. Botón de Pantalla Completa
            if (!isFullScreen) // Solo muestra el botón si NO está en pantalla completa
              Positioned(
                bottom: 10,
                left: 10,
                child: IconButton(
                  icon: const Icon(
                      Icons.fullscreen, color: Colors.white, size: 30),
                  onPressed: () {
                    _goToFullScreen(context, controller);
                  },
                ),
              ),

            // 4. Control de Volumen
            Positioned(
              bottom: 10,
              right: 10,
              child: IconButton(
                icon: Icon(
                  value.volume > 0 ? Icons.volume_up : Icons.volume_off,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () => context.read<VideoCubit>().toggleMute(),
              ),
            ),
          ],
        );
      },
    );
  }

  void _goToFullScreen(BuildContext context, VideoPlayerController controller) {
    // ELIMINAMOS controller.pause() aquí. Dejamos que el video siga.

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (newContext) =>
            FullScreenWrapper(
              controller: controller,
              blocContext: context,
              onExitFullScreen: onExitFullScreen, // Pasamos el callback al Wrapper
            ),
      ),
    ).then((_) {
      // 2. ¡CLAVE AL VOLVER! Ejecutar el callback que reconstruye la vista.
      // La reproducción se manejará dentro del Wrapper (Paso 3).
      onExitFullScreen?.call();
    });
  }
}

// Wrapper simple para simular la pantalla completa
class FullScreenWrapper extends StatelessWidget {
  final VideoPlayerController controller;
  final BuildContext blocContext;
  final VideoExitCallback? onExitFullScreen; // Recibir el callback

  const FullScreenWrapper({
    super.key,
    required this.controller,
    required this.blocContext,
    this.onExitFullScreen, // Recibir el callback
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<VideoCubit>(blocContext),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Builder(
          builder: (childContext) {
            // CLAVE AL ENTRAR: Iniciar la reproducción inmediatamente si está pausado
            Future.delayed(Duration.zero, () {
              if (controller.value.isInitialized && !controller.value.isPlaying) {
                // Si se pausa automáticamente (por Flutter), lo reproducimos de nuevo.
                controller.play();
              }
            });

            return Stack(
                children: [
                  Center(
                    // El reproductor en FullScreen (sin callback)
                    child: FullScreenVideoPlayer(controller: controller, isFullScreen: true),
                  ),

                  // Botón de CERRAR
                  Positioned(
                    top: 40,
                    right: 10,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white, size: 30),
                      onPressed: () {
                        // Al hacer pop, se ejecuta el .then() en la función _goToFullScreen,
                        // el cual llama a onExitFullScreen(), forzando la reconstrucción.
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ]
            );
          },
        ),
      ),
    );
  }
}