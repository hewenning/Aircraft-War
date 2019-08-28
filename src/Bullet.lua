bullet = {set = {}, Tag = 0,}
 

Bullet = class("Bullet",function ()
    return cc.Node:create()
end)

-- Bullet = class("Bullet")

function Bullet:ctor(x, y)
    self.x = x
    self.y = y
    local creatorReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/bullet.ccreator')
    creatorReader:setup()
    local scene =  creatorReader:getSceneGraph()
    local content = scene:getChildByName("bullet")
    content:removeFromParent(false)
    self:addChild(content)
    load.Canvas:addChild(self)

    -- 构造的时候把对象大小的矩形保存 --
    local box = self:getBoundingBox()
    self.box = box


    -- -- 构造的时候把定时器打开 --
    -- self:scheduleUpdateWithPriorityLua(function (dt)
    --     self:update(dt)
    -- end, 0)

end

-- function Bullet:updata(dt)
--     if self:getPositionY() >= 1500 then
--         self:removeFromParent()
--     end 
-- end

function Bullet:refreshBox()
    local box = self:getBoundingBox()
    -- local box = {}
    box.width = 9
    box.height = 21
    box.x = self:getPositionX()
    box.y = self:getPositionY()
    self.box = box
end

function Bullet:getBox()
    -- return self.box
    return self.box
end

function Bullet:getBullet()
    -- load.hero:addChild(self.node)
    self.x = heroSet[1]:getPositionX()
    self.y = heroSet[1]:getPositionY()
    -- print(self.x,self.y )
    self:setPosition(self.x, self.y)
    self:setAnchorPoint(0.5, 0) 
end

function Bullet:play()
    local action = cc.Sequence:create( 
        {
            cc.MoveBy:create(2, cc.p(0, 1000)),        
        }
    )
    self:runAction(action)
end

function Bullet:destroy()
    self:removeFromParent()
    print("The bullet has been cleared.") 
end


-- 检测空格键或则回车按下的时候 --
function bullet.createBullet()
    if keyboard.keyStatus[59] == 1 or keyboard.keyStatus[164] == 1 then
        local newbullet = Bullet.new(0, 0)
        newbullet:getBullet()
        newbullet:play()
        table.insert(bullet.set, newbullet)
    end
end

function bullet.destoryOutBullet()
    for i, k in pairs(bullet.set) do
        if k:getPositionY() >= 500 then
            k:removeFromParent()
            bullet.set[i] = nil
        end
    end
end

return bullet



