import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';

/// Represents the player character in a runner game.
/// Handles movement, collision, animation, and health.
class Player extends SpriteAnimationComponent with Hitbox, Collidable {
  late final SpriteAnimation _runAnimation;
  late final SpriteAnimation _jumpAnimation;
  late final SpriteAnimation _hurtAnimation;

  double _speed = 200.0;
  bool _isJumping = false;
  bool _isHurt = false;
  int _health = 3;
  final double _jumpHeight = 150.0;
  final double _gravity = 1000.0;
  double _yVelocity = 0;
  final double _invulnerabilityTime = 2.0;
  double _invulnerabilityTimer = 0;

  Player() {
    addHitbox(HitboxRectangle());
  }

  @override
  Future<void> onLoad() async {
    _runAnimation = await _loadAnimation('player_run.png', 6);
    _jumpAnimation = await _loadAnimation('player_jump.png', 1);
    _hurtAnimation = await _loadAnimation('player_hurt.png', 1);
    animation = _runAnimation;
  }

  Future<SpriteAnimation> _loadAnimation(String path, int frameCount) async {
    final spriteSheet = await images.load(path);
    final spriteSize = Vector2.all(64.0); // Assuming each frame is 64x64
    return SpriteAnimation.spriteList(
      SpriteSheet(image: spriteSheet, srcSize: spriteSize)
          .createSprites(row: 0, amount: frameCount),
      stepTime: 0.1,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_isHurt && _invulnerabilityTimer > 0) {
      _invulnerabilityTimer -= dt;
      if (_invulnerabilityTimer <= 0) {
        _isHurt = false;
        animation = _runAnimation;
      }
    }

    if (_isJumping) {
      y += _yVelocity * dt - 0.5 * _gravity * dt * dt;
      _yVelocity -= _gravity * dt;

      if (y > position.y) { // Assuming the starting y position is the ground level
        y = position.y;
        _isJumping = false;
        _yVelocity = 0;
        if (!_isHurt) animation = _runAnimation;
      }
    } else {
      // Implement running logic or other ground-based mechanics
    }
  }

  void jump() {
    if (!_isJumping && !_isHurt) {
      _isJumping = true;
      _yVelocity = _jumpHeight;
      animation = _jumpAnimation;
    }
  }

  void takeDamage() {
    if (!_isHurt) {
      _health -= 1;
      _isHurt = true;
      _invulnerabilityTimer = _invulnerabilityTime;
      animation = _hurtAnimation;
      if (_health <= 0) {
        // Handle player death, such as triggering a game over screen
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Obstacle && !_isHurt) {
      takeDamage();
    } else if (other is Collectible) {
      // Handle collectible logic, such as increasing the score
    }
  }
}

/// Represents an obstacle the player must avoid.
class Obstacle extends SpriteComponent with Hitbox, Collidable {
  Obstacle() {
    addHitbox(HitboxRectangle());
  }
}

/// Represents a collectible item the player can collect.
class Collectible extends SpriteComponent with Hitbox, Collidable {
  Collectible() {
    addHitbox(HitboxRectangle());
  }
}