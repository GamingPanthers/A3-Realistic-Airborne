# Realistic Airborne (RA)

*A modern, realistic, and modular static line parachuting system for Arma 3, rewritten from scratch with ACE3 and CBA integration.*

---

## ✨ Features

- 🎯 **Static Line Parachuting**
  - Deploys parachutes automatically when hooked and jumping from altitude
  - ACE-based interaction for stand up, hook up, jump, unhook
  - Validates equipment and player status before allowing jump

- 🎒 **Hook/Stand Logic**
  - Players must be standing and hooked to initiate jump
  - Full ACE interaction system with intuitive conditions

- ⚙️ **Modular Settings (CBA)**
  - Toggle static chute requirement
  - Define custom parachute class
  - Enable/disable NVG removal on reserve chute deployment

- 🔄 **Performance Friendly**
  - No persistent loops or global polling
  - Stateless when not in use
  - Lightweight per-user logic only when interacting

---

## ✈️ Supported Aircraft

Static Line Jump is available from the following aircraft types:

| Aircraft | Mod |
|----------|-----|
| **C-130J** | CUP |
| **CH-47F / CH-53E** | RHS |
| **Merlin HC3/4** | 3CB |
| **Blackfish (Vehicle/Infantry)** | Vanilla |
| **UH-80 Ghosthawk** | Vanilla |
| **Mi-290 Taru** | Vanilla |
| **Any custom aircraft** | (if altitude > 100 and player in cargo) |

---

## 🧰 Usage

### 🎮 How to Jump

1. Enter a supported aircraft as a **passenger**
2. Open **ACE self-interaction** (while inside the aircraft)
3. Select `Static Line` → `Stand Up` → `Hook Up`
4. When hooked and standing, the `Static Line Jump` option appears
5. Use `Static Line Jump` when ready

---

## 🛠 Settings (via CBA)

Accessible through **CBA Addon Settings** in Eden or in-game:

| Setting | Description | Default |
|--------|-------------|---------|
| `RA_StaticEquipped` | Requires static parachute equipped to jump | `true` |
| `RA_ChuteClass` | Overrides parachute spawn class (leave blank for vanilla) | `""` |
| `RA_NODsFriendly` | Prevents NVG removal during reserve deployment | `true` |

---

## 🧪 Development Checklist – Base-Up Build

This mod is built with priority on **user interaction** and **performance efficiency**.

### Phase 1: Core Interaction
- [x] ACE Self-Interaction: Static Line menu
- [x] Stand Up / Sit Down logic
- [x] Hook Up / Unhook logic
- [x] Jump action when valid

### Phase 2: Jump Execution
- [x] Ejects player and matches velocity/direction
- [x] Uses equipped chute if valid
- [x] Spawns fallback chute if not
- [x] Adds ACE reserve chute
- [x] Cleans up variables post-jump

### Phase 3: Settings & Optimization
- [x] All settings exposed via CBA
- [x] Graceful handling of bad backpacks
- [x] No runtime loops or tick overhead
- [x] Stateless when not used

### Planned
- [ ] Jumpmaster enforcement
- [ ] AI jumper support
- [ ] Ramp-only aircraft logic
- [ ] HALO/HAHO expansion
- [ ] Eden Editor module
- [ ] Helmet/NVG failure realism (optional)

---

## 🔧 Directory Structure



```
Realistic Airborne/
├── addons/
│ └── ra_staticline_core/
│ ├── config/
│ ├── functions/
│ ├── xeh/
│ ├── config.cpp
│ └── mod.cpp
├── mod.cpp
```
---

## 📜 License

This project is licensed under the [GNU General Public License v3.0 (GPLv3)](./LICENSE).

---

## 👤 Credits

- **Original Mod Concept & Inspiration:** *Valice Studios*  
  (Authors of the original ACE Static Line mod)

- **Rewritten By:** *Gaming Panthers (2025)*  
  Built from the ground up using modern standards

- **Frameworks Used:**
  - [ACE3](https://ace3mod.com) – Advanced Combat Environment
  - [CBA_A3](https://github.com/CBATeam/CBA_A3) – Community Base Addons

Special thanks to the Arma 3 modding community for their tools, documentation, and shared knowledge.
