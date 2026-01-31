# LuCI Firewall Tabs Enhancement

Following my first attempt to improve the LuCI interface so that Firewall rules would be displayed in separate tabs based on their originating zone: [OpenWRT-Viewer](https://github.com/LordSpectre/OpenWRT-Viewer), this is my second attempt, implemented directly in LuCI without using an external server.

## Features

This package adds a dedicated tab under **Network → Firewall**, providing a more organized and user-friendly way to manage and view firewall rules by categorizing them into separate tabs based on their originating zone.

Users can **modify, delete, or create new rules** just like in the original view.

## Known Issues

**⚠ WARNING:** There is a minor issue related to adding and editing rules. When a new rule is added, it may not immediately display all its parameters in the GUI. The page needs to be refreshed or the user needs to click on the tab again to see the changes correctly. This is a LuCI refresh issue that is yet to be addressed.

## Installation

Download the .ipk file from the [Releases](https://github.com/LordSpectre/OpenWRT-Tab-FW-Rules/releases) page and install it on your router using `opkg install <filename>` or via the LuCI interface.

### Build ipk yourself

Clone this [repo](https://github.com/LordSpectre/OpenWRT-Tab-FW-Rules/) and run the `build-ipk.sh` script.

### Manual Installation

If you prefer not to build the full package, you can manually copy the necessary files to your router.

1. **Copy the menu entry**:
   Copy `root/usr/share/luci/menu.d/luci-app-firewall-rules.json` to `/usr/share/luci/menu.d/luci-app-firewall-rules.json` on your router.

2. **Copy the view**:
   Copy `htdocs/luci-static/resources/view/firewall/firewalltabs.js` to `/www/luci-static/resources/view/firewall/firewalltabs.js` on your router.

3. **Clear the cache**:
   Run the following on your router:
   ```bash
   rm -f /tmp/luci-indexcache
   rm -rf /tmp/luci-modulecache/
   ```
   Then refresh your browser (formatted as `CTRL+SHIFT+R` or `CTRL+F5`).

The new tab will appear under **Network → Firewall**, as shown below.

![Firewall Tabs Screenshot](https://cover.laforestaincantata.org/i/00f6d64b-dabe-4300-ab3f-50fe84d870c3.png)
