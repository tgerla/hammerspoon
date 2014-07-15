#import <Carbon/Carbon.h>
#import "helpers.h"

static void pushkeycode(lua_State* L, int code, const char* key) {
    // t[key] = code
    lua_pushnumber(L, code);
    lua_setfield(L, -2, key);
    
    // t[code] = key
    lua_pushstring(L, key);
    lua_pushnumber(L, code);
    lua_settable(L, -3);
}

void hydra_pushkeycodestable(lua_State* L) {
    lua_newtable(L);
    
    int relocatableKeyCodes[] = {
        kVK_ANSI_A, kVK_ANSI_B, kVK_ANSI_C, kVK_ANSI_D, kVK_ANSI_E, kVK_ANSI_F,
        kVK_ANSI_G, kVK_ANSI_H, kVK_ANSI_I, kVK_ANSI_J, kVK_ANSI_K, kVK_ANSI_L,
        kVK_ANSI_M, kVK_ANSI_N, kVK_ANSI_O, kVK_ANSI_P, kVK_ANSI_Q, kVK_ANSI_R,
        kVK_ANSI_S, kVK_ANSI_T, kVK_ANSI_U, kVK_ANSI_V, kVK_ANSI_W, kVK_ANSI_X,
        kVK_ANSI_Y, kVK_ANSI_Z, kVK_ANSI_0, kVK_ANSI_1, kVK_ANSI_2, kVK_ANSI_3,
        kVK_ANSI_4, kVK_ANSI_5, kVK_ANSI_6, kVK_ANSI_7, kVK_ANSI_8, kVK_ANSI_9,
        kVK_ANSI_Grave, kVK_ANSI_Equal, kVK_ANSI_Minus, kVK_ANSI_RightBracket,
        kVK_ANSI_LeftBracket, kVK_ANSI_Quote, kVK_ANSI_Semicolon, kVK_ANSI_Backslash,
        kVK_ANSI_Comma, kVK_ANSI_Slash, kVK_ANSI_Period,
    };
    
    TISInputSourceRef currentKeyboard = TISCopyCurrentKeyboardInputSource();
    CFDataRef layoutData = TISGetInputSourceProperty(currentKeyboard, kTISPropertyUnicodeKeyLayoutData);
    
    if (layoutData) {
        const UCKeyboardLayout *keyboardLayout = (const UCKeyboardLayout *)CFDataGetBytePtr(layoutData);
        UInt32 keysDown = 0;
        UniChar chars[4];
        UniCharCount realLength;
        
        for (int i = 0 ; i < sizeof(relocatableKeyCodes)/sizeof(relocatableKeyCodes[0]) ; i++) {
            UCKeyTranslate(keyboardLayout,
                           relocatableKeyCodes[i],
                           kUCKeyActionDisplay,
                           0,
                           LMGetKbdType(),
                           kUCKeyTranslateNoDeadKeysBit,
                           &keysDown,
                           sizeof(chars) / sizeof(chars[0]),
                           &realLength,
                           chars);
            
            const char* name = [[NSString stringWithCharacters:chars length:1] UTF8String];
            
            pushkeycode(L, relocatableKeyCodes[i], name);
        }
    }
    
    CFRelease(currentKeyboard);
    
    // you should prefer typing these in upper-case in your config file,
    // since they look more unique (and less confusing) that way
    pushkeycode(L, kVK_F1, "f1");
    pushkeycode(L, kVK_F2, "f2");
    pushkeycode(L, kVK_F3, "f3");
    pushkeycode(L, kVK_F4, "f4");
    pushkeycode(L, kVK_F5, "f5");
    pushkeycode(L, kVK_F6, "f6");
    pushkeycode(L, kVK_F7, "f7");
    pushkeycode(L, kVK_F8, "f8");
    pushkeycode(L, kVK_F9, "f9");
    pushkeycode(L, kVK_F10, "f10");
    pushkeycode(L, kVK_F11, "f11");
    pushkeycode(L, kVK_F12, "f12");
    pushkeycode(L, kVK_F13, "f13");
    pushkeycode(L, kVK_F14, "f14");
    pushkeycode(L, kVK_F15, "f15");
    pushkeycode(L, kVK_F16, "f16");
    pushkeycode(L, kVK_F17, "f17");
    pushkeycode(L, kVK_F18, "f18");
    pushkeycode(L, kVK_F19, "f19");
    pushkeycode(L, kVK_F20, "f20");
    
    // you should prefer typing these in lower-case in your config file,
    // since there's no concern for ambiguity/confusion with words, just with chars.
    pushkeycode(L, kVK_ANSI_KeypadDecimal, "pad.");
    pushkeycode(L, kVK_ANSI_KeypadMultiply, "pad*");
    pushkeycode(L, kVK_ANSI_KeypadPlus, "pad+");
    pushkeycode(L, kVK_ANSI_KeypadDivide, "pad/");
    pushkeycode(L, kVK_ANSI_KeypadMinus, "pad-");
    pushkeycode(L, kVK_ANSI_KeypadEquals, "pad=");
    pushkeycode(L, kVK_ANSI_Keypad0, "pad0");
    pushkeycode(L, kVK_ANSI_Keypad1, "pad1");
    pushkeycode(L, kVK_ANSI_Keypad2, "pad2");
    pushkeycode(L, kVK_ANSI_Keypad3, "pad3");
    pushkeycode(L, kVK_ANSI_Keypad4, "pad4");
    pushkeycode(L, kVK_ANSI_Keypad5, "pad5");
    pushkeycode(L, kVK_ANSI_Keypad6, "pad6");
    pushkeycode(L, kVK_ANSI_Keypad7, "pad7");
    pushkeycode(L, kVK_ANSI_Keypad8, "pad8");
    pushkeycode(L, kVK_ANSI_Keypad9, "pad9");
    pushkeycode(L, kVK_ANSI_KeypadClear, "padclear");
    pushkeycode(L, kVK_ANSI_KeypadEnter, "padenter");
    
    pushkeycode(L, kVK_Return, "return");
    pushkeycode(L, kVK_Tab, "tab");
    pushkeycode(L, kVK_Space, "space");
    pushkeycode(L, kVK_Delete, "delete");
    pushkeycode(L, kVK_Escape, "escape");
    pushkeycode(L, kVK_Help, "help");
    pushkeycode(L, kVK_Home, "home");
    pushkeycode(L, kVK_PageUp, "pageup");
    pushkeycode(L, kVK_ForwardDelete, "forwarddelete");
    pushkeycode(L, kVK_End, "end");
    pushkeycode(L, kVK_PageDown, "pagedown");
    pushkeycode(L, kVK_LeftArrow, "left");
    pushkeycode(L, kVK_RightArrow, "right");
    pushkeycode(L, kVK_DownArrow, "down");
    pushkeycode(L, kVK_UpArrow, "up");
}
