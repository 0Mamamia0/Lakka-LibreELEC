# Building Lakka with FreeJ2ME Support

## Introduction
This repository is an enhanced version of Lakka with integrated:
- ✅ **Java Support** (Eclipse Temurin OpenJDK 8u422-b05)
- ✅ **FreeJ2ME-Plus Core** - High-performance J2ME emulator
- 🎯 **PortMaster Integration** (planned)

## ⚠️ Storage Requirements Notice
**Building Lakka requires significant disk space (20-50GB+ depending on platform)**. Since my machine doesn't have enough storage to build for all platforms, I'm providing this guide so you can build according to your needs.

## System Requirements

### Hardware Requirements
- **RAM**: Minimum 8GB (recommended 16GB+)
- **Disk Space**: 30-60GB free space (depending on platform)
- **CPU**: Multi-core processor (build time is very long)

### Software Requirements
- **Any OS that supports Docker**: Windows, macOS, Linux
- **Docker & Docker Compose**: That's it! No other dependencies needed
- **Git**: To clone the repository

## Supported Platforms

### Desktop/PC Platforms
- **Generic/x86_64** - PC 64-bit (Intel/AMD)
- **Generic-legacy/i386** - PC 32-bit
- **Generic/gbm** - Modern Linux với GPU support
- **Generic/wayland** - Wayland display server
- **Generic/x11** - X11 display server

### ARM-based Devices
- **RPi/RPi4** - Raspberry Pi 4
- **RPi/RPi5** - Raspberry Pi 5  
- **Rockchip/RK3588** - Rock 5B, Orange Pi 5
- **Amlogic/AMLGX** - Odroid N2, GT King Pro
- **Allwinner/H616** - Orange Pi Zero 2
- **Samsung/Exynos** - Odroid XU4

### Gaming Handhelds
- **L4T/Switch** - Nintendo Switch (Linux4Tegra)
- **Ayn/Odin** - Ayn Odin handheld
- **Generic/x86_64** - Steam Deck, ROG Ally, etc.

### Specialized ARM
- **ARM/Cortex-A53** - Generic ARM64
- **Qualcomm/Snapdragon** - Snapdragon SBC
- **NXP/iMX8** - NXP development boards

## Environment Setup

### Prerequisites Installation

