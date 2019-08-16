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
    self.node = creatorReader:getSceneGraph():getChildByName(name)
    self.node:removeFromParent(false)
    load.Canvas:addChild(self.node)
end
 
function Alien:play()
    -- 缩放动画 --
    self.node:runAction(cc.Sequence:create(cc.ScaleTo:create(0, 0.1, 0.1), cc.ScaleTo:create(0.5, 1, 1)))
end

function Alien:getAlien(x, y)
    self.node:setAnchorPoint(0.5, 0) 
    self.node:setPosition(x, y)
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

function alien.updateA()
    -- 测试能否正常获取敌机 --
    -- print(">>>>>>>>")
    -- alien = Alien.new(alien.alienAPath, alien.A, 0, 0, 0)
    -- alien:getAlien(300, 200) 
    -- print(">>>>>>>>")
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>")
    local alienA = Alien.new(alien.alienAPath, alien.A, 0, 0, 0)
    alienA:getAlien(300, 200)
    alienA:play() 
end

return alien