import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/sprite.dart';
import 'package:flame_audio/flame_audio.dart';

/// A collectible item component for a runner game that can be picked up by the player.
/// It includes collision detection, a score value, optional animation, and a sound effect on collection.
class Collectible extends SpriteComponent with HasGameRef, Hitbox, Collidable {
  /// The score value this collectible adds to the player's score upon collection.
  final int scoreValue;

  /// The path to the sound effect file that will be played when this collectible is collected.
  final String collectionSound;

  /// Creates a new instance of a collectible item.
  ///
  /// [sprite] is the visual representation of the collectible.
  /// [size] is the size of the collectible.
  /// [position] is the position of the collectible in the game world.
  /// [scoreValue] is the amount of score this collectible gives to the player upon collection.
  /// [collectionSound] is the path to the sound effect that plays upon collection.
  Collectible({
    required Sprite sprite,
    required Vector2 size,
    required Vector2 position,
    this.scoreValue = 100,
    this.collectionSound = 'coin_pickup.mp3',
  }) : super(sprite: sprite, size: size, position: position) {
    addShape(HitboxRectangle());
  }

  @override
  Future<void>? onLoad() async {
    await super.onLoad();
    // Optional: Add animation or additional setup here
  }

  /// Handles the logic when this collectible is collected by the player.
  void collect() {
    // Play the collection sound effect
    FlameAudio.play(collectionSound);

    // Optional: Add any additional effects or logic for when the collectible is collected

    // Remove the collectible from the game
    removeFromParent();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    // Check if the colliding entity is the player or a player-like entity
    // This part may need to be adjusted based on your game's specific player class or identifier
    if (other is Player) { // Assuming there's a Player class that represents the player
      collect();
    }
  }
}