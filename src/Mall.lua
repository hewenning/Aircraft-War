mall = {bombBuyNum=0,}

function mall.mallView()
    local mallViewReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/mallview.ccreator')
    local mallScene = mallViewReader:getSceneGraph()
    local mallNode = mallScene:getChildByName("mall")
    mallNode:removeFromParent(false)
    load.Canvas:addChild(mallNode)
    mall.propPurchase()
    mall.exitMallView()
end

function mall.exitMallView()
    local exitmall = load.Canvas:getChildByName("mall"):getChildByName("exitmall")
    exitmall:addTouchEventListener(function(sender, eventType)
        if (0 == eventType)  then
            print("Exitmall button pressed.")
            load.Canvas:getChildByName("mall"):removeFromParent()
            controller.setBulletAndAlienResume()
        end
    end)
end

function mall.propPurchase()
    -- 取到道具选择的界面的节点 --
    mall.layout = load.Canvas:getChildByName("mall"):getChildByName("scrollview"):getChildByName("layout")
    mall.propFirstBuy()
end

-- 以后的道具可以写一个类 --
function mall.propFirstBuy()

    -- 获取第一个道具的所有节点 --
    local propbombButton = mall.layout:getChildByName("propbomb")
    local propbombAdd = propbombButton:getChildByName("add")
    local propbombSub = propbombButton:getChildByName("sub")
    local propbombEnter = propbombButton:getChildByName("enter")
    local propbombNum = propbombButton:getChildByName("Background"):getChildByName("bombnum")
    -- 定义ADD按钮 --
    propbombAdd:addTouchEventListener(function(sender, eventType)
        if (0 == eventType)  then
            print("PropbombAdd button pressed.")
            local maxBuy = math.floor(score.value/5000)
            if maxBuy >=1 then
                if mall.bombBuyNum <= maxBuy - 1 then
                    mall.bombBuyNum = mall.bombBuyNum + 1
                    --score.value = score.value - 5000
                    --score.refreshScoreValue()
                    propbombNum:setString(mall.bombBuyNum)
                end
            end
        end
    end)

    -- 定义SUB按钮 --
    propbombSub:addTouchEventListener(function(sender, eventType)
        if (0 == eventType)  then
            print("PropbombSub button pressed.")
            if mall.bombBuyNum >0 then
                mall.bombBuyNum = mall.bombBuyNum - 1
                --score.value = score.value + 5000
                --score.refreshScoreValue()
                propbombNum:setString(mall.bombBuyNum)
            end
        end
    end)

    -- 定义ENTER按钮 --
    propbombEnter:addTouchEventListener(function(sender, eventType)
        if (0 == eventType)  then
            print("PropbombEnter button pressed.")
            prop.bombnum = prop.bombnum + mall.bombBuyNum
            score.value = score.value - mall.bombBuyNum * 5000
            score.refreshScoreValue()
            mall.bombBuyNum = 0
            propbombNum:setString(mall.bombBuyNum)
            prop.refreshBombNum()
        end
    end)

    -- 定义点击显示信息按钮 --
    propbombButton:addTouchEventListener(function(sender, eventType)
        if (0 == eventType)  then
            print("PropbombButton button pressed.")
            prop.infoDisplay("Cost G5000.Clear all,and get G3000.") 
        end
    end)
end


return mall