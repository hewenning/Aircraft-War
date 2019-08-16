alien = {}

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
	self.life = life
	self.score = score
    self.level = level
    local creatorReader = creator.CreatorReader:createWithFilename(path)
    creatorReader:setup()
    local alienA = creatorReader:getSceneGraph():getChildByName(name)
    alienA:removeFromParent(false)
    self:addChild(alienA)
    load.Canvas:addChild(self)
end
 
function Alien:play()
    -- 缩放动画 --
    -- self:runAction(cc.Sequence:create(cc.ScaleTo:create(0, 0.1, 0.1), cc.ScaleTo:create(0.5, 1, 1)))
end

function Alien:getAlien()
    self:setAnchorPoint(0.5, 0) 
    self:setPosition(self.x, self.y)
    local action = transition.sequence( 
        {
            --cc.MoveBy:create(1, cc.p(0, -200)),
            --cc.MoveBy:create(3, cc.p(0, 0)),
            cc.MoveBy:create(6, cc.p(0, -1200)), 
            cc.CallFunc:create( function()
                self:removeFromParent()
                print("The alien has been cleared.")
            end ),          
        }
    )
    self:runAction(action)
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
    if self.life <= 0 then
       self:removeFromParent() 
    end
end

function alien.updateA()
    -- 测试能否正常获取敌机 --
    -- print(">>>>>>>>")
    -- alien = Alien.new(alien.alienAPath, alien.A, 0, 0, 0)
    -- alien:getAlien(300, 200) 
    -- print(">>>>>>>>")
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>")
    local alienA = Alien.new(alien.alienAPath, alien.A, 0, 0, 0)
    alienA:randomPosition()
    alienA:getAlien()
    alienA:play() 
end

function alien.updateB()
    -- 测试能否正常获取敌机 --
    -- print(">>>>>>>>")
    -- alien = Alien.new(alien.alienAPath, alien.A, 0, 0, 0)
    -- alien:getAlien(300, 200) 
    -- print(">>>>>>>>")
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>")
    local alienB = Alien.new(alien.alienBPath, alien.B, 0, 0, 0)
    alienB:randomPosition()
    alienB:getAlien()
    alienB:play() 
end

function alien.updateC()
    -- 测试能否正常获取敌机 --
    -- print(">>>>>>>>")
    -- alien = Alien.new(alien.alienAPath, alien.A, 0, 0, 0)
    -- alien:getAlien(300, 200) 
    -- print(">>>>>>>>")
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>")
    local alienC = Alien.new(alien.alienCPath, alien.C, 0, 0, 0)
    alienC:randomPosition()
    alienC:getAlien()
    alienC:play() 
end

return alien