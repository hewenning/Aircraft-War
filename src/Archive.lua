archive = {}

function archive.saveGame()
    -- print("Save game.")
    controller.infoDisplay("Game data saved successfully.")
end

function archive.loadGame()
    -- print("Load game.")
    controller.infoDisplay("The game data is loaded successfully.")
end

return archive