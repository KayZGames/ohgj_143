import 'package:dartemis/dartemis.dart';
import 'package:gamedev_helpers/gamedev_helpers_shared.dart';
import 'package:ohgj_143/src/shared/components.dart';

class GravitySystem extends EntityProcessingSystem {
  Mapper<Acceleration> am;

  GravitySystem() : super(new Aspect.forAllOf([Lander, Acceleration]));

  @override
  void processEntity(Entity entity) {
    final a = am[entity];
    a.y += 1.622 * world.delta;
  }
}

class AccelerationSystem extends EntityProcessingSystem {
  Mapper<Acceleration> am;
  Mapper<Velocity> vm;

  AccelerationSystem() : super(new Aspect.forAllOf([Acceleration, Velocity]));

  @override
  void processEntity(Entity entity) {
    final a = am[entity];
    final v = vm[entity];
    v.x += a.x * world.delta;
    v.y += a.y * world.delta;
  }
}

class MovementSystem extends EntityProcessingSystem {
  Mapper<Velocity> vm;
  Mapper<Position> pm;
  MovementSystem() : super(new Aspect.forAllOf([Velocity, Position]));

  @override
  void processEntity(Entity entity) {
    final v = vm[entity];
    final p = pm[entity];

    p.x += v.x * world.delta;
    p.y += v.y * world.delta;
  }
}

class LanderThrusterSystem extends EntityProcessingSystem {
  Mapper<Controller> cm;
  Mapper<Lander> lm;
  Mapper<Acceleration> am;
  LanderThrusterSystem()
      : super(new Aspect.forAllOf([Lander, Controller, Acceleration]));

  @override
  void processEntity(Entity entity) {
    final c = cm[entity];
    final l = lm[entity];
    final a = am[entity];
    a.x = 0.0;
    a.y = 0.0;
    if (l.fuel > 0.0) {
      if (c.down) {
        l.fuel -= world.delta * 0.075;
        a.y -= 3.0 * world.delta;
      }
      if (c.left) {
        l.fuel -= world.delta * 0.015;
        a.x -= 2.0 * world.delta;
      }
      if (c.right) {
        l.fuel -= world.delta * 0.015;
        a.x += 2.0 * world.delta;
      }
      l.fuel = max(l.fuel, 0.0);
    }
  }
}

class AlienMovementSystem extends EntityProcessingSystem {
  Mapper<Alien> am;
  Mapper<Position> pm;
  Mapper<Velocity> vm;

  AlienMovementSystem()
      : super(new Aspect.forAllOf([Alien, Position, Velocity]));

  @override
  void processEntity(Entity entity) {
    final a = am[entity];
    final v = vm[entity];
    final p = pm[entity];

    if (p.x > a.maxX) {
      v.x = -v.x.abs();
    } else if (p.x < a.minX) {
      v.x = v.x.abs();
    }
  }
}

class LandingSystem extends EntityProcessingSystem {
  Mapper<Velocity> vm;
  Mapper<Position> pm;
  Mapper<Lander> lm;

  LandingSystem() : super(new Aspect.forAllOf([Lander, Position, Velocity]));

  @override
  void processEntity(Entity entity) {
    final p = pm[entity];
    if (p.y >= 0.7) {
      final v = vm[entity];
      if (v.y < 0.1) {
        var l = lm[entity];
        l.score++;
        l.fuel = 1.0;
        p.y = 0.03;
        p.x = 0.5;
        v.x = 0.0;
        v.y = 0.0;
        final minX = -0.2 + random.nextDouble();
        final maxX = minX + 0.3 + random.nextDouble() * 0.9;
        final vx = 0.05 + random.nextDouble() * 0.15;
        world.createAndAddEntity([
          new Position(random.nextDouble(), 0.1 + random.nextDouble() * 0.5),
          new Alien(minX, maxX),
          new Velocity(vx, 0.0)
        ]);
      } else {
        entity
          ..removeComponent(Position)
          ..changedInWorld();
      }
    }
  }
}
