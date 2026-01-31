#!/bin/bash
set -e

# Package metadata
PKG_NAME="luci-app-firewall-tabs"
PKG_VERSION="${1:-1.0}"
PKG_RELEASE="1"
PKG_ARCH="all"
PKG_MAINTAINER="LordSpectre <LordSpectre@github.com>"
PKG_DESCRIPTION="A LuCI extension to display firewall rules in tabs per zone"

# Build directory
BUILD_DIR="build_ipk"
IPK_DIR="${BUILD_DIR}/ipk"
CONTROL_DIR="${BUILD_DIR}/control"

echo "Building ${PKG_NAME}_${PKG_VERSION}-${PKG_RELEASE}_${PKG_ARCH}.ipk"

# Clean previous build
rm -rf "${BUILD_DIR}"
mkdir -p "${IPK_DIR}" "${CONTROL_DIR}"

# Create directory structure
mkdir -p "${IPK_DIR}/usr/share/luci/menu.d"
mkdir -p "${IPK_DIR}/www/luci-static/resources/view/firewall"

# Copy files
echo "Copying files..."
cp root/usr/share/luci/menu.d/luci-app-firewall-rules.json "${IPK_DIR}/usr/share/luci/menu.d/"
cp htdocs/luci-static/resources/view/firewall/firewalltabs.js "${IPK_DIR}/www/luci-static/resources/view/firewall/"

# Create control file
cat > "${CONTROL_DIR}/control" <<EOF
Package: ${PKG_NAME}
Version: ${PKG_VERSION}-${PKG_RELEASE}
Architecture: ${PKG_ARCH}
Maintainer: ${PKG_MAINTAINER}
Section: luci
Priority: optional
Depends: luci-base, luci-app-firewall
Description: ${PKG_DESCRIPTION}
EOF

# Create postinst script
cat > "${CONTROL_DIR}/postinst" <<'EOF'
#!/bin/sh
[ -z "${IPKG_INSTROOT}" ] || exit 0
rm -f /tmp/luci-indexcache
rm -rf /tmp/luci-modulecache/
exit 0
EOF
chmod +x "${CONTROL_DIR}/postinst"

# Create debian-binary
echo "2.0" > "${BUILD_DIR}/debian-binary"

# Package control
echo "Creating control.tar.gz..."
cd "${CONTROL_DIR}"
tar czf ../control.tar.gz ./*
cd - > /dev/null

# Package data
echo "Creating data.tar.gz..."
cd "${IPK_DIR}"
tar czf ../data.tar.gz ./*
cd - > /dev/null

# Create IPK
echo "Creating IPK package..."
cd "${BUILD_DIR}"
tar czf "../${PKG_NAME}_${PKG_VERSION}-${PKG_RELEASE}_${PKG_ARCH}.ipk" ./debian-binary ./control.tar.gz ./data.tar.gz
cd - > /dev/null

# Cleanup
rm -rf "${BUILD_DIR}"

echo "✓ Package created: ${PKG_NAME}_${PKG_VERSION}-${PKG_RELEASE}_${PKG_ARCH}.ipk"
