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
    self.node = creatorReader:getSceneGraph():getChildByName("content")
    self.node:removeFromParent(false)
    load.Canvas:addChild(self.node)
end

function Bullet:getBullet()
    -- load.hero:addChild(self.node)
    self.x = load.hero:getPositionX()
    self.y = load.hero:getPositionY()
    self.node:setPosition(self.x + 0.5, self.y)
    self.node:setAnchorPoint(0.5, 0) 
    -- print(self.node)
end

function Bullet:play()

    local moveTo = cc.MoveBy:create(3, cc.p(0, 1000))
    --local moveTo = cc.MoveTo:create(3, cc.p(self.x + 0.5, 1000))
    -- local sequence = CCSequence:createWithTwoActions(actionMove,actionDone)
    self.node:runAction(moveTo)
    -- self.node:scheduleOnce(self.node:destroy(), 3)
end

function Bullet:destroy()
    load.Canvas:removeChild(self.node)
end


-- 检测空格键或则回车按下的时候 --
function bullet.update()
    -- print(">>>>>>")
    if keyboard.keyStatus[59] == 1 or keyboard.keyStatus[164] == 1 then
        -- local newbullet = Bullet.new(0, 0)
        --     newbullet:getBullet()
        -- 小于等于9，即屏幕上最多存在10颗子弹 --  
        if table.getn(bulletsObj) <= 9 then
            newbullet = Bullet.new(0, 0)
            newbullet:getBullet()
            newbullet:play()
            table.insert(bulletsObj, newbullet)
        end
       -- print("sdssadwadjasjfhsjafjkajfkjasklfjklasjklfjklasfjkl ")
    end
end


-- 删除子弹 -- 
-- function bullet.checkBulletAndRemove()
--     print(">>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<")
--     for i, v in ipairs(bulletsObj) do
--         if v:getPositionY() == 1000 then
--             v:destroy()
--             bulletsObj[i] = nil
--         end
--     end
-- end

return bullet



