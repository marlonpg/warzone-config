# Setup Verification Checklist

Use this checklist to verify your Godot project is properly set up and ready to run.

## Pre-Flight Checks

### System Requirements
- [ ] Windows 10 or later (or macOS/Linux)
- [ ] 4GB RAM available
- [ ] 500MB disk space
- [ ] Modern graphics card with OpenGL 3.0+ support

### Software Installation
- [ ] Godot 4.0 or newer installed
- [ ] Git installed (for version control)
- [ ] Text editor available (VS Code recommended)

## Project Structure Verification

### Root Directory Files
```
godot_game/
├── project.godot          [ ] ✓ Present
├── README.md              [ ] ✓ Present
├── ARCHITECTURE.md        [ ] ✓ Present
├── QUICKSTART.md          [ ] ✓ Present
├── TESTING.md             [ ] ✓ Present
├── ROADMAP.md             [ ] ✓ Present
└── .gitignore             [ ] ✓ Present
```

### Scenes Directory
```
scenes/
├── player/                [ ] ✓ Directory exists
│   └── Player.tscn        [ ] ✓ Scene file
├── enemies/               [ ] ✓ Directory exists
├── ui/                    [ ] ✓ Directory exists
├── world/                 [ ] ✓ Directory exists
│   └── main.tscn          [ ] ✓ Main scene file
└── hub/                   [ ] ✓ Directory exists
```

### Scripts Directory
```
scripts/
├── systems/               [ ] ✓ Directory exists
│   ├── GameManager.gd     [ ] ✓ File present
│   ├── PlayerStats.gd     [ ] ✓ File present
│   ├── InputManager.gd    [ ] ✓ File present
│   ├── SaveManager.gd     [ ] ✓ File present
│   ├── ParticleEffects.gd [ ] ✓ File present
│   └── DifficultyScaler.gd[ ] ✓ File present
├── player/                [ ] ✓ Directory exists
│   └── Player.gd          [ ] ✓ File present
├── enemies/               [ ] ✓ Directory exists
│   ├── Enemy.gd           [ ] ✓ File present
│   ├── BossEnemy.gd       [ ] ✓ File present
│   ├── Slime.gd           [ ] ✓ File present
│   ├── Rat.gd             [ ] ✓ File present
│   ├── Goblin.gd          [ ] ✓ File present
│   └── GoblinKing.gd      [ ] ✓ File present
├── ui/                    [ ] ✓ Directory exists
│   └── HUD.gd             [ ] ✓ File present
└── world/                 [ ] ✓ Directory exists
    ├── Main.gd            [ ] ✓ File present
    └── DroppedGold.gd     [ ] ✓ File present
```

### Data Directory
```
data/
├── GameSettings.gd        [ ] ✓ File present
├── ContentManager.gd      [ ] ✓ File present
└── (loot tables, zones)   [ ] ✓ Ready for expansion
```

### Assets Directory
```
assets/
├── images/                [ ] ✓ Directory exists (empty OK)
├── sounds/                [ ] ✓ Directory exists (empty OK)
└── fonts/                 [ ] ✓ Directory exists (empty OK)
```

## Godot Project Configuration

### Open in Godot Editor
1. [ ] Launch Godot 4.0+
2. [ ] Click "Open Project"
3. [ ] Navigate to `godot_game/` folder
4. [ ] Select `project.godot`
5. [ ] Click "Open & Edit"

### Verify Project Settings
1. [ ] Project loads without errors
2. [ ] No error messages in Output tab
3. [ ] Main scene set to `res://scenes/world/main.tscn`
4. [ ] Project name: "Tower of Souls"

### Check Input Configuration
**Project → Project Settings → Input Map**

Look for these input actions:
- [ ] `player_light_attack`
- [ ] `player_heavy_attack`
- [ ] `player_dodge`
- [ ] `player_block`
- [ ] `player_sprint`
- [ ] `player_interact`
- [ ] `player_jump`
- [ ] `ui_left`, `ui_right`, `ui_up`, `ui_down`

### Verify Physics Settings
**Project → Project Settings → Physics**

- [ ] 2D physics enabled
- [ ] Default gravity set to 980
- [ ] No custom physics materials that break game

## Game Running Verification

### First Launch
1. [ ] Press **F5** or click Play button
2. [ ] Game launches without crashing
3. [ ] Scene loads (black stickman visible)
4. [ ] No errors in Output/Debug console

