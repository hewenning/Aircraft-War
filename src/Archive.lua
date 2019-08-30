archive = {}

function archive.saveGame()
    -- print("Save game.")
    controller.infoDisplay("Game data saved successfully.")
    cc.UserDefault:getInstance():setIntegerForKey("score", score.value)
    cc.UserDefault:getInstance():setIntegerForKey("scoreMax", score.value)
    cc.UserDefault:getInstance():setIntegerForKey("life", heroSet[1]:getLife())
    cc.UserDefault:getInstance():setIntegerForKey("hp", heroSet[1]:getHP())
    cc.UserDefault:getInstance():setIntegerForKey("bombnum", prop.bombnum)
end

function archive.loadGame()
    -- print("Load game.")
    -- ��������е���Ϣ --
    gamelogic.shutdown()
    controller.initData()
    load.loadGame()
    controller.infoDisplay("The game data is loaded successfully.")
    
    -- ���ط��� --
    local scoreValue = cc.UserDefault:getInstance():getIntegerForKey("score")
    cclog("scoreValue is %d", scoreValue)
    score.value = scoreValue

    -- ������߷�����������ܵȻ�д --
    local scoreMaxValue = cc.UserDefault:getInstance():getIntegerForKey("scoreMax")
    cclog("scoreMaxValue is %d", scoreMaxValue)

    -- ����Ӣ������ֵ --
    local heroLife = cc.UserDefault:getInstance():getIntegerForKey("life")
    cclog("heroLife is %d", heroLife)
    heroSet[1]:setLife(heroLife)

    local heroHP = cc.UserDefault:getInstance():getIntegerForKey("hp")
    cclog("heroHP is %d", heroHP)
    heroSet[1]:setHPbar(heroHP)

    local bombNumber = cc.UserDefault:getInstance():getIntegerForKey("bombnum")
    cclog("bombNumber is %d", bombNumber)
    prop.bombnum = bombNumber
    prop.refreshBombNum() 
end

return archive