# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2025-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-freej2me-plus"
PKG_VERSION="0.1.1-dev"
PKG_SHA256="d1c5b29c66b54206141fef419017cc20ac855521f0a752d666b4f5a3c6636e21"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/KGBRecord/freej2me-plus-lakka"
PKG_URL="https://github.com/KGBRecord/freej2me-plus-lakka/releases/download/${PKG_VERSION}/freej2me-plus-lakka-20251009.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="FreeJ2ME-Plus Lakka: J2ME emulator with libretro frontend, optimized for Lakka OS (pre-built release)"
PKG_TOOLCHAIN="manual"

PKG_LIBNAME="freej2me_libretro.so"
PKG_LIBPATH="libretro/${PKG_LIBNAME}"
PKG_LIBVAR="FREEJ2ME_PLUS_LIB"

unpack_target() {
  mkdir -p ${PKG_BUILD}
  tar -xzf ${SOURCES}/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.tar.gz -C ${PKG_BUILD} --strip-components=1
}

configure_target() {
  # Nothing to configure - using pre-built release
  :
}

make_target() {
  # No compilation needed - using pre-built binaries from release
  echo "Using pre-built FreeJ2ME-Plus release..."
  echo "Libretro core: ${PKG_BUILD}/${PKG_LIBPATH}"
  echo "JAR files: ${PKG_BUILD}/"
  ls -la ${PKG_BUILD}/
  ls -la ${PKG_BUILD}/libretro/
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_BUILD}/${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  cp ${PKG_BUILD}/libretro/freej2me_libretro.info ${SYSROOT_PREFIX}/usr/lib/freej2me_libretro.info
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
  
  # Install JAR files and config to sysroot for later integration
  mkdir -p ${SYSROOT_PREFIX}/usr/share/retroarch/system
  cp ${PKG_BUILD}/freej2me-lr.jar ${SYSROOT_PREFIX}/usr/share/retroarch/system/
  cp ${PKG_BUILD}/freej2me.jar ${SYSROOT_PREFIX}/usr/share/retroarch/system/
  cp ${PKG_BUILD}/config.ini ${SYSROOT_PREFIX}/usr/share/retroarch/system/
  
  # Create freej2me_system directory and subdirectories for core functionality
  mkdir -p ${SYSROOT_PREFIX}/usr/share/retroarch/system/freej2me_system/customMIDI
  mkdir -p ${SYSROOT_PREFIX}/usr/share/retroarch/system/freej2me_system/customFont
  mkdir -p ${SYSROOT_PREFIX}/usr/share/retroarch/system/freej2me_system/SiemensData
  mkdir -p ${SYSROOT_PREFIX}/usr/share/retroarch/system/freej2me_system/XceData
  
  # Create placeholder files to ensure directories exist in final image
  touch ${SYSROOT_PREFIX}/usr/share/retroarch/system/freej2me_system/.placeholder
  touch ${SYSROOT_PREFIX}/usr/share/retroarch/system/freej2me_system/customMIDI/.placeholder
  touch ${SYSROOT_PREFIX}/usr/share/retroarch/system/freej2me_system/customFont/.placeholder
  touch ${SYSROOT_PREFIX}/usr/share/retroarch/system/freej2me_system/SiemensData/.placeholder
  touch ${SYSROOT_PREFIX}/usr/share/retroarch/system/freej2me_system/XceData/.placeholder
  
  # Install systemd service to setup writable directories at runtime
  mkdir -p ${INSTALL}/usr/lib/systemd/system
  cp ${PKG_DIR}/system.d/freej2me-setup.service ${INSTALL}/usr/lib/systemd/system/
  
  # Note: Core looks for freej2me-lr.jar in RetroArch's system directory
  # freej2me_system directory will be created for logs, custom fonts, and MIDI
}

post_install() {
  enable_service freej2me-setup.service
}