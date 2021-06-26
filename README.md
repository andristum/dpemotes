# dpemotes
Emotes / Animations for fiveM with Prop support.

Installation Instructions:

add dpemotes to your server.cfg

start dpemotes

Other instructions please check the fivem forum thread

https://forum.fivem.net/t/dpemotes-356ish-emotes-usable-while-walking-props-and-more/843105

### Emote trigger events

Client sided emote trigger example:
```lua
TriggerEvent('EmoteCommandStart', {"handsup"})
```

Server sided emote trigger example:
```lua
TriggerClientEvent('EmoteCommandStart', source, {"handsup"})
```
