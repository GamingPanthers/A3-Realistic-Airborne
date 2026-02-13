# 📦 Realistic Airborne: Detailed Feature Set

This document provides an in-depth look at the features of Realistic Airborne (RA), categorized for players and developers.

---

## 🎮 Community & Player Features

### ✈️ ACE3 Vehicle Interaction
Unlike legacy mods, RA actions are tied to the aircraft itself. Look at the interior or interact with the vehicle to access the "Static Line" menu.

### 🚶 Stance & Prep Logic
* **Sit / Stand**: Players can manually stand up in cargo to prepare for a jump.
* **Hooking Up**: A mandatory safety step where the player attaches their static line to the aircraft.
* **Equipment Check**: An optional action to verify if your current backpack is a compatible parachute.

### 🪂 Parachute Handling
* **Auto-Deployment**: Parachutes open immediately upon exit—no manual keypress required.
* **Safety Fallback**: If you jump without a chute, the system spawns an emergency fallback to prevent a total "splat".
* **Mod Support**: Out-of-the-box support for RHS, CUP, 3CB, USAF, Unsung, and Global Mobilization.

---

## 🛠 Developer & Technical Features

### 🏗 Modular Architecture
* **ra_core**: Handles UI assets, versioning macros, and master initialization.
* **ra_staticline**: Houses the actual gameplay logic and ACE3 action definitions.

### ⚡ Performance Optimization
* **Stateless Logic**: RA does not use `onEachFrame` or heavy persistent loops. Code only executes during interaction or exit events.
* **Modern SQF**: Uses `objectParent` (replaces `vehicle`) and `configOf` (replaces `typeOf`) for the fastest possible engine execution.

### 🛠 Build System (HEMTT)
* Uses the **HEMTT** build tool for automated binarization, PBO packing, and version management.
* Configuration is managed via `.hemtt/project.toml`.

### 🔗 Integration
* **CBA XEH**: Uses Extended Event Handlers for reliable, conflict-free initialization.
* **CBA Settings**: Mission makers can customize min/max altitudes and parachute requirements via the CBA Addon Settings menu.