controller = {}

-- 数据初始化 -- 
function controller.initData()
    -- 分数置空 --
    score.value = 0
    load.Canvas:getChildByName("label"):getChildByName("scorevalue"):setString(score.value)
    -- 道具初始化 --
    prop.bombnum = 5
    local bombnumlabel = load.Canvas:getChildByName("label"):getChildByName("bombnumlabel"):setString(prop.bombnum)
    -- 敌机和子弹销毁 --
    for _, i  in pairs(alien.set) do
        i:removeFromParent()
    end
    for _, k in pairs(bullet.set) do
        k:removeFromParent()
    end
    alien.set = {}
    alien.Tag = 0
    bullet.set = {}
    bullet.Tag = 0

    -- 英雄销毁 --
    for i, v in pairs(heroSet) do
        v:removeFromParent()
        heroSet[i] = nil
    end
    heroSet = {}
end

function controller.keySwitch()
    if keyboard.keyStatus[149] == 1 then
        prop.bombRelease()
    end
end

function controller.setBulletAndAlienPause()
    schedule.shutdown()
    for _, k in pairs(alien.set) do
        k:pause()
    end
    for _, v in pairs(bullet.set) do
        v:pause()
    end
    heroSet[1]:pause()
end

function controller.setBulletAndAlienResume()
    schedule.setup()
    for _, k in pairs(alien.set) do
        k:resume()

    end
    for _, v in pairs(bullet.set) do
        v:resume()	

    end
    heroSet[1]:resume()
end

return controller