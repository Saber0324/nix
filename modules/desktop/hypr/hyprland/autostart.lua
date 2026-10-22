-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("noctalia")
	hl.exec_cmd("sleep 5 && openrgb --startminimized --profile 'off'")
	hl.exec_cmd("bitwarden-desktop")
	hl.exec_cmd("rbw-agent")
end)
