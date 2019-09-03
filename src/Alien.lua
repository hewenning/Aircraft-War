alien = {set = {},Tag = 0, i = 0,}

alien.alienAPath = 'Resources/creator/Scene/alienA.ccreator'
alien.alienBPath = 'Resources/creator/Scene/alienB.ccreator'
alien.alienCPath = 'Resources/creator/Scene/alienC.ccreator'
alien.A = 'alienA'
alien.B = 'alienB'
alien.C = 'alienC'

Alien = class("Alien", function()
    return cc.Sprite:create()
end)


-- 此处的分数为单次击打的分数，从分数为hp*score --
function Alien:ctor(path, name, hp, score)
    self.name = name
    self.hp = hp
	self.score = score
    local creatorReader = creator.CreatorReader:createWithFilename(path)
    creatorReader:setup()
    local scene = creatorReader:getSceneGraph()
    local alienA = scene:getChildByName(name)
    alienA:removeFromParent(false)
    self:addChild(alienA)
    load.Canvas:addChild(self)

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
    return self.box
end


function Alien:getAlien()
    self:setAnchorPoint(0.5, 0.5) 
    self:setPosition(self.x, self.y)
end

function Alien:play()
    if self.name == alien.A then
        local action = cc.Sequence:create( 
            {
                cc.MoveBy:create(6, cc.p(0, -1200)),         
            }
        )
        self:runAction(action)
    elseif self.name == alien.B then
        local action = cc.Sequence:create( 
            {
                cc.MoveBy:create(6, cc.p(0, -1200)),        
            }
        )
        self:runAction(action)
    elseif self.name == alien.C then
        local action = cc.Sequence:create( 
            {
                cc.MoveBy:create(6, cc.p(0, -1400)),
            }
        )
        self:runAction(action)
    end

end

function Alien:randomPosition()
    -- 计算出随机的位置 --
    local leftMinX = -320 
    local rightMaxX = 320 - self:getChildByName(self.name):getContentSize().width
    -- math.randomseed(tostring(os.time()):reverse():sub(1, 6))
    local x = math.random(leftMinX, rightMaxX)
    local y = 480
    self.x = x
    self.y = y
end

function Alien:getHP()
	return self.hp
end
 
function Alien:setHP(num)
    self.hp = num
end

function Alien:getScore()
	return self.score
end

function Alien:destroy()

    -- 如果是A飞机，没有血量就销毁 --
    if self.name == alien.A then
        self.hp = self.hp - 1
        if self.hp == 0 then
            -- 爆炸动画 --
            local animationA = cc.Animation:create()
            local nameA 
            for i = 1, 5 do
                nameA = "alienA"..i..".png"
                animationA:addSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame(nameA))
            end
            -- Should last 1 second. And there are 5 frames.
            animationA:setDelayPerUnit(0.5 / 5.0)
            animationA:setRestoreOriginalFrame(true)
            local actionA = cc.Animate:create(animationA) 
            -- local spriteA = self:getChildByName("alienA")

            local action_1 = cc.Sequence:create( 
                {   
                    actionA,
                    cc.CallFunc:create( function()
                        self:removeFromParent()
                        print("The alienA has been cleared.")
                    end ),          
                }
            )
            self:getChildByName("alienA"):runAction(action_1)
        end

    -- 如果是B飞机，没有血量就销毁 --
    elseif self.name == alien.B then
        self.hp = self.hp -1
        
        -- 被击打的动画 --
        local animationBhit = cc.Animation:create()
        local nameBhit = "alienBhit.png"
        animationBhit:addSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame(nameBhit))
        -- Should last 1 second. And there are 5 frames.
        animationBhit:setDelayPerUnit(0.2 / 1)
        animationBhit:setRestoreOriginalFrame(true)
        local actionBhit = cc.Animate:create(animationBhit) 
        self:getChildByName("alienB"):runAction(actionBhit)
        
        if self.hp == 0 then
            -- 爆炸动画 --
            local animationB = cc.Animation:create()
            local nameB
            for i = 1, 5 do
                nameB = "alienB"..i..".png"
                animationB:addSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame(nameB))
            end
            -- Should last 1 second. And there are 5 frames.
            animationB:setDelayPerUnit(0.8 / 5.0)
            animationB:setRestoreOriginalFrame(true)
            local actionB = cc.Animate:create(animationB) 
            -- local spriteA = self:getChildByName("alienA")

            local action_2 = cc.Sequence:create( 
                {   
                    actionB,
                    cc.CallFunc:create( function()
                        self:removeFromParent()
                        print("The alienB has been cleared.")
                    end ),          
                }
            )
            self:getChildByName("alienB"):runAction(action_2)            
        end 

    -- 如果是C飞机，没有血量就销毁 --
    elseif self.name == alien.C then
        self.hp = self.hp -1
        
        -- 被击打的动画 --
        local animationChit = cc.Animation:create()
        local nameChit = "alienChit.png"
        animationChit:addSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame(nameChit))
        -- Should last 1 second. And there are 5 frames.
        animationChit:setDelayPerUnit(0.2 / 1)
        animationChit:setRestoreOriginalFrame(true)
        local actionChit = cc.Animate:create(animationChit) 
        self:getChildByName("alienC"):runAction(actionChit)

        if self.hp == 0 then
            -- 爆炸动画 --
            local animationC = cc.Animation:create()
            local nameC
            for i = 1, 7 do
                nameC = "alienC"..i..".png"
                animationC:addSpriteFrame(cc.SpriteFrameCache:getInstance():getSpriteFrame(nameC))
            end
            -- Should last 1 second. And there are 5 frames.
            animationC:setDelayPerUnit(1.0 / 5.0)
            animationC:setRestoreOriginalFrame(true)
            local actionC = cc.Animate:create(animationC) 
            -- local spriteA = self:getChildByName("alienA")

            local action_3 = cc.Sequence:create( 
                {   
                    actionC,
                    cc.CallFunc:create( function()
                        self:removeFromParent()
                        print("The alienC has been cleared.")
                    end ),          
                }
            )
            self:getChildByName("alienC"):runAction(action_3)
        end

    end
end

return alien