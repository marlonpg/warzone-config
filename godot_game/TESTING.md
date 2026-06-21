# Testing Guide - Tower of Souls

Comprehensive testing checklist to ensure quality and functionality.

## Pre-Test Setup

1. Ensure Godot 4.0+ is installed
2. Project is open in Godot editor
3. No error messages in Output tab
4. Both keyboard and gamepad are available

## Functional Tests

### Player Movement

- [ ] **Move Left**: Press A or ← - player moves left
- [ ] **Move Right**: Press D or → - player moves right
- [ ] **Stop Movement**: Release movement keys - player stops smoothly
- [ ] **Face Direction**: Player sprite flips to match movement direction
- [ ] **Walking Animation**: Walking animation plays during movement
- [ ] **Idle Animation**: Idle animation plays when stationary
- [ ] **Controller Movement**: Left stick moves player smoothly
- [ ] **Deadzone**: Small stick movements don't register (deadzone works)

### Jumping

- [ ] **Jump**: Press Space - player jumps
- [ ] **Jump Height**: Jump height is reasonable (about 100 pixels)
- [ ] **Double Jump Prevention**: Can't jump while in air
- [ ] **Jump Animation**: Jump animation plays
- [ ] **Fall Animation**: Falling animation plays
- [ ] **Platform Landing**: Player lands correctly on platforms
- [ ] **Jump Controller**: A button on gamepad triggers jump
- [ ] **Max Fall Speed**: Player doesn't fall infinitely fast

### Combat - Light Attacks

- [ ] **Trigger Attack**: Press [ or X button - light attack triggers
- [ ] **Attack Range**: Attack hits enemies in front of player
- [ ] **Attack Damage**: Enemies take damage and lose health
- [ ] **Attack Direction**: Attack only hits in facing direction
- [ ] **Stamina Cost**: Player stamina decreases by 10
- [ ] **Attack Cooldown**: Can't spam attacks (has cooldown)
- [ ] **Attack Animation**: Attack animation plays for 0.5s
- [ ] **Enemy Knockback**: Enemies react to being hit
- [ ] **Damage Number**: Damage popup appears (if particles enabled)

### Combat - Heavy Attacks

- [ ] **Trigger Heavy**: Press ] or Y button - heavy attack triggers
- [ ] **Higher Damage**: Heavy damage > light attack damage (1.5x)
- [ ] **Larger Range**: Heavy attack hits larger area
- [ ] **Stamina Cost**: Costs 25 stamina (more than light)
- [ ] **Animation**: Longer animation (0.8s)
- [ ] **Stun Duration**: Player is locked during attack
- [ ] **Knockback**: Larger knockback effect

### Dodge Mechanic

- [ ] **Trigger Dodge**: Press Ctrl or B button - dodge activates
- [ ] **Direction**: Dodge goes in facing direction
- [ ] **Distance**: Travels ~200 pixels
- [ ] **Duration**: Completes in 0.4 seconds
- [ ] **Stamina**: Costs 15 stamina
- [ ] **Animation**: Dodge animation plays
- [ ] **Cooldown**: Can't spam dodge (has brief cooldown)

### Blocking

- [ ] **Activate Block**: Press Shift - block stance activates
- [ ] **Block Pose**: Player takes blocking animation
- [ ] **Damage Reduction**: Player takes less damage (25% reduction)
- [ ] **Stamina Drain**: Costs 2 stamina/second while blocking
- [ ] **Stamina Depletion**: Can't block if no stamina
- [ ] **Movement While Blocking**: Can move while blocking
- [ ] **Attack While Blocking**: Can't attack while blocking

### Stamina System

- [ ] **Starting Stamina**: Player has max stamina at game start
- [ ] **Attack Cost**: Stamina decreases on attack
- [ ] **Block Cost**: Stamina decreases while blocking
- [ ] **Dodge Cost**: Stamina decreases when dodging
- [ ] **Sprint Cost**: Stamina decreases while sprinting
- [ ] **Regeneration**: Stamina regenerates over time
- [ ] **Bar Display**: Stamina bar shows current/max
- [ ] **Empty Stamina**: Player can't perform stamina actions when empty

### Health System

- [ ] **Starting Health**: Player has max health at game start
- [ ] **Take Damage**: Health decreases when hit by enemy
- [ ] **Death**: Player dies when health reaches 0
- [ ] **Bar Display**: Health bar shows current/max
- [ ] **Damage Number**: Damage amount floats above player
- [ ] **Defense Calculation**: Damage reduction based on vitality stat
- [ ] **Healing**: Healing items restore health (when implemented)

## Enemy Tests

### Enemy AI - Slime

