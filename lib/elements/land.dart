import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flappy_bird/elements/bird.dart';

class LandComponent extends ParallaxComponent {
  LandComponent(this.screenSize, this.birdComponent)
      : super(size: Vector2(screenSize.x, 96));
  Vector2 screenSize;
  bool _allowMove = true;
  final BirdComponent birdComponent;

  @override
  Future<void> onLoad() async {
    parallax = await gameRef.loadParallax(
      [
        ParallaxImageData('land.png'),
      ],
      baseVelocity: Vector2(60, 0),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (birdComponent.getCurrentStatus() == BirdComponent.statusGameOver) {
      parallax?.baseVelocity = Vector2(0, 0);
    } else {
      parallax?.baseVelocity = Vector2(60, 0);
    }
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    screenSize = size;
    size = Vector2(screenSize.x, 96);
    position = Vector2(0, screenSize.y - 96);
  }

  bool getAllowMove() {
    return _allowMove;
  }

  void setAllowMove(bool allowMove) {
    _allowMove = allowMove;
  }
}
