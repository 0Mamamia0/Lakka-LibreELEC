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
PKG_LIBPATH="src/libretro/${PKG_LIBNAME}"
PKG_LIBVAR="FREEJ2ME_PLUS_LIB"

configure_target() {
  # Nothing to configure - using pre-built release
  :
}

make_target() {
  # No compilation needed - using pre-built binaries from release
  echo "Using pre-built FreeJ2ME-Plus release..."
  echo "Libretro core: ${PKG_BUILD}/${PKG_LIBPATH}"
  echo "JAR files: ${PKG_BUILD}/build/"
  ls -la ${PKG_BUILD}/build/
  ls -la ${PKG_BUILD}/src/libretro/
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  cp ${PKG_BUILD}/src/libretro/freej2me_libretro.info ${SYSROOT_PREFIX}/usr/lib/
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
  
  # Install JAR file to RetroArch system directory where the core expects it
  mkdir -p ${INSTALL}/usr/share/retroarch/system
  cp ${PKG_BUILD}/build/freej2me-lr.jar ${INSTALL}/usr/share/retroarch/system/
  # Note: Core looks for freej2me-lr.jar in RetroArch's system directory
}