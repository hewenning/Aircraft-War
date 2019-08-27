mall = {chooseTag = 1,}

function mall.mallView()
    local mallViewReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/mallview.ccreator')
    local mallScene = mallViewReader:getSceneGraph()
    local mallNode = mallScene:getChildByName("mall")
    mallNode:removeFromParent(false)
    load.Canvas:addChild(mallNode)
    mall.propPurchase()
end

function mall.propPurchase()
    -- 取到道具选择的界面的节点 --
    local layout = load.Canvas:getChildByName("mall"):getChildByName("scrollview"):getChildByName("layout")
    -- 第一个道具的节点 --
    local propbombButton = layout:getChildByName("propbomb")
        -- 定义继续游戏的按钮 --
        propbombButton:addTouchEventListener(function(sender, eventType)
        if (0 == eventType)  then
            print("Propbomb button pressed.")
            if score.value >= 5000 then
                score.value = score.value - 5000
                score.refreshScoreValue()
                prop.bombnum = prop.bombnum + 1
                prop.refreshBombNum()
                load.Canvas:getChildByName("mall"):removeFromParent()
            else
                load.Canvas:getChildByName("mall"):removeFromParent()
            end
        end
    end)
end


return mall