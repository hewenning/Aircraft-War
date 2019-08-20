alien = {set = {},Tag = 0, i = 0,}

alien.alienAPath = 'Resources/creator/Scene/alienA.ccreator'
alien.alienBPath = 'Resources/creator/Scene/alienB.ccreator'
alien.alienCPath = 'Resources/creator/Scene/alienC.ccreator'
alien.A = 'alienA'
alien.B = 'alienB'
alien.C = 'alienC'

Alien = class("Alien", function()
    return cc.Node:create()
end)

function Alien:ctor(path, name, life, score, level)
    self.name = name
    self.life = life
	self.score = score
    self.level = level
    local creatorReader = creator.CreatorReader:createWithFilename(path)
    creatorReader:setup()
    local scene = creatorReader:getSceneGraph()
    local alienA = scene:getChildByName(name)
    alienA:removeFromParent(false)
    self:addChild(alienA)
    load.Canvas:addChild(self)

    -- local animMgr = creatorReader:getAnimationManager()
    -- self.animMgr = animMgr
    -- self.animMgr:playAnimationClip(alienA ,"alienAboom")

    -- 构造的时候把对象大小的矩形保存 --
    -- local box = self:getChildByName(name):getParent():getBoundingBox()
    local box = self:getBoundingBox()
    self.box = box
end

function Alien:refreshBox()
    if self.name == alien.A then
        local box = self:getBoundingBox()
        box.width = 51
        box.height = 38
        self.box = box
    end

    if self.name == alien.B then
        local box = self:getBoundingBox()
        box.width = 69
        box.height = 88
        self.box = box
    end

    if self.name == alien.C then
        local box = self:getBoundingBox()
        box.width = 165
        box.height = 246
        self.box = box
    end
end

function Alien:getBox()
    -- 获取对象大小的矩形 --
    -- return self.box
    return self.box
end

function Alien:play()
    -- 缩放动画 --
    -- self:runAction(cc.Sequence:create(cc.ScaleTo:create(0, 0.1, 0.1), cc.ScaleTo:create(0.5, 1, 1)))
end

function Alien:getAlien()
    self:setAnchorPoint(0.5, 0.5) 
    self:setPosition(self.x, self.y)
end

function Alien:play()
    if self.name == alien.A then
        local action = cc.Sequence:create( 
            {
                --cc.MoveBy:create(1, cc.p(0, -200)),
                --cc.MoveBy:create(3, cc.p(0, 0)),
                cc.MoveBy:create(6, cc.p(0, -1200)),
                -- cc.Animation:addSpriteFrameWithFile("alienAboom"), 
                -- cc.CallFunc:create( function()
                --     self:removeFromParent()
                --     print("The alien has been cleared.")
                -- end ),          
            }
        )
        self:runAction(action)
    elseif self.name == alien.B then
        local action = cc.Sequence:create( 
            {
                --cc.MoveBy:create(1, cc.p(0, -200)),
                --cc.MoveBy:create(3, cc.p(0, 0)),
                cc.MoveBy:create(6, cc.p(0, -1200)),
                -- cc.Animation:addSpriteFrameWithFile("alienAboom"), 
                -- cc.CallFunc:create( function()
                --     self:removeFromParent()
                --     print("The alien has been cleared.")
                -- end ),          
            }
        )
        self:runAction(action)
    else
        local action = cc.Sequence:create( 
            {
                --cc.MoveBy:create(1, cc.p(0, -200)),
                --cc.MoveBy:create(3, cc.p(0, 0)),
                cc.MoveBy:create(6, cc.p(0, -1200)),
                -- cc.Animation:addSpriteFrameWithFile("alienAboom"), 
                -- cc.CallFunc:create( function()
                --     self:removeFromParent()
                --     print("The alien has been cleared.")
                -- end ),          
            }
        )
        self:runAction(action)
    end

end

function Alien:randomPosition()
    -- 计算出随机的位置 --
    local leftMinX = -320 + self:getContentSize().width / 2
    local rightMaxX = 320 - self:getContentSize().width / 2
    -- math.randomseed(tostring(os.time()):reverse():sub(1, 6))
    local x = math.random(leftMinX, rightMaxX)
    local y = 480
    self.x = x
    self.y = y
end

function Alien:getLife()
	return self.life
end
 
function Alien:getLevel()
	return self.level
end
 
function Alien:getScore()
	return self.score
end

function Alien:destroy()
    -- if self.life <= 0 then
    --    self:removeFromParent() 
    -- end
    if self.name == alien.A then
        
        -- 爆炸动画 --
        local animationA = cc.Animation:create()
        local name
        for i = 1, 5 do
            name = "alienA/alienA"..i..".png"
            animationA:addSpriteFrameWithFile(name)
        end
        -- Should last 1 second. And there are 5 frames.
        animationA:setDelayPerUnit(0.1 / 5.0)
        animationA:setRestoreOriginalFrame(false)
        --local actionA = 

        local action = cc.Sequence:create( 
            {
                cc.Animate:create(animationA), 
                cc.CallFunc:create( function()
                    self:removeFromParent()
                    print("The alienA has been cleared.")
                end ),          
            }
        )
        self:runAction(action)

    elseif self.name == alien.B then
        self:removeFromParent()
        print("The alienB has been cleared.")
    else
        self:removeFromParent()
        print("The alienC has been cleared.")
    end

