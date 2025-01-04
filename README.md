# qbox_weapon_jam
# FiveM Weapon Jam Script

This script introduces a feature to FiveM where there is a chance for a weapon to jam during a shootout. The chance of malfunction is based on the weapon's condition, which deteriorates over time. The script uses **ox_lib** and **ox_inventory** to track and modify the weapon's condition, creating a more dynamic and realistic gameplay experience.

## Key Features:
- **Weapon Jam Chance**: The chance of an weapon malfunction increases as its condition deteriorates.
- **Integration with ox_inventory**: Tracks the weapon's condition using the `ox_inventory` resource.
- **Dynamic Probability**: The lower the condition of the weapon, the higher the chance of a jam during gunfights.
- **Unjam Mechanism**: If the weapon jams, players must rapidly press a designated key to unjam it and continue shooting. If they fail, the weapon remains jammed.

## Installation

1. Download or clone this repository.
2. Copy the folder into the `resources` directory of your FiveM server.
3. Add to your `server.cfg`.

## Dependencies
- **ox_lib**: For utility functions and core functionality.
- **ox_inventory**: To track the condition of weapons.

## Configuration
- Modify the **malfunction probability** and **weapon condition thresholds** in the `config.lua` file.
  - Adjust the default weapon condition.
  - Configure how much deterioration impacts the malfunction chance.
  
## How It Works
- When a player fires a weapon, the script checks the weapon's condition.
- If the weapon's condition is low, the script calculates a chance of the weapon jamming.
- If the weapon jams, the player must rapidly press a designated key to unjam it. If unsuccessful, the weapon stays jammed until the issue is resolved.

## Usage Example
- **High Condition Weapon**: 5% chance of jamming.
- **Low Condition Weapon**: 50% chance of jamming.

## Suggestions and Improvements
We welcome suggestions and improvements to enhance this script. If you have any ideas or contributions, feel free to open an issue or create a pull request.

## License
Feel free to use and modify this script as you wish. Please consider contributing back with any improvements or bug fixes.

---

**Enjoy your enhanced gunfight experience!**
