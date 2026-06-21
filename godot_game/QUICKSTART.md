# Quick Start Guide - Tower of Souls

Get the game running in 5 minutes and start developing.

## 1. Initial Setup (2 minutes)

### Godot Installation
1. Download Godot 4.0+ from https://godotengine.org/
2. Extract and run `Godot.exe`

### Open the Project
1. Click "Open Project" in Godot
2. Navigate to `godot_game/` folder
3. Click "Open & Edit"

## 2. Your First Game Run (1 minute)

### Launch the Game
- Press **F5** or click the Play button in the top-right
- You should see a black stickman on a gray platform with red enemies
- The game will start at the main test scene

### Test the Controls
**On Keyboard:**
- **A/D** - Move left/right
- **SPACE** - Jump
- **Right Bracket [** - Light Attack
- **Left Bracket ]** - Heavy Attack
- **Shift** - Block
- **Ctrl** - Dodge Roll

**With Controller:**
- **Left Stick** - Movement
- **A Button** - Jump
- **X Button** - Light Attack
- **Y Button** - Heavy Attack
- **B Button** - Dodge

## 3. Understanding the Game Flow (2 minutes)

### What Happens at Startup
1. `scenes/world/main.tscn` loads
2. `scripts/world/Main.gd` creates:
   - GameManager (global state)
   - InputManager (input handler)
   - Player at position (640, 500)
   - Enemy Slimes, Rats, Goblins
   - HUD showing health/stamina/gold

### Game Loop Each Frame
```
InputManager detects input
    ↓
Player processes input
    ↓
Player applies gravity and physics
    ↓
Enemies update AI
    ↓
Render frame
```

## 4. Making Your First Change

### Try This: Increase Player Jump Height

**File**: `scripts/player/Player.gd`

Find line with:
```gdscript
const JUMP_FORCE = -400.0
```

Change to:
```gdscript
const JUMP_FORCE = -500.0
```

Save and press **F5** to run. The player now jumps higher!

### Try This: Spawn More Enemies

**File**: `scripts/world/Main.gd`

Find `create_enemies()` function:
```gdscript
func create_enemies() -> void:
	spawn_enemy("Slime", Vector2(400, 550))
	spawn_enemy("Slime", Vector2(550, 550))
    # ... add more lines:
	spawn_enemy("Goblin", Vector2(200, 550))  # New enemy
	spawn_enemy("Rat", Vector2(1600, 550))    # New enemy
```

## 5. Creating a New Enemy Type

### Step 1: Create Enemy Script
**File**: `scripts/enemies/Bat.gd`

```gdscript
extends Enemy

func _ready() -> void:
	health = 18.0
	max_health = health
	attack_damage = 3.5
	attack_range = 30.0
	chase_range = 300.0  # Flies from far away
	patrol_speed = 80.0
	chase_speed = 150.0  # Fast flyer
	experience_reward = 10
	gold_reward = 4
	super()
```

### Step 2: Add to Main.gd
In `Main.gd`, update `spawn_enemy()`:

```gdscript
func spawn_enemy(enemy_type: String, pos: Vector2) -> void:
	var enemy: Enemy = null
	match enemy_type:
		"Slime":
			enemy = Slime.new()
		"Rat":
			enemy = Rat.new()
		"Goblin":
			enemy = Goblin.new()
		"Bat":  # Add this
			enemy = Bat.new()
    # ... rest of function
```

### Step 3: Spawn Your New Enemy
In `create_enemies()`:
```gdscript
spawn_enemy("Bat", Vector2(300, 400))
```

Press F5 - you now have a flying bat enemy!

## 6. Tweaking Game Balance

### Player Stats (in `scripts/systems/PlayerStats.gd`)
```gdscript
var vitality: int = 10      # Max health multiplier
var strength: int = 10      # Attack damage
var dexterity: int = 10     # Crit chance
var endurance: int = 10     # Stamina pool
var luck: int = 5           # Rare loot chance
```

