local ffi = require("ffi")

ffi.cdef[[
    struct info {int button;int remote;};
    typedef struct wiimote_t wiimote;
    short any_wiimote_connected(wiimote** wm, int wiimotes);
    int handle_event(struct wiimote_t* wm);
    wiimote** init(int MAX_WIIMOTES);
    int find(struct wiimote_t** wm, int max_wiimotes, int timeout);
    int connect(struct wiimote_t** wm, int MAX_WIIMOTES);
    void set_leds(struct wiimote_t* wm, int leds);
    void rumble(struct wiimote_t* wm, int status);
    struct info is_pressed(wiimote** wiimotes, int MAX_WIIMOTES);
]]

local wiilua = ffi.load("wiilua")

local wiimotes = wiilua.init(4)
local found = wiilua.find(wiimotes, 4, 5)
if found then
    print("found wii remote")
else
    print("not found")
end
local connected = wiilua.connect(wiimotes, 4)
if connected then
    print("connected")
else
    print("not connected")
end

function love.load()
    -- Set up Love2D window
    love.window.setTitle("Wiimote Button Tester")
    love.window.setMode(600, 75)
    love.graphics.setFont(love.graphics.newFont(24))

    -- Initialize a variable to store the pressed button
    pressedButton = "None"  -- Initialize the variable here
end

function love.update(dt)
    -- Handle Wiimote events
    local info = wiilua.is_pressed(wiimotes, 4)

    if info.button == 1 then
        wiilua.rumble(wiimotes[info.remote], 1)
        pressedButton = "A".."| Player: "..info.remote
    elseif info.button == 2 then
        wiilua.rumble(wiimotes[info.remote], 0)
        pressedButton = "B".." | Player: "..info.remote
    elseif info.button == 3 then
        pressedButton = "Arrow Up".." | Player: "..info.remote
        wiilua.set_leds(wiimotes[info.remote], 0x10)
    elseif info.button == 4 then
        pressedButton = "Arrow Left".." | Player: "..info.remote
        wiilua.set_leds(wiimotes[info.remote], 0x20)
    elseif info.button == 5 then
        pressedButton = "Arrow Right".."| Player: "..info.remote
        wiilua.set_leds(wiimotes[info.remote], 0x40)
    elseif info.button == 6 then
        pressedButton = "Arrow Down".." | Player: "..info.remote
        wiilua.set_leds(wiimotes[info.remote], 0x80)
    elseif info.button == 7 then
        pressedButton = "Minus Button".." | Player: "..info.remote
    elseif info.button == 8 then
        pressedButton = "Plus Button".." | Player: "..info.remote
    elseif info.button == 9 then
        pressedButton = "Button 1".." | Player: "..info.remote
    elseif info.button == 10 then
        pressedButton = "Button 2".." | Player: "..info.remote
    elseif info.button == 11 then
        pressedButton = "Button home".." | Player: "..info.remote
    end
end

function love.draw()
    love.graphics.clear()
    love.graphics.print("Button Pressed: " .. pressedButton, 30, 25)
end
