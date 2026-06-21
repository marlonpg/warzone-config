# Tower of Souls - Architecture Guide

A comprehensive guide to the game's architecture and systems design.

## Core Design Principles

1. **Modular Systems**: Each system is independent and communicates via signals
2. **Data-Driven**: Game content is defined in data files, not hardcoded
3. **Extensible**: New content can be added without modifying core systems
4. **Signal-Based**: Systems communicate through Godot's signal system
5. **Single Responsibility**: Each class has a clear, focused purpose

## System Architecture

### GameManager (Singleton)
**Location**: `scripts/systems/GameManager.gd`

Central hub for all game state. Manages:
- Player reference
- Global gold amount
- Player stats (via PlayerStats)
- Game pause state
- Save/load functionality

**Key Methods**:
- `add_gold(amount)` - Add currency
- `spend_gold(amount)` - Remove currency (with validation)
- `set_player(node)` - Register the player
- `save_game()` / `load_game()` - Persistence

**Signals**:
- `gold_changed(amount)` - Emitted when gold changes
- `player_died` - Emitted when player dies
- `player_leveled_up(level)` - Emitted on level up

### PlayerStats
**Location**: `scripts/systems/PlayerStats.gd`

Tracks character progression and stat calculations. Manages:
- Character level and experience
- Attributes (Vitality, Strength, Dexterity, Endurance, Luck)
- Derived stats (HP, Stamina, Defense, Crit Chance)

**Key Methods**:
- `add_experience(amount)` - Gain XP, triggers level up
- `level_up()` - Increase all stats and reset experience
- `get_max_hp()` - Calculate max health from stats
- `get_stamina()` - Calculate max stamina
- `get_attack_power()` - Calculate damage output
- `get_defense()` - Calculate damage reduction
- `get_crit_chance()` - Calculate critical hit chance

**Signals**:
- `level_changed(new_level)` - Emitted on level up
- `stat_changed(stat_name, new_value)` - Emitted when stat increases

### InputManager
**Location**: `scripts/systems/InputManager.gd`

Abstracts input from keyboard and controller. Detects connected gamepads and converts both input types to unified signal events.

**Key Methods**:
- `get_movement_input()` - Returns -1.0 to 1.0 for horizontal movement
- `get_vertical_input()` - Returns -1.0 to 1.0 for vertical input
- `is_blocking()` - Returns true if block input is held
- `is_sprinting()` - Returns true if sprint is active
- `check_controller_connection()` - Detect gamepad connection

**Signals**:
- `light_attack` - Emitted on light attack input
- `heavy_attack` - Emitted on heavy attack input
- `dodge` - Emitted on dodge input
- `block` - Emitted on block input
- `jump` - Emitted on jump input
- `interact` - Emitted on interact input
- `sprint_toggled(enabled)` - Emitted when sprint toggles

### Player
**Location**: `scripts/player/Player.gd`

Main player controller. Extends CharacterBody2D.

**State Machine**:
```
IDLE → RUNNING → ATTACKING
     ↓ JUMPING
     ↓ DODGING
     ↓ BLOCKING
     ↓ DYING
```

**Key Properties**:
- `health`, `max_health` - Current and max HP
- `stamina`, `max_stamina` - Current and max stamina
- `current_state` - Current state enum
- `facing_right` - Direction the player faces

**Key Methods**:
- `_physics_process(delta)` - Main update loop
- `handle_input(delta)` - Process input
- `apply_gravity(delta)` - Apply downward velocity
- `update_state(delta)` - Update state-specific logic
- `update_animation()` - Sync animations to state
- `take_damage(damage)` - Reduce health
- `die()` - Handle death and respawn

**Attack System**:
- Light attacks: 10 stamina cost, 0.5s duration, instant AoE damage
- Heavy attacks: 25 stamina cost, 0.8s duration, larger damage radius
- Dodge rolls: 15 stamina cost, 0.4s invulnerability (framework ready)
- Blocking: 2 stamina/second, reduces incoming damage by 25%

## Enemy System

### Enemy (Base Class)
**Location**: `scripts/enemies/Enemy.gd`

Base class for all enemies. Extends CharacterBody2D.

**State Machine**:
```
IDLE → PATROL → CHASE → ATTACK → HURT → DYING
```

**Key Properties**:
- `health` - Current health
- `attack_damage` - Damage dealt to player
- `chase_range` - Distance at which enemy starts chasing
- `patrol_speed`, `chase_speed` - Movement speeds
- `experience_reward`, `gold_reward` - Drops on death

**Key Methods**:
- `update_ai(delta)` - AI decision making
- `take_damage(damage)` - Reduce health
- `die()` - Handle death, emit rewards
- `deal_attack()` - Deal damage to player

**AI Behavior**:
1. **IDLE**: Stand still, randomly transition to PATROL
2. **PATROL**: Walk back and forth at patrol speed
3. **CHASE**: Move toward player at chase speed when in range
4. **ATTACK**: Stop and attack when player is in attack range
5. **HURT**: Brief stun after taking damage
6. **DYING**: Play death animation, drop loot, disappear

### Enemy Types

