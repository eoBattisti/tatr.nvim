# add possible opts to the plugin

- STATUS: OPEN
- PRIORITY: 100
- TAGS: feat

Add some opts that can modified by the user and modify the behavior at wich the command are used,
for example:

```lua
{
    options = {
        ls = '-c -id', -- this would be appended automaticaly when the user runs `Tatr ls`
        init = '...',
        ref = '...',
        ...
    }
}
```