- [ ] **Spawn**: Slimes appear at correct positions
- [ ] **Idle State**: Slimes stand still initially
- [ ] **Patrol**: Slimes walk back and forth
- [ ] **Chase**: Slimes chase player when player is visible
- [ ] **Attack**: Slimes attack when close to player
- [ ] **Damage**: Slime attacks reduce player health
- [ ] **Death**: Slimes die with correct health threshold
- [ ] **Loot Drop**: Slimes drop gold on death (5 gold)
- [ ] **Experience**: Player gains XP on Slime death (5 XP)

### Enemy AI - Rat

- [ ] **Fast Movement**: Rats move faster than slimes
- [ ] **Chase Range**: Rats chase from further away
- [ ] **Attack Speed**: Rats attack more frequently
- [ ] **Higher Damage**: Rats deal more damage than slimes
- [ ] **Gold Drop**: Rats drop 3 gold
- [ ] **XP Drop**: Rats give 8 XP

### Enemy AI - Goblin

- [ ] **Balanced Stats**: Goblins are balanced threat
- [ ] **Group Behavior**: Multiple goblins work together
- [ ] **Higher Challenge**: Goblins are noticeably harder
- [ ] **Gold Drop**: Goblins drop 5 gold
- [ ] **XP Drop**: Goblins give 12 XP

### Enemy AI - General

- [ ] **Physics**: Enemies use gravity and fall
- [ ] **Platform Navigation**: Enemies use platforms correctly
- [ ] **Pathing**: Enemies patrol without getting stuck
- [ ] **Target Switching**: Enemies switch targets appropriately
- [ ] **Edge Behavior**: Enemies don't walk off platforms
- [ ] **State Transitions**: Smooth transitions between AI states
- [ ] **Multiple Enemies**: Multiple enemies work together

## Progression Tests

### Experience System

- [ ] **XP Gain**: Player gains XP when defeating enemies
- [ ] **XP Display**: XP bar shows progress to next level
- [ ] **Level Up**: Player levels up at XP threshold
- [ ] **XP Reset**: XP resets after level up
- [ ] **Threshold Scaling**: XP requirement increases each level

### Leveling System

- [ ] **Stat Increase**: All stats increase on level up
- [ ] **HP Increase**: Max health increases with vitality
- [ ] **Stamina Increase**: Max stamina increases with endurance
- [ ] **Damage Increase**: Attack damage increases with strength
- [ ] **Level Display**: Level shows in HUD
- [ ] **Multiple Level Ups**: Can level up multiple times
- [ ] **Higher Levels**: Game gets progressively harder

### Gold System

- [ ] **Gold Pickup**: Player collects gold from defeated enemies
- [ ] **Gold Display**: HUD shows current gold amount
- [ ] **Gold Persistence**: Gold is retained between encounters
- [ ] **Gold on Death**: Gold is dropped when player dies
- [ ] **Gold Recovery**: Dropped gold can be picked up again
- [ ] **Gold Loss**: Gold is lost if player dies a second time before recovery

## UI Tests

### HUD Display

- [ ] **Health Bar**: Shows correctly and updates
- [ ] **Stamina Bar**: Shows correctly and updates
- [ ] **Gold Display**: Shows current gold amount
- [ ] **Level Display**: Shows character level
- [ ] **XP Bar**: Shows progress to next level
- [ ] **Bar Colors**: Health=green, Stamina=cyan, correct colors
- [ ] **Text Readability**: All text is readable
- [ ] **No Overlap**: HUD doesn't overlap gameplay area

### Camera

- [ ] **Follow Player**: Camera follows player movement
- [ ] **Smooth Movement**: Camera movement is smooth (not jerky)
- [ ] **Vertical Bounds**: Camera has proper vertical limits
- [ ] **Horizontal Freedom**: Camera can pan horizontally
- [ ] **View Distance**: Can see sufficient area ahead

## Input Tests

### Keyboard Input

- [ ] **All Keys Responsive**: All keys work without delay
- [ ] **Movement Keys**: A/D or ←/→ work correctly
- [ ] **Action Keys**: Attack/dodge/block keys work
- [ ] **Jump**: Space bar works
- [ ] **Multiple Inputs**: Can move and attack simultaneously
- [ ] **Key Repeat**: No repeat delay issues
- [ ] **Shift Key**: Sprint toggle works smoothly

### Controller Input

- [ ] **Controller Detection**: Game detects plugged-in gamepad
- [ ] **Analog Stick**: Left stick controls smooth movement
- [ ] **Buttons**: All face buttons trigger correct actions
- [ ] **Shoulder Buttons**: LB/RB work for block/special
- [ ] **Stick Deadzone**: Small stick movements are ignored
- [ ] **Multiple Inputs**: Can use multiple buttons simultaneously
- [ ] **Triggers**: LT/RT can be used (if implemented)
- [ ] **Vibration**: Vibration feedback works (optional)

## Performance Tests

### Frame Rate

