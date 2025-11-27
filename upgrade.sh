#!/bin/bash

# Define base paths
CORE_ASSETS="/usr/share/wazuh-dashboard/src/core/server/core_app/assets"
PLUGIN_PUBLIC="/usr/share/wazuh-dashboard/plugins/securityDashboards/target/public"

# Function to replace file and set permissions
replace_file() {
    local src="$1"
    local dest="$2"
    
    if [ -f "$src" ]; then
        echo "Replacing $dest with $src..."
        sudo cp "$src" "$dest"
        sudo chown wazuh-dashboard:wazuh-dashboard "$dest"
        sudo chmod 640 "$dest"
    else
        echo "Warning: Source file $src not found. Skipping."
    fi
}

# Replace Logos
replace_file "wazuh_mark_on_dark.svg" "$CORE_ASSETS/logos/wazuh_mark_on_dark.svg"
replace_file "wazuh_mark_on_light.svg" "$CORE_ASSETS/logos/wazuh_mark_on_light.svg"
replace_file "spinner_on_dark.svg" "$CORE_ASSETS/logos/spinner_on_dark.svg"
replace_file "spinner_on_light.svg" "$CORE_ASSETS/logos/spinner_on_light.svg"

# Replace Plugin Assets
replace_file "30e500f584235c2912f16c790345f966.svg" "$PLUGIN_PUBLIC/30e500f584235c2912f16c790345f966.svg"

# Replace Background
replace_file "wazuh_login_bg.svg" "$CORE_ASSETS/wazuh_login_bg.svg"
replace_file "securityDashboards.chunk.5.js" "$PLUGIN_PUBLIC/securityDashboards.chunk.5.js"

# Replace UI Settings
replace_file "theme.js" "/usr/share/wazuh-dashboard/src/core/server/ui_settings/settings/theme.js"
replace_file "navigation.js" "/usr/share/wazuh-dashboard/src/core/server/ui_settings/settings/navigation.js"

# Force Dark Theme
replace_file "legacy_dark_theme.css" "$CORE_ASSETS/legacy_light_theme.css"

# Replace Additional Logos
replace_file "300x70px.svg" "/usr/share/wazuh-dashboard/node_modules/getos/imgs/logo.svg"
replace_file "300x70px.svg" "/usr/share/wazuh-dashboard/src/plugins/console/public/application/logo.svg"
replace_file "300x70px.svg" "/usr/share/wazuh-dashboard/plugins/wazuh/public/assets/images/themes/dark/logo.svg"
replace_file "300x70px.svg" "/usr/share/wazuh-dashboard/plugins/wazuh/public/assets/images/themes/light/logo.svg"

echo "Dashboard Upgrade is completed."