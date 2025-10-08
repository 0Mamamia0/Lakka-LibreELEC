# Lakka - The DIY retro emulation console

Lakka is a lightweight Linux distribution that transforms a small computer into a full blown emulation console.

## Why use Lakka?

* **Powerful** - Built on top of the famous RetroArch emulator, Lakka is able to emulate a large range of hardware and has some useful features such as Braid-like rewinding, joypad hotplug and video streaming.
* **User friendly** - Lakka is easy to setup and use. Once installed to your SD card, you just have to put your rom on the card, plug your joypad and enjoy your favorite old games. We also support PS3 and XBox360 controllers so you don't have to buy new ones. 
* **Low cost** - We try our best to keep the hardware required to run Lakka as cheap as possible. The software is optimized to run fast even on low end computers. The power can be supplied by any micro USB adapter like the one for your smartphone.
* **Open source** - Our code is free as in freedom and hosted on Github (though the project uses emulators that forbid commercialisation). We accept external contributions, and we do our best to integrate our own patches into upstream projects.
* **Enhanced Gaming Platform** - This fork extends Lakka with Java support, J2ME emulation, and planned PortMaster integration for a comprehensive retro + modern gaming experience.

## Enhanced Features

### Java Development Support ✅
This Lakka fork includes a fully integrated Java development environment:

**Features:**
- **Eclipse Temurin OpenJDK 8u422-b05** (includes JRE + development tools)
- **Cross-platform support** (x86_64, aarch64, arm)
- **BusyBox compatible** - designed for LibreELEC/Lakka environment
- **Automatic configuration** - Java available immediately after boot

### J2ME Emulation (In Progress) 🔄
Adding comprehensive J2ME (Java ME) game support:

**Planned Features:**
- **FreeJ2ME-Plus Core** - Enhanced J2ME emulator with improved compatibility
- **Automatic JAR Detection** - Seamless J2ME game loading
- **Performance Optimizations** - Optimized for embedded hardware
- **RetroArch Integration** - Full integration with Lakka's interface

### Future: PortMaster Integration 🎯
Planning to integrate PortMaster for extended gaming capabilities:

**Upcoming Features:**
- **Game Ports Library** - Access to modern game ports
- **Easy Installation** - Simple port management system
- **Extended Compatibility** - Beyond traditional emulation

### Usage:
After building and installing this Lakka version, Java is automatically available:

```sh
java -version                    # Check Java availability
javac MyProgram.java            # Compile Java programs
java MyProgram                  # Run Java programs
java -jar your-application.jar  # Run JAR files
```

### Environment:
Java environment is automatically configured with:
- **JAVA_HOME**: `/usr/lib/jvm/java-8-openjdk`
- **PATH**: Includes Java binaries
- **Compatibility**: Works with BusyBox ash shell
- **Persistence**: Configuration survives reboots

## Development Status & Progress

**🚀 Active Development**: This fork is making significant progress with enhanced emulation capabilities:

### Completed Features:
- ✅ **Java Support**: Successfully integrated Eclipse Temurin OpenJDK 8u422-b05
  - Built and tested across multiple platforms (x86_64, aarch64, arm)
  - Full JRE + development tools available
  - Automatic configuration and persistence
- ✅ **Build System**: Successfully resolved major compilation issues
- ✅ **Cross-platform Compatibility**: Confirmed working on target hardware

### Current Work in Progress:
- 🔄 **FreeJ2ME-Plus Integration**: Integrating FreeJ2ME-Plus emulator as built-in core
  - libretro-freej2me-plus package created and configured
  - Working on proper core info and system integration
  - Testing J2ME game compatibility and performance
- 🔄 **Core Library Integration**: Ensuring all dependencies are properly bundled

### Future Roadmap:
- 🎯 **PortMaster Integration**: Planning to add PortMaster for extended game porting capabilities
  - Will enable easy installation of ported games
  - Enhanced gaming ecosystem beyond traditional emulation
- 🎯 **Enhanced Gaming Hub**: Creating comprehensive retro + modern gaming platform

### Known Issues:
- **DNS/Network Restrictions**: Build process encounters frequent failures due to regional DNS blocking of source repositories
  - Multiple build hosts are inaccessible from certain geographic regions
  - Source downloads timeout or fail completely
  - Mirror repositories may be blocked or unreachable
  - **Impact**: Significantly slows development and testing cycles

### Potential Solutions Being Investigated:
- [ ] Local mirror setup for frequently accessed repositories
- [ ] VPN/proxy solutions for build environment
- [ ] Alternative source repositories and mirrors
- [ ] Offline build cache implementation
- [ ] Docker-based build environment with pre-cached dependencies

### For Developers:
If you're experiencing similar DNS/network issues during build:
1. Consider using a VPN service during build process
2. Set up local mirrors for critical dependencies
3. Use Docker with pre-cached layers when possible
4. Contact maintainer for alternative download sources

**Note**: This is an enhanced fork focusing on comprehensive retro and modern gaming capabilities. Active development with regular testing and improvements.

## Development Progress Tracking

### Build Status:
- **Java Integration**: ✅ Successfully built and integrated
- **FreeJ2ME-Plus Core**: 🔄 Package created, working on built-in integration
- **PortMaster Support**: 📋 Planned for future releases

### Contributing:
This fork welcomes contributions! Areas of focus:
- J2ME game compatibility testing
- Performance optimizations for embedded hardware
- PortMaster integration development
- Cross-platform testing and validation

## Installation instructions

Please refer to our website https://www.lakka.tv/get on how to setup Lakka.

## Support

* [FAQ](https://github.com/libretro/Lakka-LibreELEC/wiki/FAQ)
* #lakkatv on irc.libera.chat
* [Discord](https://discord.gg/BNFR4hM)
* [Forums](https://forums.libretro.com/c/libretro/lakka-tv-general)
