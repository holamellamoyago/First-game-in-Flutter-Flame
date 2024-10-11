import 'dart:async';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/painting.dart';
import 'package:testing_flame/components/player.dart';
import 'package:testing_flame/components/level.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  @override
  Color backGroundColor() => const Color(0xFF211F30);
  late final CameraComponent cam;
  late JoystickComponent joystick;
  Player player = Player(character: 'Ninja Frog');
  bool showJoystick = false;

  @override
  FutureOr<void> onLoad() async {
    // Load all images into cache
    await images.loadAllImages();

    if (!images.containsKey('HUD/Knob.png') ||
        !images.containsKey('HUD/Joystick.png')) {
      print('Error: Las imágenes del joystick no están en la caché.');
      return;
    }

    final wordl = Level(levelName: 'Level-02', player: player);

    cam = CameraComponent.withFixedResolution(
        width: 640, height: 360, world: wordl);

    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, wordl]);

    showJoystick ? addJoystick() : null;

    return super.onLoad();
  }

  @override
  void update(double dt) {
    showJoystick ? updateJoystick(dt) : null; 
    super.update(dt);
  }

  void addJoystick() {
    joystick = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Knob.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Joystick.png'),
        ),
      ),
      margin: const EdgeInsets.only(left: 100, bottom: 64),
      priority: 10,
    );

    add(joystick);
  }

  void updateJoystick(double dt) {
    switch (joystick.direction) {
      case JoystickDirection.upRight:
      case JoystickDirection.upLeft:
      case JoystickDirection.downRight:
      case JoystickDirection.downLeft:
      case JoystickDirection.left:
        player.playerDirection = PlayerDirection.left;
        break;
      case JoystickDirection.upRight:
      case JoystickDirection.right:
        player.playerDirection = PlayerDirection.right;

        break;
      default:
        player.playerDirection = PlayerDirection.none;

        break;
    }
  }
}
