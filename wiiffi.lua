local wii = {
    wiilua = 0,
    keys = {
        ["arrow up"] = 0x0800,
        ["arrow down"] = 0x0400,
        ["arrow left"] = 0x0100,
        ["arrow right"] = 0x0200,
        ["A"] = 0x0008,
        ["B"] = 0x0004,
        ["minus"] = 0x0010,
        ["plus"] = 0x1000,
        ["home"] = 0x0080,
        ["one"] = 0x0002,
        ["two"] = 0x0001
    }
}

function wii:init(maxWimotes)
local ffi = require("ffi")
ffi.cdef [[
    struct wii_remote_info {
        int button;
        int remote;
        struct {
          int16_t roll;
          int16_t pitch;
          int16_t yaw;
        } controller;
        struct {
          int16_t roll;
          int16_t pitch;
          int16_t yaw;
        } nunchuck;
      };
    void Sleep(int ms);
    int poll(struct pollfd *fds, unsigned long nfds, int timeout);
    typedef struct wiimote_t wiimote;
    short any_wiimote_connected(wiimote** wm, int wiimotes);
    wiimote **init(int MAX_WIIMOTES);
    int find(struct wiimote_t **wm, int max_wiimotes, int timeout);
    int connect(struct wiimote_t **wm, int MAX_WIIMOTES);
    void set_leds(struct wiimote_t *wm, int leds);
    void rumble(struct wiimote_t *wm, int status);
    bool GetKey(const uint64_t value, const uint8_t num_to_check);
    struct wii_remote_info handle_event(wiimote** wiimotes, int MAX_WIIMOTES);
]]
local wiiuse = ffi.load("wiilua")
self.wiilua = wiiuse
return wiiuse.init(maxWimotes)
end
function wii:connect(wiimotes, maxWimotes)
    return self.wiilua.connect(wiimotes, maxWimotes)
end
function wii:find(wiimotes, maxWimotes, number)
    return self.wiilua.find(wiimotes, maxWimotes, number)
end
function wii:handle_event(wiimotes, maxWimotes)
    return self.wiilua.handle_event(wiimotes, maxWimotes)
end
function wii:GetKey(info, key)
    return self.wiilua.GetKey(info, key)
end
function wii:rumble(wiimotes, isok)
    self.wiilua.rumble(wiimotes, isok)
end
function wii:set_leds(wiimotes, led)
    self.wiilua.set_leds(wiimotes, led)
end
function wii.sleep(time)
    ffi.C.Sleep(time*1000)
end
return wii