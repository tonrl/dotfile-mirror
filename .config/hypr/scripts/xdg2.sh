#!/usr/bin/env bash
systemctl --user stop xdg-desktop-portal-wlr
systemctl --user stop xdg-desktop-portal-gtk
systemctl --user stop xdg-desktop-portal
sleep 2
systemctl --user start xdg-desktop-portal-wlr
systemctl --user start xdg-desktop-portal-gtk
systemctl --user start xdg-desktop-portal
