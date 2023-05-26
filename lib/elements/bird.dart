import 'package:flame/components.dart';

const double birdSize = 48;
const double maxMoveYAxisBeforeGame = 20;

class BirdComponent extends SpriteAnimationComponent {
  static int statusBeforeGame = 0x00;
  static int statusFlying = 0x01;
  static int statusGameOver = 0x02;

  BirdComponent(this.screenSize, [this.onStatusChangeCallback])
      : super(size: Vector2(birdSize, birdSize), anchor: Anchor.center);

  Vector2 screenSize;
  Function? onStatusChangeCallback;

  double currentMoveYAxisBeforeGame = 0;
  bool moveDirectionUp = true;
  int currentStatus = statusBeforeGame;
  double axisYSpeed = 0.5;

  @override
  Future<void> onLoad() async {
    List<Sprite> sprites = [];
    if (currentStatus == statusBeforeGame) {
      sprites.add(await Sprite.load('bird0_1.png'));
    }
    animation = SpriteAnimation.spriteList(sprites, stepTime: 0.1);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    screenSize = size;
    position = Vector2(size.x / 2, (size.y - 96) / 2);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (currentStatus == statusBeforeGame) {
      _moveUpAndDown();
    } else if (currentStatus == statusFlying) {
      _freeFly();
    }
  }

  void _moveUpAndDown() {
    if (moveDirectionUp) {
      position.sub(Vector2(0, 0.5));
    } else {
      position.add(Vector2(0, 0.5));
    }
    currentMoveYAxisBeforeGame++;
    if (currentMoveYAxisBeforeGame >= maxMoveYAxisBeforeGame) {
      moveDirectionUp = !moveDirectionUp;
      currentMoveYAxisBeforeGame = 0;
    }
  }

  void _freeFly() {
    if (position.y >= screenSize.y - 96) {
      position.y = screenSize.y - 96;
      changeStatus(statusGameOver);
    } else if (position.y <= 0 + 12) {
      position.y = 13;
      axisYSpeed = 0;
    } else {
      position.add(Vector2(0, axisYSpeed));
      axisYSpeed += 0.3;
    }
  }

  void changeStatus(int status) async {
    if (currentStatus == status) return;
    currentStatus = status;
    List<Sprite> sprites = [];
    if (currentStatus == statusFlying) {
      sprites.add(await Sprite.load('bird0_0.png'));
      sprites.add(await Sprite.load('bird0_1.png'));
      sprites.add(await Sprite.load('bird0_2.png'));
    } else if (currentStatus == statusBeforeGame) {
      sprites.add(await Sprite.load('bird0_1.png'));
    } else {
      sprites.add(await Sprite.load('bird0_1.png'));
    }
    animation = SpriteAnimation.spriteList(sprites, stepTime: 0.1);
    if (onStatusChangeCallback != null) {
      onStatusChangeCallback!(currentStatus);
    }
  }

  void flyUp() {
    if (currentStatus == statusBeforeGame) {
      changeStatus(statusFlying);
    }
    axisYSpeed = -5;
  }

  void reset() {
    changeStatus(statusBeforeGame);
    position = Vector2(screenSize.x / 2, (screenSize.y - 96) / 2);
    axisYSpeed = 0;
  }

  int getCurrentStatus() {
    return currentStatus;
  }

  Vector2 getPosition() {
    return position;
  }
}
