require "schedule"

load = {hero = 1, Canvas =1, heroBox = 1,}

function load.loadModel()

    local creatorReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/helloworld.ccreator')
    creatorReader:setup()
    local scene = creatorReader:getSceneGraph()
    cc.Director:getInstance():replaceScene(scene)
    -- ��ȡ�����µĽڵ� -- 
    local children = scene:getChildren()
    load.Canvas = children[2]

    ------------------
    -- ���̿��Ʒɻ�  --
    ------------------
    --�Ѽ����¼���ӽ�����
    scene:addChild(keyboard.getKeyBoardStatus())
    -- ��ȡ��Ӣ�۾���Ľڵ� --
    local temp = load.Canvas:getChildByName("hero")
    load.hero = temp
    -- Ӣ�۵Ľڵ� --
    -- load.heroBox = load.hero:getBoundingBox() 
    -- print(load.heroBox.x, load.heroBox.y, load.heroBox.width, load.heroBox.height)
    --local fire = load.hero:getChildByName("fireleft")
    -- fire:setStartColor({255, 0, 0, 0})
    -- fire:setEndColor({255, 0, 0, 0})
    
    
    -------------------
    -- ��ȡ����ǩ�ڵ� --
    -------------------
    -- Canvas:getChildByName("gamelabel"):setString("")    
    local label = load.Canvas:getChildByName("label")
    local gamelabel = label:getChildByName("gamelabel")
    gamelabel:setString("")

    -------------------
    -- �������������� --
    -------------------
    schedule.setup()

end

return load