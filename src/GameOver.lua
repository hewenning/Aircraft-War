gameover ={Canvas = 0,}

function gameover.mainScene()
    -- 取出当前分数和最高分数 --
    local scoreValue = score.value
    local scoreMax = cc.UserDefault:getInstance():getIntegerForKey("scoreMax")
    if scoreValue >= scoreMax then
        cc.UserDefault:getInstance():setIntegerForKey("scoreMax", scoreValue)
        scoreMax = scoreValue
    end
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

    -- 分数值刷上去 --
    local scoreNode = gameover.Canvas:getChildByName("score")
    local maxhistoryNode = gameover.Canvas:getChildByName("maxhistory")
    scoreNode:setString(scoreValue)
    maxhistoryNode:setString(scoreMax)

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