end

function alien.updateA()
    -- 测试能否正常获取敌机 --
    -- print(">>>>>>>>")
    -- alien = Alien.new(alien.alienAPath, alien.A, 0, 0, 0)
    -- alien:getAlien(300, 200) 
    -- print(">>>>>>>>")
    -- print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>")
    -- local alienA = Alien.new(alien.alienAPath, alien.A, 0, 0, 0)
    -- alienA:randomPosition()
    -- --alienA:getBox()
    -- alienA:getAlien()
    -- table.insert(alien.enemy, alienA)
    -- 不断的把敌机存入新的Table里面 --
    if alien.Tag <= 20 then
        alien.set[alien.Tag] = Alien.new(alien.alienAPath, alien.A, 0, 0, 0)
        alien.set[alien.Tag]:randomPosition()
        alien.set[alien.Tag]:getAlien()
        alien.set[alien.Tag]:play()
        alien.Tag = alien.Tag + 1
    elseif alien.Tag == 21 then
        if alien.i < 20 then
            if alien.set[alien.i] ~= nil then
                alien.set[alien.i]:destroy()
                alien.set[alien.i] = nil
            end
            alien.set[alien.i] = Alien.new(alien.alienAPath, alien.A, 0, 0, 0)
            alien.set[alien.i]:randomPosition()
            alien.set[alien.i]:getAlien()
            alien.set[alien.i]:play()
            alien.i = alien.i + 1
        elseif alien.i == 20  then
            if alien.set[alien.i] ~= nil then
                alien.set[alien.i]:destroy()
                alien.set[alien.i] = nil
            end
            alien.set[alien.i] = Alien.new(alien.alienAPath, alien.A, 0, 0, 0)
            alien.set[alien.i]:randomPosition()
            alien.set[alien.i]:getAlien()
            alien.set[alien.i]:play()
            alien.i = 1
        end
    end

end

function alien.updateB()
    -- print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>")
    -- local alienB = Alien.new(alien.alienBPath, alien.B, 0, 0, 0)
    -- alienB:randomPosition()
    -- alienB:getAlien()
    -- table.insert(alien.enemy, alienB) 
    if alien.Tag <= 20 then
        alien.set[alien.Tag] = Alien.new(alien.alienBPath, alien.B, 0, 0, 0)
        alien.set[alien.Tag]:randomPosition()
        alien.set[alien.Tag]:getAlien()
        alien.set[alien.Tag]:play()
        alien.Tag = alien.Tag + 1
    elseif alien.Tag == 21 then
        if alien.i < 20 then
            if alien.set[alien.i] ~= nil then
                alien.set[alien.i]:destroy()
                alien.set[alien.i] = nil
            end
            alien.set[alien.i] = Alien.new(alien.alienBPath, alien.B, 0, 0, 0)
            alien.set[alien.i]:randomPosition()
            alien.set[alien.i]:getAlien()
            alien.set[alien.i]:play()
            alien.i = alien.i + 1
        elseif alien.i == 20  then
            if alien.set[alien.i] ~= nil then
                alien.set[alien.i]:destroy()
                alien.set[alien.i] = nil
            end
            alien.set[alien.i] = Alien.new(alien.alienBPath, alien.B, 0, 0, 0)
            alien.set[alien.i]:randomPosition()
            alien.set[alien.i]:getAlien()
            alien.set[alien.i]:play()
            alien.i = 1
        end

    end
end

function alien.updateC()
    -- print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>")
    -- local alienC = Alien.new(alien.alienCPath, alien.C, 0, 0, 0)
    -- alienC:randomPosition()
    -- alienC:getAlien()
    -- table.insert(alien.enemy, alienC)
    if alien.Tag <= 20 then
        alien.set[alien.Tag] = Alien.new(alien.alienCPath, alien.C, 0, 0, 0)
        alien.set[alien.Tag]:randomPosition()
        alien.set[alien.Tag]:getAlien()
        -- alien.set[alien.Tag]:play()
        alien.Tag = alien.Tag + 1
    elseif alien.Tag == 21 then
        if alien.i < 20 then
            if alien.set[alien.i] ~= nil then
                alien.set[alien.i]:destroy()
                alien.set[alien.i] = nil
            end
            alien.set[alien.i] = Alien.new(alien.alienCPath, alien.C, 0, 0, 0)
            alien.set[alien.i]:randomPosition()
            alien.set[alien.i]:getAlien()
            alien.set[alien.i]:play()
            alien.i = alien.i + 1
        elseif alien.i == 20  then
            if alien.set[alien.i] ~= nil then
                alien.set[alien.i]:destroy()
                alien.set[alien.i] = nil
            end
            alien.set[alien.i] = Alien.new(alien.alienCPath, alien.C, 0, 0, 0)
            alien.set[alien.i]:randomPosition()
            alien.set[alien.i]:getAlien()
            alien.set[alien.i]:play()
            alien.i = 1
        end

    end
end

return alien