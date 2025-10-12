# FreeJ2ME-Plus Lakka Integration Fix

## Problem
FreeJ2ME core reports an error "freej2me_system directory not found" when running on Lakka.

## Root Cause
- FreeJ2ME core requires the `freej2me_system` directory to store logs, custom fonts, and MIDI files
- On Lakka, due to read-only filesystem and restricted permissions, this directory is not created automatically

## Applied Solution

### 1. Updated Lakka packages
- **File:** `packages/emulation/libretro-freej2me-plus/package.mk`
- **File:** `packages/lakka/libretro_cores/freej2me_plus/package.mk`

**Changes:**
- Pre-create `freej2me_system` directory structure in system directory
- Create subdirectories: `customMIDI`, `customFont`, `SiemensData`, `XceData`
- Place placeholder files to ensure directories exist

### 2. Created systemd service
- **File:** `packages/emulation/libretro-freej2me-plus/system.d/freej2me-setup.service`

**Functionality:**
- Create writable directories in `/storage/.config/retroarch/system/`  
- Create symbolic link from `/tmp/system/` (where core searches)
- Run before RetroArch starts

## Why fix in Lakka instead of core?

### ✅ **Benefits of fixing in Lakka:**
1. **No compatibility breakage** - Core continues working normally on other platforms
2. **Follows Lakka standards** - Other cores are handled similarly
3. **Easy maintenance** - Only need to fix package once
4. **Stable** - No need to rebuild core when there are updates

### ❌ **Drawbacks of fixing in core:**
1. **Breaking changes** - Could affect other platforms
2. **More complex** - Need conditional logic for each OS
3. **Maintenance** - Must sync with upstream changes
4. **Testing** - Need to test on multiple platforms

## How to build and test

### Build Lakka with fix:
```bash
cd Lakka-LibreELEC
PROJECT=Generic ARCH=x86_64 make image
```

### Test on device:
1. Flash new image
2. Check directory: `/tmp/system/freej2me_system/`
3. Load FreeJ2ME core and test game
4. Check log: `/storage/.config/retroarch/system/freej2me_system/FreeJ2ME.log`

## Conclusion

**Recommendation: Fix in Lakka package** ✅

This is the best approach because:
- Safe and stable
- Follows Lakka best practices
- Easy to maintain in the future
- Does not affect the original core