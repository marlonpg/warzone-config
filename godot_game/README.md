# Tower of Souls - A Souls-Like Platformer

A 2D side-scrolling Souls-like platformer inspired by Dark Souls, Hollow Knight, and Tower of Druaga, built with Godot 4.0+.

## Project Structure

```
godot_game/
├── project.godot              # Godot project configuration
├── scenes/                    # Scene files (.tscn)
│   ├── player/
│   ├── enemies/
│   ├── ui/
│   ├── world/
│   └── hub/
├── scripts/                   # GDScript source code
│   ├── systems/              # Core game systems
│   │   ├── GameManager.gd    # Global game state
│   │   ├── PlayerStats.gd    # Character progression
│   │   └── InputManager.gd   # Input handling
│   ├── player/               # Player-related scripts
│   │   └── Player.gd         # Main player controller
│   ├── enemies/              # Enemy AI and types
│   │   ├── Enemy.gd          # Base enemy class
│   │   ├── Slime.gd
│   │   ├── Rat.gd
│   │   └── Goblin.gd
│   ├── ui/                   # UI scripts
│   │   └── HUD.gd            # Heads-up display
│   └── world/                # World/level scripts
│       ├── Main.gd           # Main scene logic
│       └── DroppedGold.gd    # Dropped loot
├── assets/                   # Game assets
│   ├── images/               # Sprites and textures
│   ├── sounds/               # Audio files
│   └── fonts/                # Font files
└── data/                     # Game data
```

## Setup Instructions

1. **Install Godot 4.0+** from https://godotengine.org/

2. **Open the project:**
   - Launch Godot
   - Click "Open Project"
   - Navigate to `godot_game/` folder
   - Open `project.godot`

3. **Run the game:**
   - Press `F5` or click the Play button
   - The game will start in the main test scene

## Controls

### Keyboard
- **A/D or ← →**: Move left/right
- **W or ↑**: Look up / Climb
- **S or ↓**: Look down
- **SPACE**: Jump
- **Right Shift**: Sprint (consumes stamina)
- **Right Bracket [**: Light Attack
- **Left Bracket ]**: Heavy Attack
- **Left Ctrl**: Dodge Roll
- **Shift**: Block
- **E**: Interact

### Controller (Gamepad)
- **Left Stick**: Movement
- **A Button**: Jump
- **X Button**: Light Attack
- **Y Button**: Heavy Attack
- **B Button**: Dodge Roll
- **LB**: Block
- **RB**: Light Attack (alternate)
- **Start**: Sprint

## Core Systems

### Player System
- **Stats**: Vitality, Strength, Dexterity, Endurance, Luck
- **Health/Stamina**: Dynamic based on character stats
- **Combat**: Light/Heavy attacks with stamina costs
- **Mobility**: Dodge rolls, jumping, sprinting
- **Defense**: Blocking and damage reduction

### Combat System
- Stamina management for all actions
- Attack types: Light (fast, low damage) and Heavy (slow, high damage)
- Dodge rolls for evasion (invincibility frames coming)
- Block stance to reduce incoming damage
- Enemy AI with patrol, chase, and attack states

### Progression System
- Experience gains from defeating enemies
- Leveling up increases all stats
- Loot drops from enemies
- Gold collection for upgrades
- Death penalty: dropped gold that can be recovered

### Enemy System
- Base Enemy class with configurable stats
- AI states: Idle, Patrol, Chase, Attack
- Different enemy types:
  - **Slime**: Slow, weak
  - **Rat**: Fast, weak
  - **Goblin**: Balanced threat
- Enemy mixing: Encounters can combine multiple enemy types

## Game Features

### Implemented
- ✅ Player movement and jumping
- ✅ Keyboard and controller input
- ✅ Light and heavy attacks
- ✅ Stamina system
- ✅ Enemy AI (patrol, chase, attack)
- ✅ Damage system
- ✅ Death and respawn
- ✅ Experience and leveling
- ✅ Gold collection
- ✅ HUD with stats display

### In Progress / TODO
- [ ] Boss encounters
- [ ] More enemy types (Skeletons, Necromancers, etc.)
- [ ] Equipment system (armor, weapons)
- [ ] Inventory management
- [ ] Hub town with NPCs
- [ ] Smooth animations
- [ ] Particle effects
- [ ] Sound effects and music
- [ ] Save/load system
- [ ] Multiple zones/floors
- [ ] Environmental hazards
- [ ] Status effects (poison, burn, etc.)
- [ ] Multiplayer features (invasion/cooperation)

## Development Roadmap

### Phase 1: Core Mechanics (Current)
- Foundation systems
- Player movement and combat
- Basic enemy AI
- Progression mechanics

### Phase 2: Content
- Multiple enemy types
- Boss encounters
- Multiple zones
- Environmental variety

### Phase 3: Polish
- Animations and visual effects
- Audio design
- UI/UX improvements
- Balance adjustments

### Phase 4: Features
- Equipment and loadouts
- Advanced progression systems
- More complex AI
- World interconnection

## Architecture Notes

### GameManager
- Singleton pattern for global state
- Tracks player stats, gold, game state
- Emits signals for UI updates

### InputManager
- Abstracts keyboard and controller input
- Emits signals for player actions
- Handles controller detection

### Player
- CharacterBody2D with state machine
- Manages health, stamina, equipment
- Responds to input and enemy attacks

### Enemy
- Base class for all enemies
- Simple AI with state machine
- Configurable stats for variety
- Extends for specialized behaviors

## Best Practices

1. **Extend, don't modify**: Create new enemy types by extending Enemy class
2. **Use signals**: Emit signals for game state changes
3. **Group organization**: Use groups for player/enemies/NPCs
4. **Delta-time scaling**: All timing uses delta for frame-rate independence
5. **Modular design**: Systems are independent and can be extended

## Performance Tips

- Use collision layers to optimize physics
- Batch animations where possible
- Implement object pooling for frequently spawned objects
- Use culling for off-screen enemies
- Monitor FPS in debug console

## Debugging

Press `Ctrl+D` while playing to open the debug console:
- View error messages
- Monitor performance metrics
- Check entity counts

## License

Production-ready game template. Feel free to modify and extend.

## Credits

Game Design inspired by:
- Dark Souls (FromSoftware)
- Hollow Knight (Team Cherry)
- Salt and Sanctuary (Ska Studios)
- Tower of Druaga (Namco)
