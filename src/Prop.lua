prop = {bombnum = 5,}

function prop.refreshBombNum() 
    local bombnumlabel = load.Canvas:getChildByName("label"):getChildByName("bombnumlabel")
    bombnumlabel:setString(prop.bombnum)
end

function prop.bombRelease()
    if prop.bombnum > 0 then
        prop.bombnum = prop.bombnum - 1
        prop.refreshBombNum() 
        -- �ͷŶ��� --
        local animationBomb = cc.Animation:create()
        local nameBomb
        for i = 1, 4 do
            nameBomb = "bomb/bombaction"..i..".png"
            animationBomb:addSpriteFrameWithFile(nameBomb)
        end
        -- Should last 1 second. And there are 5 frames.
        animationBomb:setDelayPerUnit(0.8 / 3.0)
        animationBomb:setRestoreOriginalFrame(true)
        local actionBomb = cc.Animate:create(animationBomb)
        
        -- ��ȡը������ --
        local bombReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/bomb.ccreator')
        bombReader:setup()
        local sceneBomb =  bombReader:getSceneGraph()
        local bomb = sceneBomb:getChildByName("bomb")
        bomb:removeFromParent(false)
        load.Canvas:addChild(bomb)
        bomb:setPosition(heroSet[1]:getPositionX() + 370, heroSet[1]:getPositionY() + 480)


        -- ������ж��� --
        local action = cc.Sequence:create( 
            {
                cc.MoveTo:create(2, cc.p(heroSet[1]:getPositionX() + 370, 500)),
                actionBomb, 
                cc.CallFunc:create( function()
                    for i, v in pairs(alien.set) do
                        v:setHP(1)
                        v:destroy()
                        alien.set[i] = nil
                    end
                    -- ��ը����Ҫ5000��ʹ�õĻ�ֻ����������3000�� --
                    score.addScoreValue(3000) 
                    bomb:removeFromParent()
                    print("The bomb has been cleared.")   
                end ),          
            }
        )
        bomb:runAction(action)

    else
        -- ���Լ���ʾ��Ϣ --   
    end
end

-- ��ʾ������Ϣ�ĺ��������Է�װ���� --
function prop.infoDisplay(str)
    -- �����ļ� --
    local infoReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/propinfo.ccreator')
    local infoScene = infoReader:getSceneGraph()
    local infoNode = infoScene:getChildByName("info")
    infoNode:removeFromParent(false)
    print(">>>>>>>>>>>>>>>>>>>>>>>>>")
    -- ���ڴ������Ľڵ���д��� --
    load.Canvas:addChild(infoNode)
    -- infoNode:setPosition(node:getPositionX(), node:getPositionY())
    infoNode:setPosition(320, 650)
    infoNode:getChildByName("infolabel"):setString(str)

    -- ��ʾ����֮������ --
    local sequence = cc.Sequence:create( 
        {
            cc.MoveBy:create(1.5, cc.p(0, 0)),
            cc.CallFunc:create( function()
                infoNode:removeFromParent()
                print("The info has been cleared.")    
            end ),          
        }
    )
    infoNode:runAction(sequence)

end

return prop