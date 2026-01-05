import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';

/// A component representing an obstacle in a runner game.
/// It includes a visual representation, collision detection, and movement behavior.
class Obstacle extends PositionComponent with HasHitboxes, Collidable {
  final Vector2 gameSize;
  final int damage;
  final String spritePath;
  late SpriteComponent _spriteComponent;

  /// Creates an instance of an obstacle.
  /// [gameSize] is the size of the game screen to help position the obstacle.
  /// [damage] is the amount of damage or penalty the obstacle inflicts on collision.
  /// [spritePath] is the path to the sprite image for the obstacle.
  Obstacle({
    required this.gameSize,
    this.damage = 1,
    this.spritePath = 'assets/images/obstacle.png',
  });

  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Load and set the sprite for the obstacle
    final sprite = await Sprite.load(spritePath);
    _spriteComponent = SpriteComponent(sprite: sprite, size: Vector2(50, 50));
    add(_spriteComponent);

    // Set the position of the obstacle to appear from the right edge of the screen
    position = Vector2(gameSize.x, gameSize.y / 2);

    // Add a hitbox for collision detection
    final hitboxShape = HitboxRectangle(relation: Vector2(1.0, 1.0));
    addHitbox(hitboxShape);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // Move the obstacle to the left to simulate movement towards the player
    position.add(Vector2(-100 * dt, 0));

    // Remove the obstacle if it goes off screen to the left
    if (position.x < -size.x) {
      removeFromParent();
    }
  }

  /// Handles the logic when a collision is detected with this obstacle.
  /// It can be overridden to implement specific game logic like damage application.
  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    // Implement collision handling logic here, e.g., apply damage
  }
}