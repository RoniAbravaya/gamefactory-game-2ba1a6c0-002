import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

/// Represents the main menu scene for the runner game.
class MenuScene extends Component with HasGameRef, TapDetector {
  late TextComponent title;
  late SpriteButton playButton;
  late SpriteButton levelSelectButton;
  late SpriteButton settingsButton;
  late RectComponent background;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _loadBackground();
    _loadTitle();
    _loadPlayButton();
    _loadLevelSelectButton();
    _loadSettingsButton();
  }

  /// Loads the background animation or image.
  void _loadBackground() {
    background = RectComponent(
      position: Vector2.zero(),
      size: gameRef.size,
      paint: Paint()..color = Colors.blue.shade300,
    );
    add(background);
  }

  /// Loads the game title.
  void _loadTitle() {
    title = TextComponent(
      text: 'Test Batch After Fixes-runner-02',
      position: Vector2(gameRef.size.x / 2, gameRef.size.y / 4),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: TextStyle(
          fontSize: 40,
          color: Colors.white,
          shadows: [
            Shadow(
              blurRadius: 7,
              color: Colors.black,
              offset: Offset(3, 3),
            ),
          ],
        ),
      ),
    );
    add(title);
  }

  /// Loads the play button.
  void _loadPlayButton() {
    playButton = SpriteButton(
      button: SpriteComponent(
        sprite: Sprite(gameRef.images.fromCache('play_button.png')),
        size: Vector2(100, 100),
        position: Vector2(gameRef.size.x / 2, gameRef.size.y / 2),
      ),
      onPressed: () {
        // Handle play button press
      },
    );
    add(playButton);
  }

  /// Loads the level select button.
  void _loadLevelSelectButton() {
    levelSelectButton = SpriteButton(
      button: SpriteComponent(
        sprite: Sprite(gameRef.images.fromCache('level_select_button.png')),
        size: Vector2(100, 50),
        position: Vector2(gameRef.size.x / 2, gameRef.size.y * 0.6),
      ),
      onPressed: () {
        // Handle level select button press
      },
    );
    add(levelSelectButton);
  }

  /// Loads the settings button.
  void _loadSettingsButton() {
    settingsButton = SpriteButton(
      button: SpriteComponent(
        sprite: Sprite(gameRef.images.fromCache('settings_button.png')),
        size: Vector2(50, 50),
        position: Vector2(gameRef.size.x - 60, 20),
      ),
      onPressed: () {
        // Handle settings button press
      },
    );
    add(settingsButton);
  }

  @override
  void onTapDown(TapDownInfo info) {
    // Implement tap detection if needed
  }
}