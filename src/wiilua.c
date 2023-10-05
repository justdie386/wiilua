#include <stdio.h>
#include <wiiuse.h>

typedef BOOL bool;
// all i did was make a simple wrapper around wiiuse so that luajit's ffi
// doesn't need to handle the userdata being passed between wiiuse_poll and
// the event functions and i made it return the button being pressed AND which
// remote was pressed to allow for handling more than 1 wii remote :)
#ifdef _WIN32
#define EXPORT __declspec(dllexport)
#else
#define EXPORT __attribute__((visibility("default")))
#endif
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

short any_wiimote_connected(wiimote **wm, int wiimotes) {
  int i;
  if (!wm) {
    return 0;
  }

  for (i = 0; i < wiimotes; i++) {
    if (wm[i] && WIIMOTE_IS_CONNECTED(wm[i])) {
      return 1;
    }
  }

  return 0;
}

struct wii_remote_info wii_remote(struct wiimote_t *wm,
                                  struct wii_remote_info *info) {
  info->button = wm->btns;
  return *info;
  if (wm->exp.type == EXP_NUNCHUK || wm->exp.type == EXP_MOTION_PLUS_NUNCHUK) {
    struct nunchuk_t *nc = (nunchuk_t *)&wm->exp.nunchuk;
    info->nunchuck.roll = nc->orient.roll;
    info->nunchuck.yaw = nc->orient.yaw;
    info->nunchuck.pitch = nc->orient.pitch;
  }
  if (WIIUSE_USING_ACC(wm)) {
    info->controller.roll = wm->orient.roll;
    info->controller.pitch = wm->orient.pitch;
    info->controller.yaw = wm->orient.yaw;
  }
  return *info;
}

wiimote EXPORT **init(int MAX_WIIMOTES) {
  wiimote **wiimotes = wiiuse_init(MAX_WIIMOTES);
  return wiimotes;
}

int EXPORT find(struct wiimote_t **wm, int max_wiimotes, int timeout) {
  return wiiuse_find(wm, max_wiimotes, timeout);
}

int EXPORT connect_remote(struct wiimote_t **wm, int MAX_WIIMOTES) {
  return wiiuse_connect(wm, MAX_WIIMOTES);
}

void EXPORT set_leds(struct wiimote_t *wm, int leds) {
  wiiuse_set_leds(wm, leds);
}
void EXPORT rumble(struct wiimote_t *wm, int status) {
  wiiuse_rumble(wm, status);
}
bool EXPORT GetKey(const uint64_t value, const uint64_t num_to_check) {
    return (value & num_to_check) == num_to_check;
}
struct wii_remote_info EXPORT handle_event(wiimote **wiimotes, int MAX_WIIMOTES) {
  struct wii_remote_info info;
  if (wiiuse_poll(wiimotes, MAX_WIIMOTES)) {
    int i = 0;
    for (; i < MAX_WIIMOTES; ++i) {
      switch (wiimotes[i]->event) {
      case WIIUSE_EVENT:
        info = wii_remote(wiimotes[i], &info);
        info.remote = i;
        break;
      default:
        break;
      }
    }
  }
  return info;
}