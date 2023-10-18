# Home
HitboxRemaster is a stand-alone ModuleScript that provides easy and performant dynamic Hitboxes and static Zones.

*Why HitboxRemaster?*

- **Easy to use** - Clear and concise class API, ready for simple operations in just a few lines.
- **Type-safe** - Extensively typed. Safe to use in a strict-typechecking environment.
- **Powerful** - Libraries like Trajectory and Metafunctions to enable advanced use-cases.
- **Customizable** - Customize the behavior of individual Hitboxes and Zones with properties and methods.
- **Performant** - Blazingly-fast to run and use. (Details in (root)/Benchmark)
- **Object-oriented** - Everything in this module are objects, enabling compatibility with different programming paradigms.
- **Memory-proof** - Automatic garbage-collect operations. Manual garbage-collect can be initiated on every class with simple methods.
- **Replication** - Fully usable on both server and client. (**WARNING:** The Hitbox and Zone serials may overlap across server and client. You need to handle such scenarios yourself)

If anything is missing or broken, [file an issue on github](https://github.com/LadyCelastia/HitboxRemaster/issues) or message me on discord (lady_celestia).

> **Disclaimer**: HitboxRemaster is not thoroughly tested in a production environment yet. Production-stability is not guaranteed, although any issue found will be fixed.

# Installation
Both Studio and VSCode:

Copy the [code of HitboxRemaster](https://github.com/LadyCelastia/HitboxRemaster/blob/main/src/init.lua) into a ModuleScript, then require the ModuleScript on the Script or LocalScript you want to use it in.

roblox-ts:
gg



Read the Examples page for a quickstart guide. Alternatively, you can read the API page for a more in-depth guide.

You are free to use and modify HitboxRemaster, for personal or commercial use, with or without credit (though some credit would be nice <3). However, you cannot claim that you made HitboxRemaster.
