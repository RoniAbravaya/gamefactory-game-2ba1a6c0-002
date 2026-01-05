import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';

/// Represents the player character in the runner game.
/// Handles animations, movement, jumping, and collision detection.
class Player extends SpriteAnimationComponent
    with HasGameRef, Hitbox, Collidable, KeyboardHandler {
  double _speed = 200.0;
  double _jumpHeight = -300.0;
  bool _isJumping = false;
  Vector2 _gravity = Vector2(0, 1000);
  final double _groundHeight;
  int _lives = 3;
  int _score = 0;

  /// Animation states for the player.
  late final SpriteAnimation _runAnimation;
  late final SpriteAnimation _jumpAnimation;
  late final SpriteAnimation _idleAnimation;

  Player(this._groundHeight, SpriteAnimation idleAnimation, SpriteAnimation runAnimation, SpriteAnimation jumpAnimation)
      : _idleAnimation = idleAnimation,
        _runAnimation = runAnimation,
        _jumpAnimation = jumpAnimation,
        super(animation: idleAnimation, size: Vector2(50, 75), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    animation = _runAnimation;
    addHitbox(HitboxRectangle());
  }

  @override
  void update(double dt) {
    super.update(dt);
    y += _speed * dt;

    // Gravity
    velocity.add(_gravity * dt);
    position.add(velocity * dt);

    // Ground check
    if (position.y > _groundHeight) {
      position.y = _groundHeight;
      _isJumping = false;
      velocity.y = 0;
      animation = _runAnimation;
    }

    // Update score based on player's survival time or other criteria
    _score++;
  }

  /// Handles player input for jumping.
  @override
  bool onKeyEvent(RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.space) && !_isJumping) {
      _jump();
      return true;
    }
    return false;
  }

  /// Makes the player jump.
  void _jump() {
    _isJumping = true;
    velocity.y = _jumpHeight;
    animation = _jumpAnimation;
  }

  /// Handles collision with obstacles.
  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Obstacle) {
      _lives--;
      if (_lives <= 0) {
        // Handle game over logic here
      }
    }
  }

  /// Increases the player's score.
  void increaseScore(int points) {
    _score += points;
  }

  /// Returns the current score of the player.
  int get score => _score;

  /// Returns the current number of lives the player has.
  int get lives => _lives;
}