-- Hyper-* to switch to program, or run a lua function
local status, hyperModeAppMappings = pcall(require, 'hyper-apps')

for i, mapping in ipairs(hyperModeAppMappings) do
  local key = mapping[1]
  local app = mapping[2]

  hs.hotkey.bind({'shift', 'ctrl', 'alt', 'cmd'}, key, function()

    if (type(app) == 'string') then

        local to_open = hs.application.get(app)
        if (to_open ~= nil and to_open:isFrontmost()) then
            to_open:hide()
        end

        hs.application.open(app)  -- Always try to open it

    elseif (type(app) == 'function') then
      app()
    else
      hs.logger.new('hyper'):e('Invalid mapping for Hyper +', key)
    end

  end)
end
