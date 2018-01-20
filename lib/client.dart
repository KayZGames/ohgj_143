library client;

import 'package:ohgj_143/shared.dart';
import 'package:ohgj_143/src/shared/components.dart';
import 'package:gamedev_helpers/gamedev_helpers.dart';
import 'package:ohgj_143/src/shared/systems/logic.dart';

import 'src/client/systems/events.dart';
import 'src/client/systems/rendering.dart';

class Game extends GameBase {
  Game() : super.noAssets('ohgj_143', '#game');

  @override
  void createEntities() {
    addEntity([
      new Controller(),
      new Position(0.5, 0.05),
      new Lander(1.0),
      new Acceleration(0.0, 0.0),
      new Velocity(0.0, 0.0)
    ]);

    for (int i = 0; i < 5; i++) {
      final minX = -0.2 + random.nextDouble();
      final maxX = minX + 0.3 + random.nextDouble() * 0.9;
      final vx = 0.05 + random.nextDouble() * 0.15;
      addEntity([
        new Position(random.nextDouble(), 0.1 + random.nextDouble() * 0.5),
        new Alien(minX, maxX),
        new Velocity(vx, 0.0)
      ]);
    }
  }

  @override
  Map<int, List<EntitySystem>> getSystems() {
    return {
      GameBase.rendering: [
        new ControllerSystem(),
        new LanderThrusterSystem(),
        new GravitySystem(),
        new AccelerationSystem(),
        new AlienMovementSystem(),
        new MovementSystem(),
        new CanvasCleaningSystem(canvas),
        new BackgroundRenderingSystem(ctx),
        new AlienRenderingSystem(ctx),
        new LanderRenderingSystem(ctx),
        new FpsRenderingSystem(ctx, fillStyle: 'black'),
      ],
      GameBase.physics: [
        // add at least one
      ]
    };
  }

  @override
  void handleResize(int width, int height) {
    width = max(800, width);
    height = max(450, height);
    if (width / height > 16 / 9) {
      width = (16 * height) ~/ 9;
    } else if (width / height < 16 / 9) {
      height = (9 * width) ~/ 16;
    }
    super.handleResize(width, height);
  }
}
