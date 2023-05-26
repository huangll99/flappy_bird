import 'package:flame/components.dart';

class BackgroundComponent extends SpriteComponent {
  BackgroundComponent() : super();

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('bg_day.png');
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
    size = gameSize;
    position = Vector2.zero();
  }
}
