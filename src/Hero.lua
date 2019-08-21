hero = {}

local hp =  0

function hero.getBox()
    local heroBox =  load.hero:getBoundingBox()
    return heroBox
end

function hero.getHP()
    return hero.hp
end

function hero.destroy()
    local heroDestory = cc.Animation:create()
    local nameHero  
    for i = 1, 5 do
        nameHero = "hero/hero"..i..".png"
        heroDestory:addSpriteFrameWithFile(nameHero)
    end
    -- Should last 1 second. And there are 5 frames.
    heroDestory:setDelayPerUnit(0.5 / 5)
    heroDestory:setRestoreOriginalFrame(true)
    local action = cc.Animate:create(heroDestory)
    load.hero:runAction(action) 
end

return hero