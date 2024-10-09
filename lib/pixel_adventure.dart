import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:testing_flame/levels/level.dart';

class PixelAdventure extends FlameGame {

  Color backGroundColor() => const Color(0xFF211F30);

  @override
  late final CameraComponent cam;
  final wordl = Level();


  @override
  FutureOr<void> onLoad() async {

    // Load all images into cache
    await images.loadAllImages();

    cam = CameraComponent.withFixedResolution(
        width: 640, height: 360, world: wordl);

    cam.viewfinder.anchor = Anchor.topLeft;


    addAll([cam,wordl]);
    return super.onLoad();
  }
}
