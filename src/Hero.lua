hero = { hp = 100, life = 5,}

-- local hp =  100

function hero.getBox()
    local heroBox =  load.hero:getBoundingBox()
    return heroBox
end


function hero.setHPbar(num)
    --local label = load.Canvas:getChildByName("label")
    local HPbar = load.hero:getChildByName("HPbar")
    HPbar:update(num/100)
end

-- 血量减为0的时候刷新血量,并且把生命值减1 -- 
function hero.getLife()
    hero.hp = hero.hp - 50
    -- 血条测试 --
    hero.setHPbar(hero.hp)
    -- 生命值操作 --
    local label = load.Canvas:getChildByName("label")
    local lifevalue = label:getChildByName("lifevalue")
    if hero.hp == 0 then
        hero.life = hero.life - 50
        lifevalue:setString(hero.life)
        hero.hp = 100
    end
end

function hero.destroy()
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
    load.hero:runAction(action) 
end

return hero