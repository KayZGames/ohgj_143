import 'dart:html';

import 'package:dartemis/dartemis.dart';
import 'package:gamedev_helpers/gamedev_helpers_shared.dart';

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
