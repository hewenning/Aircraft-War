prop = {bombnum = 5,}

function prop.bombRelease()
    if prop.bombnum > 0 then
        prop.bombnum = prop.bombnum - 1
        local bombnumlabel = load.Canvas:getChildByName("label"):getChildByName("bombnumlabel")
        bombnumlabel:setString(prop.bombnum)

        -- �ͷŶ��� --
        local animationBomb = cc.Animation:create()
        local nameBomb
        for i = 1, 3 do
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
        bomb:setPosition(load.hero:getPositionX(), load.hero:getPositionY())

        -- ������ж��� --
        local action = cc.Sequence:create( 
            {
                cc.MoveBy:create(2, cc.p(0, 500)),
                actionBomb, 
                cc.CallFunc:create( function()
                    bomb:removeFromParent()
                    print("The bomb has been cleared.")   
                end ),          
            }
        )
        bomb:runAction(action)
        
        for _, v in pairs(alien.set) do
            v:setHP(1)
            v:destroy()
        end

    else
        -- ���Լ���ʾ��Ϣ --   
    end
end

return prop