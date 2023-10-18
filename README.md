# HitboxRemaster
Dynamic Hitboxes &amp; Static Zones

Current version: Beta v1.1.1

For details, please go to https://ladycelastia.github.io/HitboxRemaster

-------------

Change logs

v1.1.1: (18/10/2023)
- New Hitbox property: CopyCFrameProperties. Determines what properties are copied over from Hitbox.CopyCFrame. Defaults to CFrame and Size, and is backward compatible. (issue #3)
- API updated.

v1.1: (17/10/2023)
- Completely overhauled types, works with Roblox Studio intellisense now.
- Hitbox now backtracks if the distance between last frame's position and current frame's position is larger than the Hitbox. (Only works on Sphere shape currently)
- Added Hitbox.PartEntered and Hitbox.PartLeft, both are ScriptSignals of the Hitbox class which fires when **any** part enters or leaves the Hitbox while the Hitbox is active.
- Hitbox now no longer completely ignore characters with a ForceField. Due to this, characters with a ForceField are now registered by Hitbox.Hit, please adjust your scripts accordingly.
- API updated.

v1.0.2c: (10/10/2023)
- Reverted stack tracer parser completely (issue #1)
- Updated examples to include Hitbox:AddIgnore()

v1.0.2b: (10/10/2023)
- Fixed margin erroring when nil (issue #1)
- Fixed stack tracer parser (issue #1)

v1.0.2a: (10/10/2023)
- Fixed Hitbox:IsHitboxBackstab and Hitbox:IsBackstab (issue #2)
- New optional argument (Margin) for Hitbox:IsHitboxBackstab and Hitbox:IsBackstab
- API updated.
- Fixed Sphere shape on hitbox (issue #2)

v1.0.1b: (9/10/2023)
- Stack tracing improvement for ScriptConnection embedded function error (follow-up on issue #1)

v1.0.1a: (9/10/2023)
- Fixed BindToClose and CopyCFrame enum errors (issue #1)
