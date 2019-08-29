gameover ={Canvas = 0,}

function gameover.mainScene()
    local scoreMax = score.value
    -- schedule.shutdown()
    gamelogic.shutdown()
    controller.initData()
    -- controller.setBulletAndAlienPause()
    local overReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/gameover.ccreator')
    overReader:setup()
    local overScene = overReader:getSceneGraph()
    cc.Director:getInstance():replaceScene(overScene)

    -- 获取场景下的节点 -- 
    local children = overScene:getChildren()
    gameover.Canvas = children[2]

    local maxscore = gameover.Canvas:getChildByName("maxscore")
    local maxhistory = gameover.Canvas:getChildByName("maxhistory")
    maxscore:setString(scoreMax)
    maxhistory:setString(scoreMax)

    local restart = gameover.Canvas:getChildByName("restart")
    restart:addTouchEventListener(function(sender, eventType)
        if (0 == eventType)  then
            print("Restart button pressed.")
            -- local str = "You have "..prop.bomnum.."bombs.Clear all,and get G3000."
            --cc.Director:getInstance():resume()
            load.loadGame()
        end
    end)

end


return gameover