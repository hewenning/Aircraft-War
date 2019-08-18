transition = require "cocos.framework.transition"

bullet = {set = {}, Tag = 0,}


local i = 1 

Bullet = class("Bullet",function ()
    return cc.Node:create()
end)

function Bullet:ctor(x, y)
    self.x = x
    self.y = y
    local creatorReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/bullet.ccreator')
    creatorReader:setup()
    local scene =  creatorReader:getSceneGraph()
    local content = scene:getChildByName("content")
    content:removeFromParent(false)

    -- 构造的时候把对象大小的矩形保存 --
    local box = content:getBoundingBox()
    self.box = box

    self:addChild(content)
    load.Canvas:addChild(self)
end

function Bullet:getBullet()
    -- load.hero:addChild(self.node)
    self.x = load.hero:getPositionX()
    self.y = load.hero:getPositionY()
    print(self.x,self.y )
    self:setPosition(self.x - 319.5, self.y - 480)
    self:setAnchorPoint(0.5, 0) 
end

function Bullet:play()
    local action = transition.sequence( 
        {
            cc.MoveBy:create(2, cc.p(0, 1000)), 
            -- cc.CallFunc:create( function()
            --     self:removeFromParent()
            --     print("The bullet has been cleared.")   
            -- end ),          
        }
    )
    self:runAction(action)
end

function Bullet:destroy()
    -- load.hero:addChild(self.node)
    self:removeFromParent()
    print("The bullet has been cleared.") 
end


-- 检测空格键或则回车按下的时候 --
function bullet.update()
    -- print(">>>>>>")
    if keyboard.keyStatus[59] == 1 or keyboard.keyStatus[164] == 1 then
        -- local newbullet = Bullet.new(0, 0)
        -- newbullet:getBullet()
        -- -- print(newbullet.box)
        -- newbullet:play()
        -- 不断的把子弹存入新的Table里面 --
        if bullet.Tag <= 20 then
            bullet.set[bullet.Tag] = Bullet.new(0, 0)
            bullet.set[bullet.Tag]:getBullet()
            bullet.set[bullet.Tag]:play()
            bullet.Tag = bullet.Tag + 1
        elseif bullet.Tag == 21 then
            if i < 20 then
                bullet.set[i]:destroy()
                bullet.set[i] = Bullet.new(0, 0)
                bullet.set[i]:getBullet()
                bullet.set[i]:play()
                i = i + 1
            elseif i == 20  then
                bullet.set[i]:destroy()
                bullet.set[i] = Bullet.new(0, 0)
                bullet.set[i]:getBullet()
                bullet.set[i]:play()
                i = 1
            end
        end
    end
end

return bullet