#### Windows
1. Install [Docker Desktop for Windows](https://docs.docker.com/desktop/windows/install/)
2. Install [Git for Windows](https://git-scm.com/download/win)
3. Open Command Prompt or PowerShell

#### macOS  
1. Install [Docker Desktop for Mac](https://docs.docker.com/desktop/mac/install/)
2. Install Git: `brew install git` (or download from [git-scm.com](https://git-scm.com/))
3. Open Terminal

#### Linux
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install docker.io docker-compose git

# Fedora/CentOS
sudo dnf install docker docker-compose git

# Arch Linux
sudo pacman -S docker docker-compose git

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker
```

### Repository Setup (All Platforms)
```bash
# Clone repository
git clone https://github.com/hanhvs/Lakka-LibreELEC.git
cd Lakka-LibreELEC

# Switch to correct branch
git checkout Lakka-v5.x
```

## Build Commands

## Quick Start - Build Method

### General Build Process
```bash
# Clone repository
git clone https://github.com/hanhvs/Lakka-LibreELEC.git
cd Lakka-LibreELEC
git checkout Lakka-v5.x

# Build release image for your platform
make docker-image-release-custom PROJECT=<project> DEVICE=<device> ARCH=<arch>
```

### Popular Platform Examples
```bash
# Generic PC
make docker-image-release-custom PROJECT=Generic DEVICE=Generic ARCH=x86_64

# Raspberry Pi 4
make docker-image-release-custom PROJECT=RPi DEVICE=RPi4 ARCH=aarch64

# Nintendo Switch
make docker-image-release-custom PROJECT=L4T DEVICE=Switch ARCH=aarch64

# Orange Pi Zero 2
make docker-image-release-custom PROJECT=Allwinner DEVICE=H616 ARCH=aarch64
```

## Docker Build (Recommended)

### Build Commands
Use the custom build command with your platform parameters:

```bash
# Release build (recommended)
make docker-image-release-custom PROJECT=<project> DEVICE=<device> ARCH=<arch>

# Development build
make docker-image-custom PROJECT=<project> DEVICE=<device> ARCH=<arch>
```

### Examples for Popular Platforms
```bash
# Generic PC 64-bit
make docker-image-release-custom PROJECT=Generic DEVICE=Generic ARCH=x86_64

# Raspberry Pi 4
make docker-image-release-custom PROJECT=RPi DEVICE=RPi4 ARCH=aarch64

# Raspberry Pi 5
make docker-image-release-custom PROJECT=RPi DEVICE=RPi5 ARCH=aarch64

# Nintendo Switch
make docker-image-release-custom PROJECT=L4T DEVICE=Switch ARCH=aarch64

# Amlogic AMLGX (Odroid N2, GT King Pro)
make docker-image-release-custom PROJECT=Amlogic DEVICE=AMLGX ARCH=aarch64
```

### Additional Docker Commands
```bash
# Build Docker environment first time
make docker-build

# Interactive shell for debugging
make docker-shell

# Clean build with Docker
make docker-image-clean

# Rebuild Docker image (when source changes)
make docker-rebuild
```

## Getting Build Output Files

After build completes, the output files are stored in the Docker volume `lakka-target`.

### Find and Extract Build Files
```bash
# List Docker volumes to find lakka-target
docker volume ls | grep lakka-target

# Copy files from lakka-target volume to current directory
docker run --rm -v lakka-target:/source -v $(pwd):/dest alpine cp -r /source/ /dest/lakka-output
```

### Output File Formats
Your build files will be in various compressed formats (file extension depends on platform and build type):

**Common formats:**
- `.img.gz` - Compressed disk image (most common)
- `.img.xz` - XZ compressed disk image  
- `.tar` - Uncompressed filesystem archive
- `.tar.gz` - Gzip compressed archive
- `.tar.xz` - XZ compressed archive
- `.ova` - Virtual machine image (some platforms)

### Check Your Files
```bash
# After copying, check what files you got
ls -la lakka-output/
```

Look for files matching your platform name, e.g.:
- `Lakka-Generic.x86_64-5.x-devel-*.img.gz`
- `Lakka-L4T.aarch64-5.x-devel-*.img.gz` (Nintendo Switch)
- `Lakka-RPi4.aarch64-5.x-devel-*.img.gz` (Raspberry Pi 4)

The exact file extension will depend on the build configuration and platform requirements.

## Complete Platform Reference

Copy the exact parameters for your target platform:

### Generic PC Platforms
```bash
# Standard PC 64-bit
PROJECT=Generic DEVICE=Generic ARCH=x86_64

# Legacy PC 32-bit  
PROJECT=Generic DEVICE=Generic-legacy ARCH=i386

# Modern GPU support
PROJECT=Generic DEVICE=gbm ARCH=x86_64

# Wayland compositor
PROJECT=Generic DEVICE=wayland ARCH=x86_64

# X11 window system
PROJECT=Generic DEVICE=x11 ARCH=x86_64
```

### Raspberry Pi Family
```bash
# Raspberry Pi (original)
PROJECT=RPi DEVICE=RPi ARCH=arm

# Raspberry Pi 2
PROJECT=RPi DEVICE=RPi2 ARCH=arm

# Raspberry Pi 3
PROJECT=RPi DEVICE=RPi3 ARCH=aarch64

# Raspberry Pi 4
PROJECT=RPi DEVICE=RPi4 ARCH=aarch64

# Raspberry Pi 5
PROJECT=RPi DEVICE=RPi5 ARCH=aarch64

# Raspberry Pi Zero 2 W
PROJECT=RPi DEVICE=RPiZero2-GPiCASE2W ARCH=aarch64

# Pi gaming cases
PROJECT=RPi DEVICE=GPICase ARCH=arm
PROJECT=RPi DEVICE=Pi02GPi ARCH=arm
PROJECT=RPi DEVICE=RPi4-GPICase2 ARCH=aarch64
PROJECT=RPi DEVICE=RPi4-PiBoyDmg ARCH=aarch64
PROJECT=RPi DEVICE=RPi4-RetroDreamer ARCH=aarch64
```

### Nintendo Switch
```bash
# Nintendo Switch (L4T - Linux4Tegra)
PROJECT=L4T DEVICE=Switch ARCH=aarch64
```

### Rockchip SBCs
```bash
# RK3288 (Tinker Board, Firefly-RK3288)
PROJECT=Rockchip DEVICE=RK3288 ARCH=arm

# RK3328 (Rock64, Renegade)
PROJECT=Rockchip DEVICE=RK3328 ARCH=aarch64

# RK3399 (Rock Pi 4, NanoPC-T4, Khadas Edge)
PROJECT=Rockchip DEVICE=RK3399 ARCH=aarch64
```

### Amlogic SBCs
```bash
# AMLGX (Odroid N2, GT King Pro, Radxa Zero)
PROJECT=Amlogic DEVICE=AMLGX ARCH=aarch64
```

### Allwinner SBCs
```bash
# A64 (Pine64, NanoPi A64)
PROJECT=Allwinner DEVICE=A64 ARCH=aarch64

# H2+ (Orange Pi Zero, NanoPi NEO)
PROJECT=Allwinner DEVICE=H2-plus ARCH=arm

# H3 (Orange Pi PC, NanoPi M1)
PROJECT=Allwinner DEVICE=H3 ARCH=arm

# H5 (Orange Pi PC2, NanoPi NEO2)
PROJECT=Allwinner DEVICE=H5 ARCH=aarch64

# H6 (Orange Pi 3, Pine H64)
PROJECT=Allwinner DEVICE=H6 ARCH=aarch64

# H616 (Orange Pi Zero 2)
PROJECT=Allwinner DEVICE=H616 ARCH=aarch64

# R40 (Banana Pi M2 Ultra)
PROJECT=Allwinner DEVICE=R40 ARCH=arm
```

### Other ARM Platforms
```bash
# Generic ARM Cortex-A platforms
PROJECT=ARM DEVICE=<check devices folder> ARCH=arm

# Samsung Exynos (Odroid XU4)
PROJECT=Samsung DEVICE=<check devices folder> ARCH=arm

# Qualcomm Snapdragon
PROJECT=Qualcomm DEVICE=<check devices folder> ARCH=aarch64

# NXP i.MX platforms
PROJECT=NXP DEVICE=<check devices folder> ARCH=aarch64

# Ayn handheld devices
PROJECT=Ayn DEVICE=<check devices folder> ARCH=aarch64
```

### Usage Examples
```bash
# Generic PC
make docker-image-release-custom PROJECT=Generic DEVICE=Generic ARCH=x86_64

# Raspberry Pi 4
make docker-image-release-custom PROJECT=RPi DEVICE=RPi4 ARCH=aarch64

# Nintendo Switch
make docker-image-release-custom PROJECT=L4T DEVICE=Switch ARCH=aarch64

# Orange Pi Zero 2
make docker-image-release-custom PROJECT=Allwinner DEVICE=H616 ARCH=aarch64
```

## Troubleshooting

### Network Issues (DNS blocking)
Some regions may have blocked download sources:
```bash
# Use VPN or proxy
export http_proxy=http://your-proxy:port
export https_proxy=https://your-proxy:port

# Or build in Docker with custom DNS
docker run --dns 8.8.8.8 --dns 1.1.1.1 ...
```

### Out of Space
```bash
# Clean build cache
make clean-ccache

# Clean downloads  
rm -rf sources/

# Clean all builds
make distclean
```

### Build Errors
```bash
# Build với verbose output
PROJECT=Generic DEVICE=Generic ARCH=x86_64 VERBOSE=1 make image

# Build single package để debug
PROJECT=Generic DEVICE=Generic ARCH=x86_64 ./scripts/build <package-name>
```

## Features of This Build

### ✅ Java Support
- Eclipse Temurin OpenJDK 8u422-b05
- Full JRE + development tools
- Automatic configuration after boot

### ✅ FreeJ2ME-Plus Integration  
- Enhanced J2ME emulator
- Improved game compatibility
- RetroArch integration
- Automatic JAR detection

### 🎯 Planned: PortMaster
- Game ports library
- Easy installation system
- Extended gaming capabilities

## Testing

After building and flashing the image:

1. **Boot test**: Check boot into RetroArch
2. **Java test**: Run `java -version` in terminal
3. **J2ME test**: Load J2ME `.jar` game files via RetroArch
4. **Performance test**: Test game performance

## Support & Community

- **GitHub Issues**: [Report bugs](https://github.com/KGBRecord/Lakka-LibreELEC/issues)
- **Discord**: [Lakka Community](https://discord.gg/BNFR4hM)
- **IRC**: #lakkatv on irc.libera.chat
- **Original Lakka**: https://www.lakka.tv

## Contributing

Contributions welcome! Especially need help with:
- J2ME game compatibility testing
- Performance optimizations  
- Cross-platform testing
- Documentation improvements

## License

This project is based on LibreELEC/Lakka and follows the same licensing terms.

---

**⚠️ Disclaimer**: Build process can take many hours and significant storage. Test on VM before flashing to real hardware.