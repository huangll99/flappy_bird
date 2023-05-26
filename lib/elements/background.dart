import 'package:flame/components.dart';

class BackgroundComponent extends SpriteComponent {
  BackgroundComponent() : super();

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('bg_day.png');
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    this.size = size;
    position = Vector2.zero();
  }
}
