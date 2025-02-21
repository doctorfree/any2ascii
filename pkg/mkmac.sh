#!/bin/bash
PKG="any2ascii"
SRC_NAME="any2ascii"
PKG_NAME="any2ascii"
DESTDIR="usr/local"
SRC=${HOME}/src
ARCH=amd64
SUDO=sudo
GCI=

[ -f "${SRC}/${SRC_NAME}/VERSION" ] || {
  [ -f "/builds/doctorfree/${SRC_NAME}/VERSION" ] || {
    echo "$SRC/$SRC_NAME/VERSION does not exist. Exiting."
    exit 1
  }
  SRC="/builds/doctorfree"
  GCI=1
# SUDO=
}

. "${SRC}/${SRC_NAME}/VERSION"
PKG_VER=${VERSION}
PKG_REL=${RELEASE}

umask 0022

# Subdirectory in which to create the distribution files
OUT_DIR="dist/${PKG_NAME}_${PKG_VER}"

[ -d "${SRC}/${SRC_NAME}" ] || {
    echo "$SRC/$SRC_NAME does not exist or is not a directory. Exiting."
    exit 1
}

cd "${SRC}/${SRC_NAME}"

# Install required development environment tools
# ${SUDO} apt install autotools-dev autoconf libtool build-essential libncurses-dev

./build

${SUDO} rm -rf dist
mkdir dist

[ -d ${OUT_DIR} ] && rm -rf ${OUT_DIR}
mkdir ${OUT_DIR}
chmod 755 ${OUT_DIR}

for dir in "usr" "${DESTDIR}" "${DESTDIR}/bin" "${DESTDIR}/share" \
           "${DESTDIR}/share/doc" "${DESTDIR}/share/man" \
           "${DESTDIR}/share/man/man1" "${DESTDIR}/share/man/man5" \
           "${DESTDIR}/share/doc/${PKG}" "${DESTDIR}/share/${PKG}"
do
    [ -d ${OUT_DIR}/${dir} ] || ${SUDO} mkdir ${OUT_DIR}/${dir}
    ${SUDO} chown root:wheel ${OUT_DIR}/${dir}
done

# Install any2ascii
${SUDO} cp src/jp2a ${OUT_DIR}/${DESTDIR}/bin/jp2a
${SUDO} cp src/any2a ${OUT_DIR}/${DESTDIR}/bin/any2a
${SUDO} cp man/jp2a.1 ${OUT_DIR}/${DESTDIR}/share/man/man1

${SUDO} cp AUTHORS ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}/AUTHORS
${SUDO} cp BUGS ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}/BUGS
${SUDO} cp COPYING ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}/COPYING
${SUDO} cp README ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}/README
${SUDO} cp copyright ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}
${SUDO} cp ChangeLog ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}
${SUDO} cp README.md ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}
${SUDO} cp LICENSE ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}
${SUDO} cp NEWS ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}
${SUDO} cp VERSION ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}
${SUDO} pandoc -f gfm README.md | ${SUDO} tee ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}/README.html > /dev/null
${SUDO} gzip -9 ${OUT_DIR}/${DESTDIR}/share/doc/${PKG}/ChangeLog

${SUDO} chmod 755 ${OUT_DIR}/${DESTDIR}/bin/* ${OUT_DIR}/${DESTDIR}/bin
${SUDO} chown -R root:wheel ${OUT_DIR}/${DESTDIR}

cd dist
echo "Building ${PKG_NAME}_${PKG_VER} Darwin package"
cd ${PKG_NAME}_${PKG_VER}
echo "Creating compressed tar archive of ${PKG_NAME} ${PKG_VER} distribution"
tar cf - ${DESTDIR}/*/* | gzip -9 > ../${PKG_NAME}_${PKG_VER}-${PKG_REL}.Darwin.tgz

echo "Creating zip archive of ${PKG_NAME} ${PKG_VER} distribution"
zip -q -r ../${PKG_NAME}_${PKG_VER}-${PKG_REL}.Darwin.zip ${DESTDIR}/*/*

cd ..
[ "${GCI}" ] || {
    [ -d ../releases ] || mkdir ../releases
    [ -d ../releases/${PKG_VER} ] || mkdir ../releases/${PKG_VER}
    ${SUDO} cp *.tgz *.zip ../releases/${PKG_VER}
}
