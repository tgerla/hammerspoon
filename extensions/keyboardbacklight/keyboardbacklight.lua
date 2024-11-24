--- === hs.keyboardbacklight ===
---
--- Inspect/manipulate keyboard backlight brightness
---
---
---

-- try to load private framework for brightness controls
local state, msg = package.loadlib(
    "/System/Library/PrivateFrameworks/CoreBrightness.framework/Versions/Current/CoreBrightness",
    "*"
)
if not state then
    hs.printf("-- unable to load CoreBrightness framework; may impact brightness control: %s", msg)
end

local module = require("hs.libkeyboardbacklight")

-- private variables and methods -----------------------------------------

-- Public interface ------------------------------------------------------

-- Return Module Object --------------------------------------------------

return module



