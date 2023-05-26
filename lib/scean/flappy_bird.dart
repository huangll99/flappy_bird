import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/elements/background.dart';
import 'package:flappy_bird/elements/land.dart';

import '../elements/bird.dart';

class FlappyBirdGame extends FlameGame with TapDetector {
  late BackgroundComponent background;
  late LandComponent land;
  late BirdComponent birdComponent;

  @override
  Future<void> onLoad() async {
    background = BackgroundComponent();
    birdComponent = BirdComponent(size);
    land = LandComponent(size, birdComponent);

    await add(background);
    await add(land);
    await add(birdComponent);
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    // 未启动游戏时，启动游戏，并触发一次向上飞的动作
    if ((birdComponent).getCurrentStatus() == BirdComponent.statusBeforeGame) {
      (birdComponent).changeStatus(BirdComponent.statusFlying);
      (birdComponent).flyUp();
      // 游戏中，触发一次向上飞的动作
    } else if ((birdComponent).getCurrentStatus() ==
        BirdComponent.statusFlying) {
      (birdComponent).flyUp();
    } else if ((birdComponent).getCurrentStatus() ==
        BirdComponent.statusGameOver) {
      // 游戏结束，再次点击则回到初始状态
      (birdComponent).reset();
    }
    (land).setAllowMove(!(land).getAllowMove());
  }
}
