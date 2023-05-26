import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/scean/flappy_bird.dart';

void main() {
  runApp(
    GameWidget(
      game: FlappyBirdGame(),
    ),
  );
}
