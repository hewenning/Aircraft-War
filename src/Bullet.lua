
transition = require("cocos.framework.transition")

bullet = {}

bulletsObj = {}

Bullet = class("Bullet",function ()
    return cc.Node:create()
end)

function Bullet:ctor(x, y)
    self.x = x
    self.y = y
    local creatorReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/bullet.ccreator')
    creatorReader:setup()
    local content =  creatorReader:getSceneGraph():getChildByName("content")
    content:removeFromParent(false)
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
    -- print(self.node)
end

function Bullet:play()
    local action = transition.sequence( 
        {
            cc.MoveBy:create(3, cc.p(0, 1000)), 
            cc.CallFunc:create( function()
                self:removeFromParent()
                print("The bullet has been cleared.")
            end ),          
        }
    )
    self:runAction(action)
end

function Bullet:destroy()
    load.Canvas:removeChild(self.node)
end

-- 检测空格键或则回车按下的时候 --
function bullet.update()
    -- print(">>>>>>")
    if keyboard.keyStatus[59] == 1 or keyboard.keyStatus[164] == 1 then
        local newbullet = Bullet.new(0, 0)
        newbullet:getBullet()
        newbullet:play()
        -- -- 小于等于9，即屏幕上最多存在10颗子弹 --  
        -- if table.getn(bulletsObj) <= 9 then
        --     newbullet = Bullet.new(0, 0)
        --     newbullet:getBullet()
        --     newbullet:play()
        --     -- print(newbullet:getPositionY())
        --     table.insert(bulletsObj, newbullet)
        -- end
    end
end


-- -- 删除子弹 -- 
function bullet.checkBulletAndRemove()
    print(">>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<")
    -- for i, v in ipairs(bulletsObj) do
    --     print(v.moveTo:isDone())
    -- end
    -- if self.moveTo:isDone() then
    --     load.Canvas:removeChild(self.node)
    --     print("Canvas had deleted.")
    -- end
end

return bullet



