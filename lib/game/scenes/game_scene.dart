import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

class GameScene extends Component with Tappable {
  late Player player;
  late ScoreDisplay scoreDisplay;
  final List<Obstacle> obstacles = [];
  final List<Collectible> collectibles = [];
  int score = 0;
  bool isGameOver = false;
  bool isGamePaused = false;

  @override
  Future<void>? onLoad() async {
    // Initialize player, score display, and start the game loop
    player = Player();
    scoreDisplay = ScoreDisplay();
    add(player);
    add(scoreDisplay);
    startGameLoop();
  }

  void startGameLoop() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (!isGameOver && !isGamePaused) {
        spawnObstacle();
        spawnCollectible();
        increaseDifficulty();
      } else {
        timer.cancel();
      }
    });
  }

  void spawnObstacle() {
    // Logic to spawn obstacles at intervals
    final obstacle = Obstacle();
    obstacles.add(obstacle);
    add(obstacle);
  }

  void spawnCollectible() {
    // Logic to spawn collectibles at intervals
    final collectible = Collectible();
    collectibles.add(collectible);
    add(collectible);
  }

  void increaseDifficulty() {
    // Logic to increase game difficulty over time
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isGameOver) return;

    // Check for collisions with obstacles
    for (final obstacle in obstacles) {
      if (player.collidesWith(obstacle)) {
        gameOver();
        break;
      }
    }

    // Check for collectible pickups
    for (final collectible in collectibles) {
      if (player.collidesWith(collectible)) {
        score += collectible.value;
        collectible.removeFromParent();
        collectibles.remove(collectible);
        scoreDisplay.updateScore(score);
        break;
      }
    }
  }

  void gameOver() {
    isGameOver = true;
    // Show game over screen or logic
  }

  @override
  bool onTapUp(TapUpInfo info) {
    if (isGameOver) {
      // Possibly restart the game or show menu
    } else if (!isGamePaused) {
      player.jump();
    }
    return super.onTapUp(info);
  }

  void pauseGame() {
    isGamePaused = true;
    // Pause game logic or show pause menu
  }

  void resumeGame() {
    isGamePaused = false;
    // Resume game logic
  }
}

class Player extends SpriteComponent {
  void jump() {
    // Player jump logic
  }

  bool collidesWith(Component component) {
    // Collision detection logic
    return false;
  }
}

class Obstacle extends SpriteComponent {
  // Obstacle logic
}

class Collectible extends SpriteComponent {
  final int value = 10;

  // Collectible logic
}

class ScoreDisplay extends Component {
  int score = 0;

  void updateScore(int newScore) {
    score = newScore;
    // Update displayed score
  }
}