import 'dart:html';

import 'package:dartemis/dartemis.dart';
import 'package:gamedev_helpers/gamedev_helpers_shared.dart';
import 'package:ohgj_143/src/shared/components.dart';

class BackgroundRenderingSystem extends VoidEntitySystem {
  CameraManager cm;
  CanvasRenderingContext2D ctx;

  BackgroundRenderingSystem(this.ctx);

  @override
  void processSystem() {
    ctx
      ..fillStyle = 'black'
      ..fillRect(0, 0, cm.width, cm.height * 0.7)
      ..fillStyle = 'darkgrey'
      ..fillRect(0, cm.height * 0.7, cm.width, cm.height * 0.3);
  }
}

class LanderRenderingSystem extends EntityProcessingSystem {
  CameraManager cm;
  Mapper<Position> pm;
  Mapper<Lander> lm;
  CanvasRenderingContext2D ctx;

  LanderRenderingSystem(this.ctx)
      : super(new Aspect.forAllOf([Position, Lander]));

  @override
  void processEntity(Entity entity) {
    final p = pm[entity];
    final l = lm[entity];
    ctx
      ..fillStyle = 'lightgrey'
      ..fillRect(p.x * cm.width, (p.y - 0.03) * cm.height, 0.015 * cm.width,
          0.03 * cm.height)
      ..strokeStyle = 'white'
      ..fillRect(p.x * cm.width, (p.y - 0.01) * cm.height, 0.015 * cm.width,
          0.01 * cm.height)
      ..fillStyle = 'black'
      ..fillRect((p.x + 0.001) * cm.width, (p.y - 0.012) * cm.height,
          0.013 * cm.width, 0.01 * cm.height)
      ..fillStyle = 'red'
      ..fillRect((p.x + 0.001) * cm.width, (p.y - 0.012 * l.fuel) * cm.height,
          0.013 * cm.width, 0.01 * cm.height * l.fuel);
  }
}

class AlienRenderingSystem extends EntityProcessingSystem {
  Mapper<Position> pm;
  CameraManager cm;
  CanvasRenderingContext2D ctx;

  AlienRenderingSystem(this.ctx)
      : super(new Aspect.forAllOf([Alien, Position]));

  @override
  void processEntity(Entity entity) {
    final p = pm[entity];
    ctx
      ..fillStyle = 'grey'
      ..fillRect((p.x + 0.005) * cm.width, (p.y - 0.005) * cm.height,
          0.01 * cm.width, 0.005 * cm.height)
      ..fillStyle = 'darkgreen'
      ..fillRect(
          p.x * cm.width, p.y * cm.height, 0.02 * cm.width, 0.01 * cm.height);
  }
}

class ScoreRenderingSystem extends EntityProcessingSystem {
  Mapper<Lander> lm;
  CanvasRenderingContext2D ctx;
  ScoreRenderingSystem(this.ctx) : super(new Aspect.forAllOf([Lander]));

  @override
  void processEntity(Entity entity) {
    final l = lm[entity];

    ctx
      ..fillStyle = 'white'
      ..fillText('Sucessful landings: ${l.score}', 0, 0);
  }
}
