load = {hero = 1,}

function load.loadModel()

    local creatorReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/helloworld.ccreator')
    creatorReader:setup()
    local scene = creatorReader:getSceneGraph()
    cc.Director:getInstance():replaceScene(scene)
    -- ��ȡ�����µĽڵ� -- 
    local children = scene:getChildren()
    local Canvas = children[2]

    --�����ܷ�������ȡ�ڵ����ֵ --
    Canvas:getChildByName("gamelabel"):setString("")

    --�Ѽ����¼���ӽ�����
    scene:addChild(keyboard.getKeyBoardStatus())

    -- ��ȡ��Ӣ�۾���Ľڵ� --
    local temp = Canvas:getChildByName("hero")
    load.hero = temp

end

return load