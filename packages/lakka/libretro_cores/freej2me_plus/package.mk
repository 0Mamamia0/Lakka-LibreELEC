PKG_NAME="freej2me_plus"
PKG_VERSION="0.1.1-dev"
PKG_LICENSE="GPLv3"
PKG_SITE="https://github.com/KGBRecord/freej2me-plus-lakka"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain libretro-freej2me-plus"
PKG_LONGDESC="FreeJ2ME-Plus: J2ME emulator with libretro frontend for Lakka"
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  # Install libretro core and info files
  mkdir -p ${INSTALL}/usr/lib/libretro
  cp -v ${ROOT}/build.${DISTRONAME}-${DEVICE}.${TARGET_ARCH}/build/libretro-freej2me-plus-*/libretro/freej2me_libretro.so ${INSTALL}/usr/lib/libretro/
  cp -v ${ROOT}/build.${DISTRONAME}-${DEVICE}.${TARGET_ARCH}/build/libretro-freej2me-plus-*/libretro/freej2me_libretro.info ${INSTALL}/usr/lib/libretro/
  
  # Install JAR files to RetroArch system directory
  mkdir -p ${INSTALL}/usr/share/retroarch/system
  cp -v ${ROOT}/build.${DISTRONAME}-${DEVICE}.${TARGET_ARCH}/build/libretro-freej2me-plus-*/freej2me-lr.jar ${INSTALL}/usr/share/retroarch/system/
  cp -v ${ROOT}/build.${DISTRONAME}-${DEVICE}.${TARGET_ARCH}/build/libretro-freej2me-plus-*/freej2me.jar ${INSTALL}/usr/share/retroarch/system/
}