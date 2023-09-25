import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';

void main() {
  Flame.device.setLandscape();
  runApp(const MaterialApp(home: SafeArea(child: Scaffold(body:
    GameWidget<Engine>.controlled(gameFactory: Engine.new),
  ))));
}

class Engine extends FlameGame {
  late Scene scene;
  late CameraComponent cameraComponent;

  @override
  Future<void> onLoad() async {
    await images.load("cube.png");
    scene = Scene();
    cameraComponent = CameraComponent(world: scene);
    addAll([scene, cameraComponent]);
  }
}

class Scene extends World with HasGameRef<Engine> {
  late List<SpriteComponent> sprites;

  @override
  Future<void> onLoad() async {
    sprites = List.empty(growable: true);
    for (int x = -1; x < 2; x++) {
      for (int y = -1; y < 2; y++) {
        sprites.add(SpriteComponent(
          anchor: Anchor.center,
          position: Vector2(x * 96, y * 96),
          size: Vector2(64, 64),
          sprite: Sprite(game.images.fromCache("cube.png")),
        ));
      }
    }
    addAll(sprites);
  }
}