#### Slime
**File**: `scripts/enemies/Slime.gd`
- Health: 15
- Damage: 3
- Speed: 40 (patrol) / 80 (chase)
- XP: 5, Gold: 2

#### Rat
**File**: `scripts/enemies/Rat.gd`
- Health: 20
- Damage: 4
- Speed: 60 / 130
- XP: 8, Gold: 3

#### Goblin
**File**: `scripts/enemies/Goblin.gd`
- Health: 25
- Damage: 5
- Speed: 55 / 110
- XP: 12, Gold: 5

### BossEnemy (Advanced)
**Location**: `scripts/enemies/BossEnemy.gd`

Extends Enemy with phase mechanics:
- Phases trigger at 66% and 33% health
- Each phase: cooldown reduces, speed increases, damage increases
- Special attack behavior available per phase

#### GoblinKing (Boss)
**File**: `scripts/enemies/GoblinKing.gd`
- Health: 150
- Three combat phases
- Special attacks in phases 2 and 3

## Game Systems

### ParticleEffects
**Location**: `scripts/systems/ParticleEffects.gd`

Visual feedback system with particle effects:
- Damage numbers floating above hits
- Death particle bursts
- Hit sparks
- Critical hit effects

### SaveManager
**Location**: `scripts/systems/SaveManager.gd`

Persistence system for game saves:
- Up to 3 save slots
- JSON-based storage
- Saves player position, stats, gold, settings
- Auto-load on startup

### GameSettings
**Location**: `data/GameSettings.gd`

Global configuration:
- Difficulty settings (Easy/Normal/Hard/Challenge)
- Audio volumes
- Graphics options
- Input device preferences
- Camera smoothing
- Performance settings

### ContentManager
**Location**: `data/ContentManager.gd`

Data-driven content system:
- Loot tables per enemy type
- Zone definitions
- NPC data
- Loot rolling system

## Signal Flow Example

### Combat Sequence

```
Player Input
    ↓
InputManager emits light_attack
    ↓
Player._on_light_attack()
    ↓
Player creates attack area and checks overlaps
    ↓
For each enemy in overlap:
    Enemy.take_damage(damage)
        ↓
    Enemy changes to HURT state
    Enemy.take_damage() → Enemy.die()
        ↓
    GameManager.add_gold(enemy.gold_reward)
    PlayerStats.add_experience(enemy.experience_reward)
        ↓
    PlayerStats emits stat_changed / level_changed
        ↓
    HUD updates display
```

## Extending the Game

### Adding a New Enemy Type

1. Create new script extending Enemy:
```gdscript
extends Enemy

func _ready() -> void:
    health = 35.0
    max_health = health
    attack_damage = 7.0
    attack_range = 35.0
    chase_range = 250.0
    patrol_speed = 65.0
    chase_speed = 120.0
    experience_reward = 15
    gold_reward = 8
    super()
```

2. Add to Main.gd's spawn_enemy function
3. Add loot table entry in ContentManager

### Adding a New Zone

1. Create new scene extending Node2D
2. Add ground platforms and obstacles
3. Spawn enemies appropriate to zone difficulty
4. Connect to main tower via exit/entrance transitions
5. Define zone data in ContentManager

### Adding a Boss

1. Extend BossEnemy
2. Customize phase mechanics
3. Add special attack patterns
4. Define loot rewards
5. Create arena with environmental hazards

## Performance Considerations

### Optimization Tips

1. **Physics**: Use collision layers to reduce physics calculations
2. **Enemies**: Implement distance culling for off-screen enemies
3. **Particles**: Limit concurrent effects with pooling
4. **Animations**: Simplify animations for less important entities
5. **Pathfinding**: Use simple chase logic rather than A*

### Memory Management

- Pool frequently spawned objects (projectiles, effects)
- Clean up signals on node destruction
- Use `queue_free()` instead of manual deletion
- Monitor with Godot's profiler

## Testing Checklist

- [ ] Player movement in all directions
- [ ] Jump mechanics on various platform heights
- [ ] Attack damage and range
- [ ] Stamina consumption and regeneration
- [ ] Enemy spawn and AI behavior
- [ ] Loot drops and collection
- [ ] Gold gain and spending
- [ ] Experience and leveling
- [ ] Save/load functionality
- [ ] Keyboard and controller input
- [ ] UI updates
- [ ] Performance at 60 FPS

## Known Limitations & TODOs

### Current Limitations
- No animation frame data (placeholder animations)
- No sound system integrated
- Simple 2D sprites (no animated spritesheet)
- Collision-based attack detection (no hitbox system)

### Future Improvements
- Proper skeletal animation system
- 3D particle effects
- Advanced AI with pathfinding
- Equipment system with stat modifications
- Inventory and UI polish
- Multiplayer/PvP mechanics
- Status effect system
- Environmental puzzles

## File Organization Best Practices

```
Feature files should follow:
scripts/
├── {feature}/
│   ├── {feature}Main.gd      # Primary script
│   ├── {feature}Helper.gd    # Supporting script
│   └── {feature}Config.gd    # Configuration (optional)
```

Keep scenes organized by feature and gameplay purpose, not by type.