### Basic Controls Test
- [ ] **A/D keys**: Character moves left/right
- [ ] **Space**: Character jumps
- [ ] **[** key: Light attack animation plays
- [ ] **]** key: Heavy attack animation plays
- [ ] **Shift**: Block stance
- [ ] **Ctrl**: Dodge roll

### Enemy Spawning
- [ ] Red enemies appear on map
- [ ] Enemies move around (patrolling)
- [ ] Enemies change direction
- [ ] Multiple enemies coexist

### Combat Test
1. [ ] Get close to enemy
2. [ ] Press **[** to attack
3. [ ] Enemy takes damage
4. [ ] Enemy dies after enough damage
5. [ ] Gold appears after enemy dies
6. [ ] Gold amount shown in HUD

### HUD Display
- [ ] Health bar visible (top-left)
- [ ] Stamina bar visible
- [ ] Gold counter shows (starts at 0)
- [ ] Level shows (should be 1)
- [ ] Experience bar visible

## Controller Verification (Optional)

### With Gamepad Connected
1. [ ] Plug in USB gamepad
2. [ ] Press **F5** to run game
3. [ ] Check Output tab for connection message
4. [ ] **Left Stick**: Controls movement
5. [ ] **A Button**: Jump
6. [ ] **X Button**: Light attack
7. [ ] **Y Button**: Heavy attack
8. [ ] **B Button**: Dodge

## Performance Check

### Frame Rate
1. [ ] Open **Debug → Monitor**
2. [ ] Check FPS value
3. [ ] Should maintain 60 FPS steady
4. [ ] No major stuttering

### Memory Usage
1. [ ] Check Memory value in Monitor
2. [ ] Should be reasonable (<200MB at startup)
3. [ ] Doesn't constantly increase

## Code Verification

### Check Core Classes
1. [ ] Open `scripts/player/Player.gd` - compiles without errors
2. [ ] Open `scripts/enemies/Enemy.gd` - compiles without errors
3. [ ] Open `scripts/systems/GameManager.gd` - compiles without errors
4. [ ] No syntax errors reported

### Verify Signals
All signals should be properly defined:
- [ ] Player has `health_changed` signal
- [ ] GameManager has `gold_changed` signal
- [ ] PlayerStats has `level_changed` signal
- [ ] InputManager has action signals

## Documentation Review

- [ ] README.md readable and complete
- [ ] QUICKSTART.md has clear steps
- [ ] ARCHITECTURE.md explains systems
- [ ] TESTING.md provides checklist
- [ ] ROADMAP.md shows development path

## Git Repository Check

```bash
cd godot_game
git status
```

Should show:
- [ ] On branch `main`
- [ ] No uncommitted changes (if you just cloned)
- [ ] History shows initial commit

## Troubleshooting Common Issues

### "Project not found" error
- **Solution**: Ensure `project.godot` is in the root of `godot_game/` folder

### "Script not found" error
- **Solution**: Check file paths match exactly (case-sensitive on Linux/Mac)

### "Scenes don't load" error
- **Solution**: Verify all `.tscn` files are in correct scene directories

### "Game won't start" error
- **Solution**: Check Output tab for specific error message, fix the issue listed

### Low FPS or stuttering
- **Solution**: Reduce enemy count in `Main.gd` or check Monitor for bottleneck

### Controller not detected
- **Solution**: Check Input Map configuration, plug controller into USB port

## Final Sign-Off

When all checks are complete, fill in:

```
System: ___________________
Godot Version: ___________________
Date: ___________________

All checks passed: [ ] Yes [ ] No

Notes/Issues:
___________________________________________
___________________________________________
___________________________________________

Ready to develop: [ ] Yes [ ] No
```

## Next Steps

After verification is complete:

1. **Read QUICKSTART.md** - Start making your first changes
2. **Review ARCHITECTURE.md** - Understand the systems
3. **Follow TESTING.md** - Test your changes
4. **Use ROADMAP.md** - Plan your development

## Support

If you encounter issues:

1. Check the error message in the Output tab
2. See if it matches a known issue in TROUBLESHOOTING
3. Review QUICKSTART.md for common problems
4. Check Godot documentation: https://docs.godotengine.org/

Good luck! Happy game development! 🎮
