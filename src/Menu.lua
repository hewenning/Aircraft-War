menu = {}

function menu.mainButton()
    local button = load.Canvas:getChildByName("menu")
    --button:setTitleText("sss")
    --button:getChildByName("Background"):getChildByName("Label"):setString("sss")

    button:addTouchEventListener(function(sender, eventType)
        if (0 == eventType)  then
            print("pressed")
            -- 在这里暂停所有的动画 --
            controller.setBulletAndAlienPause()
            menu.itemsChoose()
        elseif (1 == eventType)  then
            print("move")
        elseif  (2== eventType) then
            print("up")
        elseif  (3== eventType) then
            print("cancel")
        end
    end)

end

function menu.itemsChoose()
    print("Choose menu.")
    local menuReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/menu.ccreator')
    local menuScene = menuReader:getSceneGraph()
    local itemsButton = menuScene:getChildByName("items")
    itemsButton:removeFromParent(false)
    load.Canvas:addChild(itemsButton)     
    
    -- 获取五个按钮节点 -- 
    local mallButton = itemsButton:getChildByName("mall")
    local bagButton = itemsButton:getChildByName("bag")
    local exitButton = itemsButton:getChildByName("exit")
    local restartButton = itemsButton:getChildByName("restart")
    local continueButton = itemsButton:getChildByName("continue")

    -----------------
    --   商城部分   --
    -----------------
    mallButton:addTouchEventListener(function(sender, eventType)
        if (0 == eventType)  then
            print("Mall button pressed.")
            mall.mallView()
            itemsButton:removeFromParent()
        end
    end)

    -----------------
    --   背包部分   --
    -----------------
    bagButton:addTouchEventListener(function(sender, eventType)
        if (0 == eventType)  then
            print("Bag button pressed.")
            bag.bagView()
            itemsButton:removeFromParent()
        end
    end)

    -----------------
    -- 游戏控制部分 --
    -----------------
    -- 定义Exit按钮 --
    exitButton:addTouchEventListener(function(sender, eventType)
        if (0 == eventType)  then
            print("Exit button pressed.")
            cc.Director.sharedDirector():endToLua()
        end
    end)

    -- 定义重新开始按钮 --
    restartButton:addTouchEventListener(function(sender, eventType)
        if (0 == eventType)  then
            print("Restart button pressed.")
            controller.initData()
            schedule.setup()
            itemsButton:removeFromParent()
        end
    end)

    -- 定义继续游戏的按钮 --
    continueButton:addTouchEventListener(function(sender, eventType)
        if (0 == eventType)  then
            print("Continue button pressed.")
            controller.setBulletAndAlienResume()
            itemsButton:removeFromParent()
        end
    end)

end



return menu