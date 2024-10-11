import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:testing_flame/components/player.dart';

class Level extends World {
  late TiledComponent level;
  final String levelName;
  final Player player;

  Level({required this.levelName, required this.player});

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load('$levelName.tmx', Vector2.all(16), priority: 0);

    add(level);

    final spawnPointsPlayer =
        level.tileMap.getLayer<ObjectGroup>('SpawnPoints');
    for (final spawnPoint in spawnPointsPlayer!.objects) {
      switch (spawnPoint.class_) {
        case "Player":
          player.position = Vector2(spawnPoint.x, spawnPoint.y);
          add(player);
          break;
        default:
      }
    }

    // add(Player(character: 'Pink Man'));

    return super.onLoad();
  }
}
