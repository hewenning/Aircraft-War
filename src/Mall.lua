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
    -- ȡ������ѡ��Ľ���Ľڵ� --
    local layout = load.Canvas:getChildByName("mall"):getChildByName("scrollview"):getChildByName("layout")
    -- ��һ�����ߵĽڵ� --
    local propbombButton = layout:getChildByName("propbomb")
        -- ���������Ϸ�İ�ť --
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