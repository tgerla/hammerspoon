//
//  libkeyboardbacklight.m
//  Hammerspoon
//
//  Based on https://github.com/rakalex/mac-brightnessctl
//  Adapted for Hammerspoon by Timothy Gerla
//


#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>
#include <IOKit/graphics/IOGraphicsLib.h>
#import <LuaSkin/LuaSkin.h>
#import "math.h"
#import "BrightnessControl.h"
#import "KeyboardManager.h"

/// hs.brightness.set(brightness) -> boolean
/// Function
/// Sets the display brightness
///
/// Parameters:
///  * brightness - A number between 0 and 100
///
/// Returns:
///  * True if the brightness was set, false if not
static int backlight_set(lua_State* L) {
    double level = MIN(MAX(luaL_checkinteger(L, 1) / 100.0, 0.0), 1.0);
    bool found = false;

    [BrightnessControl setBrightness:level];
    
    lua_pushboolean(L, found);
    return 1;
}


/// hs.brightness.get() -> number
/// Function
/// Returns the current brightness of the display
///
/// Parameters:
///  * None
///
/// Returns:
///  * A number containing the brightness of the display, between 0 and 100
static int backlight_get(lua_State *L) {
    float level;
    
    level = [BrightnessControl getBrightness];
    lua_pushinteger(L, level * 100.0) ;
    
    return 1;
}


static const luaL_Reg keyboardBacklightLib[] = {
    {"set", backlight_set},
    {"get", backlight_get},
    {NULL, NULL}
};

int luaopen_hs_libkeyboardbacklight(lua_State* L) {
    LuaSkin *skin = [LuaSkin sharedWithState:L];
    [skin registerLibrary:"hs.keyboardbacklight" functions:keyboardBacklightLib metaFunctions:nil];
    [KeyboardManager configure];

    return 1;
}
