hs.keyboardbacklight = require("hs.keyboardbacklight")

function testGet()
  local value = hs.keyboardbacklight.get()
  assertIsNumber(value)
  return success()
end

function testSet()
  local value = hs.keyboardbacklight.get()
  hs.keyboardbacklight.set(0)
  assertIsEqual(0, hs.keyboardbacklight.get())
  hs.keyboardbacklight.set(50)
  assertIsEqual(50, hs.keyboardbacklight.get())
  hs.keyboardbacklight.set(100)
  assertIsEqual(100, hs.keyboardbacklight.get())

  -- Be polite and put the backlight back where it was
  hs.keyboardbacklight.set(value)

  return success()
end
