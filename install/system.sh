echo -e "\n\nChanging system settings..."
echo "=============================="

echo "Subpixel font rendering enabled"
defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO

echo "Dock icon bouncing disabled"
defaults write com.apple.dock no-bouncing -bool TRUE
