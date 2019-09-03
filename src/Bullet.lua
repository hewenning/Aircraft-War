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

end

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
    self:setPosition(self.x + 50, self.y)
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

return bullet

