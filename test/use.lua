package.path = "./?.lua"

local wii = require"new_ffi"
local max_wiimotes = 4
local wiimotes = wii:init(max_wiimotes)

local found = wii:find(wiimotes, max_wiimotes, 5)
local connected = wii:connect(wiimotes, max_wiimotes)

while true do
    local info = wii:handle_event(wiimotes, max_wiimotes)
    if info.button == wii.keys["arrow up"] + wii.keys["A"] then
        print("nice")
        wii:set_leds(wiimotes[info.remote], 0x10)
    end
end