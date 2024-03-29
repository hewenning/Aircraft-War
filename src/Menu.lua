menu = {pressTag = 0}

function menu.mainButton()
    local button = load.Canvas:getChildByName("menu")
    --button:setTitleText("sss")
    --button:getChildByName("Background"):getChildByName("Label"):setString("sss")

    button:addTouchEventListener(function(sender, eventType)
        if (0 == eventType)  then
            print("pressed")
            -- 在这里暂停所有的动画 --
            if menu.pressTag == 0 then
                controller.setBulletAndAlienPause()
                menu.itemsChoose()
                menu.pressTag = 1     
            end
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
    
    -- 获取七个按钮节点 -- 
    local mallButton = itemsButton:getChildByName("mall")
    local bagButton = itemsButton:getChildByName("bag")
    local exitButton = itemsButton:getChildByName("exit")
    local restartButton = itemsButton:getChildByName("restart")
    local continueButton = itemsButton:getChildByName("continue")
    local saveButton = itemsButton:getChildByName("save")
    local loadButton = itemsButton:getChildByName("load")

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
    -- 游戏控制部分 --
    -----------------
    -- 定义保存游戏的按钮 --
    saveButton:addTouchEventListener(function(sender, eventType)
        if (0 == eventType)  then
            print("Save button pressed.")
            archive.saveGame()
            controller.setBulletAndAlienResume()
            itemsButton:removeFromParent()
            menu.pressTag = 0 
        end
    end)
    -- 定义装载游戏的按钮 --
    loadButton:addTouchEventListener(function(sender, eventType)
        if (0 == eventType)  then
            print("Load button pressed.")
            archive.loadGame()
            -- itemsButton:removeFromParent()
            menu.pressTag = 0 
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
            load.loadGame()
            --itemsButton:removeFromParent()
            menu.pressTag = 0 
        end
    end)
    -- 定义继续游戏的按钮 --
    continueButton:addTouchEventListener(function(sender, eventType)
        if (0 == eventType)  then
            print("Continue button pressed.")
            controller.setBulletAndAlienResume()
            itemsButton:removeFromParent()
            menu.pressTag = 0
        end
    end)

end



return menu