# Procodile

Proc measurment addon for The Burning Crusade 2.4.3.

This is an improved version, based on public release [Procodile-r77248.28](https://www.wowace.com/projects/procodile/files/137688), which made by the original owner Zarnivoop. 

Original project site: https://www.wowace.com/projects/procodile

## Features

Procodile gathers statistics on certain chance-on-use spells, also known as procs. It currently tracks:

 - Number of procs
 - Procs per minute (PPM)
 - Uptime (percentage of time spent tracking)
 - Damage per second (DPS)
 - Min/average/max damage
 - Energy regen on self
 - Energy regen for party/raid per second
 - Estimated internal cooldown

The estimated internal cooldown is the shortest time between two procs in one fight. The DPS is only shown for procs where it makes sense, such as Bandit's Insignia. Likewise, energy regen (Replenishment for instance) is only shown where applicable.

Procs and cooldowns can be announced with combat text messages, screen flashing and shaking, and sounds, to get your attention.

Procodile can show bars for the estimated internal cooldown, and for the duration of aura-style procs, where a temporary buff or debuff is applied to you or your target. The bars can be fully customized.

It will automatically find your worn proc items, enchants, talents, and glyphs. You can also add your own spells to track. You can disable those procs you are not interested in.

Note that not all items, enchants and talents are included. They are hardcoded in since that is the only way of associating, for example, an item with a proc.

Statistics can be displayed through an LDB display addon (a few examples are Titan, Fortress, and DockingStation), or from a minimap button. Proc statistics are also shown in item tooltips.

SharedMedia is recommended for more fonts, textures and sounds.

## Missing a proc, or one not working?
File an issue about it please and I will most likely be able to add/fix it. 
