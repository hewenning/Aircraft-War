heroSet = {}

Hero = class("Hero",function ()
    return cc.Node:create()
end)


function Hero:ctor(x, y)
    self.hp = 100
    self.life = 3
    self.x = x
    self.y = y
    local creatorReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/hero.ccreator')
    creatorReader:setup()
    local scene =  creatorReader:getSceneGraph()
    local content = scene:getChildByName("hero")
    content:removeFromParent(false)
    self:addChild(content)
    load.Canvas:addChild(self)

    self:setPosition(0, 0)
    -- 构造的时候把对象大小的矩形保存 --
    local box = self:getBoundingBox()
    self.box = box

    -- 构造的时候把定时器打开 --
    -- self:scheduleUpdate(self:update(dt)
	self:scheduleUpdateWithPriorityLua(function(dt)
		self:update(dt)
	end, 0)
end

function Hero:update(dt)
    if keyboard.keyStatus[26] == 1 or keyboard.keyStatus[124] == 1 then
        self:doLeft()
    elseif keyboard.keyStatus[27] == 1 or keyboard.keyStatus[127] == 1 then
        self:doRight()
    elseif keyboard.keyStatus[28] == 1 or keyboard.keyStatus[146] == 1 then
        self:doUp()
    elseif keyboard.keyStatus[29] == 1 or keyboard.keyStatus[142] == 1 then
        self:doDown()
    end
end

function Hero:refreshBox()
    local box = self:getBoundingBox()
    box.width = 99
    box.height = 123
    box.x = self:getPositionX()
    box.y = self:getPositionY()
    self.box = box
end

function Hero:getBox()
    return self.box
end


function Hero:setHPbar(num)
    --local label = load.Canvas:getChildByName("label")
    local HPbar = self:getChildByName("hero"):getChildByName("HPbar")
    HPbar:setPercent(num)
end

function Hero:setHP(num)
    self.hp = num
end

function Hero:getHP()
    return self.hp
end

function Hero:setLife(num)
    self.life = num
    local label = load.Canvas:getChildByName("label")
    local lifevalue = label:getChildByName("lifevalue")
    lifevalue:setString(self.life)
end

-- 血量减为0的时候刷新血量,并且把生命值减1 -- 
function Hero:refreshLife()
    self.hp = self.hp - 50
    -- 血条测试 --
    self:setHPbar(self.hp)
    -- 生命值操作 --
    local label = load.Canvas:getChildByName("label")
    local lifevalue = label:getChildByName("lifevalue")
    if self.hp == 0 then
        self.life = self.life - 1
        self:destroy()
        lifevalue:setString(self.life)
        self.hp = 100
        self:setHPbar(self.hp)
    end
end

function Hero:getLife()
    return self.life
end

function Hero:destroy()
    local heroDestory = cc.Animation:create()
    local nameHero  
    for i = 1, 5 do
        nameHero = "hero/hero"..i..".png"
        heroDestory:addSpriteFrameWithFile(nameHero)
    end
    -- Should last 1 second. And there are 5 frames.
    heroDestory:setDelayPerUnit(0.8 / 5)
    heroDestory:setRestoreOriginalFrame(true)
    local action = cc.Animate:create(heroDestory)
    self:getChildByName("hero"):runAction(action) 
end


-- 定义英雄移动的函数 --
function Hero:doLeft()
    if self:getPositionX() > -300 then
        self:runAction(cc.MoveBy:create(0.1, cc.p(-6, 0)))  
    elseif self:getPositionX() <= -300 then
        self:runAction(cc.MoveTo:create(0.01, cc.p(-300, self:getPositionY())))
    end
end
function Hero:doRight()
    if self:getPositionX() < 214.5 then
        self:runAction(cc.MoveBy:create(0.1, cc.p(6, 0)))  
    elseif self:getPositionX() >= 214.5 then
        self:runAction(cc.MoveTo:create(0.01, cc.p(214.5, self:getPositionY())))
    end
end
function Hero:doUp()
    if self:getPositionY() < 470 then
        self:runAction(cc.MoveBy:create(0.1, cc.p(0, 6)))  
    elseif self:getPositionX() >= 470 then
        self:runAction(cc.MoveTo:create(0.01, cc.p(self:getPositionX(), 470)))
    end
end
function Hero:doDown()
    if self:getPositionY() > -300 then
        self:runAction(cc.MoveBy:create(0.1, cc.p(0, -6)))  
    elseif self:getPositionX() <= -300 then
        self:runAction(cc.MoveTo:create(0.01, cc.p(self:getPositionX(), -300)))
    end
end