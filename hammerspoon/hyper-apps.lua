-- Hyper key program bindings

return {
  { 'g', 'Google Chrome' },     -- "g" for "Google"
  { 't', 'iTerm' },             -- "T" for "Terminal"
  { 'p', 'PyCharm' },           -- "P" for "PyCharm"
  { 'd', 'Discord' },           -- "D" for "Discord"

  { 'h', function()
      hs.window.focusedWindow():moveOneScreenWest(false, true, 0)
  end},
  { 'l', function()
      hs.window.focusedWindow():moveOneScreenEast(false, true, 0)
  end}
}
