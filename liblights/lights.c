/*
 * Copyright (C) 2013 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


#define LOG_TAG "lights"

#include <hardware/lights.h>

#include <cutils/log.h>

#include <errno.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>

/******************************************************************************/

#define BACKLIGHT_FILE "/sys/class/leds/lcd-backlight/brightness"
#define BUTTONS_FILE "/sys/class/leds/button-backlight/brightness"

static int g_buttons_on = 0;
static int g_battery_on = 0;
static int g_notifications_on = 0;
static int g_attention_on = 0;

static int
write_int(char const* path, int value)
{
    static int already_warned = 0;
    int fd = open(path, O_RDWR);

    if (fd <= 0) {
        if (!already_warned) {
            ALOGE("write_int failed to open %s\n", path);
            already_warned = 1;
        }
        return -errno;
    }

    char buffer[16];
    int bytes = sprintf(buffer, "%d\n", value);
    int written = write(fd, buffer, bytes);
    close(fd);
    return written == bytes ? 0 : -errno;
}

static int
rgb_to_brightness(int color)
{
    return ((77*((color>>16)&0xff))
            + (150*((color>>8)&0xff)) + (29*(color&0xff))) >> 8;
}

static int
rgb_to_bool(int color)
{
    return 0 != (color & 0xffffff);
}

static int
set_light_backlight(struct light_device_t *dev,
        struct light_state_t const *state)
{
    return write_int(BACKLIGHT_FILE, rgb_to_brightness(state->color));
}

static int
update_buttons_state(void)
{
    ALOGI("g_buttons_on=%d g_battery_on=%d g_notifications_on=%d"
            " g_attention_on=%d\n",
            g_buttons_on, g_battery_on, g_notifications_on, g_attention_on);
    return write_int(BUTTONS_FILE,
            g_buttons_on | g_battery_on | g_notifications_on | g_attention_on);
}

static int
set_light_buttons(struct light_device_t *dev,
        struct light_state_t const *state)
{
    g_buttons_on = rgb_to_bool(state->color);
    return update_buttons_state();
}

static int
set_light_battery(struct light_device_t *dev,
        struct light_state_t const *state)
{
    g_battery_on = rgb_to_bool(state->color);
    return update_buttons_state();
}

static int
set_light_notifications(struct light_device_t *dev,
        struct light_state_t const *state)
{
    g_notifications_on = rgb_to_bool(state->color);
    return update_buttons_state();
}

static int
set_light_attention(struct light_device_t *dev,
        struct light_state_t const *state)
{
    g_attention_on = rgb_to_bool(state->color);
    return update_buttons_state();
}

static int close_lights(struct light_device_t *dev)
{
    free(dev);

    return 0;
}

static int
open_lights(const struct hw_module_t* module, char const* name,
        struct hw_device_t** device)
{
    int (*set_light)(struct light_device_t* dev,
            struct light_state_t const* state);

    if (0 == strcmp(LIGHT_ID_BACKLIGHT, name)) {
        set_light = set_light_backlight;
    } else if (0 == strcmp(LIGHT_ID_BUTTONS, name)) {
        set_light = set_light_buttons;
    } else if (0 == strcmp(LIGHT_ID_BATTERY, name)) {
        set_light = set_light_battery;
    } else if (0 == strcmp(LIGHT_ID_NOTIFICATIONS, name)) {
        set_light = set_light_notifications;
    //} else if (0 == strcmp(LIGHT_ID_ATTENTION, name)) {
    //    set_light = set_light_attention;
    } else {
        return -EINVAL;
    }

    ALOGI("open_lights(%s)\n", name);

    struct light_device_t *dev = malloc(sizeof(struct light_device_t));
    memset(dev, 0, sizeof(*dev));

    dev->common.tag = HARDWARE_DEVICE_TAG;
    dev->common.version = 0;
    dev->common.module = (struct hw_module_t*) module;
    dev->common.close = (int (*)(struct hw_device_t*)) close_lights;
    dev->set_light = set_light;

    *device = (struct hw_device_t*) dev;

    return 0;
}

static struct hw_module_methods_t lights_module_methods = {
    .open =  open_lights,
};

struct hw_module_t HAL_MODULE_INFO_SYM = {
    .tag = HARDWARE_MODULE_TAG,
    .version_major = 1,
    .version_minor = 0,
    .id = LIGHTS_HARDWARE_MODULE_ID,
    .name = "LG P880 Lights Module",
    .author = "Michael Zhou <mzhou@cse.unsw.edu.au>",
    .methods = &lights_module_methods,
};
