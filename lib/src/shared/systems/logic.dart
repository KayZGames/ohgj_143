import 'package:dartemis/dartemis.dart';
import 'package:gamedev_helpers/gamedev_helpers_shared.dart';
import 'package:ohgj_143/src/shared/components.dart';

class GravitySystem extends EntityProcessingSystem {
  Mapper<Acceleration> am;

  GravitySystem() : super(new Aspect.forAllOf([Lander, Acceleration]));

  @override
  void processEntity(Entity entity) {
    final a = am[entity];
    a.y = 1.622 * world.delta;
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
    if (l.fuel > 0.0) {
      if (c.down) {
        final a = am[entity];
        l.fuel -= world.delta * 0.1;
        a.y -= 3.0 * world.delta;
        l.fuel = max(l.fuel, 0.0);
      }
    }
  }
}
