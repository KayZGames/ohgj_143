import 'package:dartemis/dartemis.dart';

class Controller extends Component {
  bool up, down, left, right;
  
  Controller(
      {this.up: false, this.down: false, this.left: false, this.right: false});
}

class Lander extends Component {}

class Acceleration extends Component {
  double x, y;
  Acceleration(this.x, this.y);
}
class Velocity extends Component {
  double x, y;
  Velocity(this.x, this.y);
}