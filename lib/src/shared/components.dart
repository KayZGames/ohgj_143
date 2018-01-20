import 'package:dartemis/dartemis.dart';

class Controller extends Component {
  bool up, down, left, right;
  
  Controller(
      {this.up: false, this.down: false, this.left: false, this.right: false});
}

class Lander extends Component {
  double fuel;
  Lander(this.fuel);
}

class Alien extends Component {
  double minX, maxX;
  Alien(this.minX, this.maxX);
}

class Acceleration extends Component {
  double x, y;
  Acceleration(this.x, this.y);
}
class Velocity extends Component {
  double x, y;
  Velocity(this.x, this.y);
}