- [ ] **60 FPS Target**: Game maintains 60 FPS
- [ ] **No Major Stutters**: No sudden frame drops
- [ ] **Consistent Performance**: FPS stays stable
- [ ] **Combat Performance**: FPS holds during combat
- [ ] **Multiple Enemies**: Performance with 10+ enemies
- [ ] **Particle Effects**: Performance with effects enabled

### Memory

- [ ] **Memory Stable**: Memory usage doesn't constantly increase
- [ ] **No Memory Leaks**: Long play sessions don't accumulate garbage
- [ ] **Respawn Clean**: Respawning doesn't leak memory
- [ ] **Enemy Despawn**: Dead enemies are properly cleaned up

### Load Times

- [ ] **Startup Time**: Game launches reasonably fast
- [ ] **Scene Changes**: Level transitions are fast
- [ ] **Save/Load**: Save and load operations complete quickly

## Edge Case Tests

### Boundary Conditions

- [ ] **0 Health**: Player dies at exactly 0 HP
- [ ] **0 Stamina**: Player can't act with 0 stamina
- [ ] **Max Stats**: Stats don't overflow at high levels
- [ ] **Screen Edges**: Player can't go off-screen
- [ ] **Platform Edges**: Player doesn't fall through platforms

### Unusual Scenarios

- [ ] **Rapid Fire Attacks**: Can spam attacks without crashes
- [ ] **Simultaneous Damage**: Multiple enemies hitting at once
- [ ] **Death During Attack**: Death properly cancels attack
- [ ] **Dodge into Attack**: Dodging into enemy doesn't cause issues
- [ ] **Block Empty Stamina**: Blocking stops when stamina empty
- [ ] **Sprint No Stamina**: Sprint stops when stamina empty

## Balance Tests

### Difficulty

- [ ] **Early Game**: First enemies pose manageable challenge
- [ ] **Mid Game**: Progression feels challenging but fair
- [ ] **Enemy Mix**: Varied enemies keep gameplay interesting
- [ ] **Stat Progression**: Level ups feel meaningful
- [ ] **Loot Value**: Equipment upgrades matter

### Combat Balance

- [ ] **Light vs Heavy**: Heavy has clear advantage
- [ ] **Attack Damage**: Damage numbers feel satisfying
- [ ] **Enemy Threat**: Enemies pose real danger
- [ ] **Defense Value**: Defense actually reduces damage
- [ ] **Stamina Economy**: Stamina management is tactical

## Quality of Life Tests

### Visual Clarity

- [ ] **Sprite Clarity**: All sprites are visible and clear
- [ ] **Color Contrast**: Player clearly distinct from enemies
- [ ] **Animation Readability**: Animations clearly show action
- [ ] **Effect Visibility**: Damage numbers are visible
- [ ] **No Visual Glitches**: No clipping, z-fighting, etc.

### Feedback

- [ ] **Hit Feedback**: Clear indication when hitting enemies
- [ ] **Damage Feedback**: Damage is clearly shown
- [ ] **Death Feedback**: Clear death screen/respawn
- [ ] **Stat Feedback**: Stats updates are visible
- [ ] **Audio Feedback**: Sound cues (when implemented)

## Regression Tests

After making changes, verify:

- [ ] Player still moves correctly
- [ ] All enemies still spawn and AI works
- [ ] Combat system still functions
- [ ] No new error messages
- [ ] FPS still good
- [ ] No crashes

## Test Report Template

```
Date: [DATE]
Tester: [NAME]
Build: [VERSION]
Platform: [OS]
Godot: [VERSION]

Test Results:
- [ ] Passed: X
- [ ] Failed: Y
- [ ] Blocked: Z

Critical Issues:
[List any blocking issues]

Major Issues:
[List any serious problems]

Minor Issues:
[List non-critical bugs]

Suggestions:
[List improvement ideas]

Status: [PASS/FAIL]
```

## Known Issues & Workarounds

### Current Known Issues
- Animation placeholder system (visual feedback present)
- No sound system yet
- No advanced particle effects yet
- Collision-based damage (no advanced hitbox system)

### Workarounds
- Use particle effects module when available
- Monitor performance if adding many effects
- Test with various screen resolutions

## Automated Testing Ideas

```gdscript
# Example test script
func test_player_damage():
    var player = get_node("Player")
    var initial_health = player.health
    player.take_damage(10)
    assert(player.health == initial_health - 10)
```

See Test-Driven Development guide for full testing framework.

## Performance Profiling

Use Godot's built-in profiler:
1. Run game with F5
2. Open Debugger tab
3. Check "Monitor" subtab
4. Watch FPS, Memory, Physics

## Sign-Off

- [ ] All critical tests passed
- [ ] No blocking issues remain
- [ ] Performance acceptable
- [ ] Ready for release

**Tested By**: _______________
**Date**: _______________
**Version**: _______________
