# Realistic Airborne (RA)

![Arma 3](https://img.shields.io/badge/Arma%203-Mod-green)
![Build System](https://img.shields.io/badge/Built%20With-HEMTT-blue)
![License](https://img.shields.io/badge/License-APL--SA-orange)

*A realistic static line parachuting system for immersive airborne operations in Arma 3. Built for ACE3 compatibility, it emphasizes realism while remaining modular, performance-friendly, and easy to expand.*

Realistic Airborne provides a complete paratrooper experience, enabling milsim units and airborne teams to conduct immersive drops from a wide variety of aircraft with realistic animation, stance transitions, and parachute handling.

---

## ✨ Features

### 🎯 Core Gameplay
* **Static Line Deployment:** Automatically deploys parachutes when hooked up and jumping from valid aircraft.
* **ACE3 Integration:** Full vehicle interaction support (hookup/unhook via aircraft ACE menu).
* **Stance Control:** Sit, Stand, and Reset logic with visual and animation feedback.
* **Smart Fallback:** Parachute auto-deploys immediately upon exit. If no chute is equipped, the system automatically spawns a fallback chute to ensure safety.
* **Universal Compatibility:** Supports modded parachutes and aircraft via config lists (RHS, CUP, 3CB, Unsung, GM, USAF).

### ⚙️ Technical & Performance
* **HEMTT Build System:** Built using the modern HEMTT toolchain for reliable builds and CI/CD.
* **Modular Structure:** Split into `ra_core` (assets/functions) and `ra_staticline` (logic) for better maintenance.
* **Stateless Logic:** No persistent per-frame handlers or global loops. Scripts only run when a player interacts.
* **Optimized Code:** Uses modern SQF commands (`objectParent`, `configOf`) for maximum efficiency.

---

## ✈️ Compatibility

**Required Mods:**
* [ACE3](https://steamcommunity.com/workshop/filedetails/?id=463939057)
* [CBA_A3](https://steamcommunity.com/workshop/filedetails/?id=450814997)

### Verified Aircraft
* **Vanilla:** UH-80 Ghost Hawk, CH-49 Mohawk, Mi-290 Taru, V-44 Blackfish, Y-32 Xi'an
* **ADFRC:** C-130 Hercules, CH-47 Chinook
* **CUP:** C-130J, CH-47F, UH-60M, UH-1Y, MEDEVAC & Cargo variants
* **RHS:** CH-47F, CH-53E, UH-60M, MEV variants
* **3CB BAF:** Merlin HC3/HC4, Chinook HC1/HC2/HC6, Puma
* **Project OPFOR:** Mi-8MT / MTV
* **Unsung:** CH-47A/D, CH-34, UH-1D
* **Global Mobilization:** Mi-2 Hoplite variants
* **USAF:** C-17 Globemaster III, C-130J Super Hercules

### Supported Parachutes
* **ACE3:** `ACE_NonSteerableParachute`, `ACE_ReserveParachute`
* **Vanilla:** `B_Parachute`
* **CUP:** `CUP_B_ParachutePack`
* **RHS:** `rhsusf_b_parachute`
* **3CB:** `UK3CB_BAF_B_Parachute`
* **Unsung:** `vn_b_pack_t10_01`, `vn_b_pack_ba22_01`, `vn_b_pack_ba18_01`

---

## 🧰 Usage

### 🎮 For Players (How to Jump)
1.  **Board:** Enter a supported aircraft as a passenger.
2.  **Interact:** Look at the aircraft interior (or use interaction key) and open **ACE3 Interaction** (Default: `Windows Key`).
    * *Note: Actions are located in the **Vehicle Interaction** menu.*
3.  **Prepare:**
    * Select **Static Line** → **Stand**.
    * Select **Static Line** → **Hook Up**.
4.  **Jump:** Once hooked, use the **Jump** action (or follow Jumpmaster command).
    * *The parachute will auto-deploy immediately upon exiting.*

### 👨‍💻 For Developers (Building the Mod)
This project uses [HEMTT](https://github.com/BrettMayson/HEMTT) for building.

**Prerequisites:**
* [HEMTT](https://hemtt.dev/) installed and added to your PATH.

**Build Commands:**
```bash
# Check for errors
hemtt check

# Build a development version (unbinarized, fast)
hemtt dev

# Build a release version (binarized, signed, zipped)
hemtt release
```
---

## 📂 Project Structure

```text
Realistic Airborne/
├── .hemtt/                 # HEMTT Configuration
│   └── project.toml
├── addons/
│   ├── ra_core/            # Core assets, UI, Versioning
│   │   ├── functions/
│   │   ├── ui/
│   │   └── config.cpp
│   └── ra_staticline/      # Gameplay logic & ACE Actions
│       ├── functions/
│       └── config.cpp
├── LICENSE
└── README.md
```

---

## 🗓️ Roadmap & Planned Features

* [cite_start][ ] **AI Jumper Support:** Auto jump logic for AI units. [cite: 2]
* [cite_start][ ] **Jumpmaster Authority:** Restrict hookup/jump commands to specific roles/leaders. [cite: 2]
* [cite_start][ ] **Rear Ramp Detection:** Specific support for aircraft ramp-based exits. [cite: 2]
* [cite_start][ ] **Advanced Animations:** Smoother transitions for jump preparation. [cite: 2]
* [cite_start][ ] **HALO/HAHO:** Expansion module for high-altitude operations. [cite: 2]
* [cite_start][ ] **Eden Editor Module:** Plug-and-play setup for mission makers. [cite: 2]

---

## 📜 License

[cite_start]This mod is released under the **Arma Public License Share Alike (APL-SA)**. [cite: 2]
* [cite_start]You **may** modify or repack with proper credit. [cite: 2]
* [cite_start]You **may not** sell this mod or its components. [cite: 2]
* [cite_start]You **must** share any derivatives under the same license. [cite: 2]

---

## 👤 Credits

* [cite_start]**GamingPanthers** – Lead Developer [cite: 1, 2]
* [cite_start]**ACE3 Team** – Interaction and parachute framework [cite: 2]
* [cite_start]**ADFRC Team** – Compatibility support and vehicle integration [cite: 2]
* [cite_start]**VS** – Original concept inspiration [cite: 2]
* [cite_start]**Community Testers** – Feedback and bug reporting [cite: 2]