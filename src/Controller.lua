controller = {}

-- ���ݳ�ʼ�� -- 
function controller.initData()
    -- �����ÿ� --
    score.value = 0
    load.Canvas:getChildByName("label"):getChildByName("scorevalue"):setString(score.value)
    -- Ѫ������ -- 
    hero.hp = 100
    -- ����ֵ���� --
    hero.life = 5
    load.Canvas:getChildByName("label"):getChildByName("lifevalue"):setString(hero.life)
    -- ���߳�ʼ�� --
    prop.bombnum = 5
    local bombnumlabel = load.Canvas:getChildByName("label"):getChildByName("bombnumlabel"):setString(prop.bombnum)
    -- �л����ӵ����� --
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
    -- ���еĽڵ�ȫ����� --
    -- to do
end

function controller.keySwitch()
    if keyboard.keyStatus[149] == 1 then
        prop.bombRelease()
    end
end

return controller