### Combat (in `scripts/player/Player.gd`)
```gdscript
const MOVE_SPEED = 150.0           # Player walk speed
const SPRINT_MULTIPLIER = 1.5      # Sprint speed boost
const LIGHT_ATTACK_DURATION = 0.5  # Attack animation length
```

### Enemy Properties
Edit enemy script (e.g., `scripts/enemies/Goblin.gd`):
```gdscript
health = 25.0          # How much damage to kill
attack_damage = 5.0    # Damage dealt to player
chase_range = 220.0    # Distance they start chasing
chase_speed = 110.0    # How fast they chase
```

## 7. Debugging Tips

### Enable Debug Output
Add to any script:
```gdscript
print("Current health: ", health)
```

When running, output appears in the **Output** tab at bottom of Godot.

### Pause During Play
Press **Ctrl+P** while running to pause and step through code.

### Watch Variables
In the **Debugger** tab (bottom of editor), add watches:
1. Click "Watch" tab
2. Enter variable name like `player.health`
3. Values update in real-time while playing

## 8. Project Structure Overview

```
godot_game/
├── project.godot           # Project config (don't edit)
├── scenes/                 # Scene files
│   └── world/main.tscn    # Main game scene
├── scripts/
│   ├── systems/           # Core systems
│   ├── player/            # Player scripts
│   ├── enemies/           # Enemy scripts
│   ├── ui/                # UI scripts
│   └── world/             # Level scripts
├── data/                  # Game data & settings
├── assets/                # Images, sounds (empty)
├── README.md             # Overview
├── ARCHITECTURE.md       # Detailed design docs
└── QUICKSTART.md        # This file!
```

## 9. Common Tasks

### Make Enemies Harder
In `scripts/world/Main.gd`, `spawn_enemy()`:
```gdscript
if enemy:
	enemy.health *= 1.5  # 50% more health
	enemy.attack_damage *= 1.25  # Stronger attacks
```

### Give Player More Starting Health
In `scripts/systems/PlayerStats.gd`:
```gdscript
var vitality: int = 15  # Was 10
```

### Add Floating Damage Text
In `scripts/player/Player.gd`, after `take_damage()`:
```gdscript
ParticleEffects.create_damage_popup(global_position, int(damage))
```

### Make a Platform
In `scripts/world/Main.gd`, `create_ground()`:
```gdscript
var platform3 = StaticBody2D.new()
var p3_shape = RectangleShape2D.new()
p3_shape.size = Vector2(300, 20)
# ... add collision, sprite, set position
platform3.position = Vector2(500, 300)
add_child(platform3)
```

## 10. Next Steps

1. **Read ARCHITECTURE.md** - Understand the systems
2. **Extend enemy types** - Create 5+ unique enemies
3. **Add a boss fight** - Create a boss arena
4. **Build the tower** - Add multiple zones/floors
5. **Create hub town** - NPCs, shops, upgrades
6. **Polish visuals** - Add animations and effects

## Keyboard Shortcuts

| Shortcut | Action |
|----------|--------|
| F5 | Play game |
| F6 | Play scene |
| F8 | Debug |
| Ctrl+P | Pause during play |
| Ctrl+Shift+S | Save scene |
| Ctrl+D | Dock debugger |

## Getting Help

- **Godot Docs**: https://docs.godotengine.org/
- **GDScript Guide**: https://docs.godotengine.org/en/stable/getting_started/scripting/gdscript/
- **Godot Forum**: https://forum.godotengine.org/
- **Check error messages** in Output tab

## Pro Tips

1. **Use groups** to find objects: `get_tree().get_first_node_in_group("player")`
2. **Emit signals** for loosely coupled systems
3. **Use @export** to tune values in the Inspector
4. **Create helper scripts** for repeated functionality
5. **Comment your code** for future you

Happy developing! 🎮
