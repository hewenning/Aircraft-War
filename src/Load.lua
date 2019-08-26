require "schedule"

load = {hero = 1, Canvas =1, heroBox = 1,}

function load.loadUI()

    local creatorReaderLoad = creator.CreatorReader:createWithFilename('Resources/creator/Scene/loading.ccreator')
    creatorReaderLoad:setup()
    local sceneStart = creatorReaderLoad:getSceneGraph()

    cc.Director:getInstance():replaceScene(sceneStart)
    -- ��ȡ�����µĽڵ� -- 
    local children = sceneStart:getChildren()
    load.Canvas = children[2]

    -- �ھ����ϼ��ض��� --
    local sprite = load.Canvas:getChildByName("load")

    -- ���ض��� --
    local loadActionFrame = cc.Animation:create()
    local nameLoad 
    for i = 1, 4 do
        nameLoad = "load/load"..i..".png"
        loadActionFrame:addSpriteFrameWithFile(nameLoad)
    end
    -- Should last 1 second. And there are 5 frames.
    loadActionFrame:setDelayPerUnit(2 / 4)
    loadActionFrame:setRestoreOriginalFrame(true)
    local loadAction = cc.Animate:create(loadActionFrame)
    
    local LoadAndSwitch = cc.Sequence:create( 
                {   
                    loadAction,
                    cc.CallFunc:create( function()
                        load.loadGame()
                        print("Start new game.")
                    end ),          
                }
            )
    sprite:runAction(LoadAndSwitch)

end

function load.loadGame()
    
    local creatorReaderStart = creator.CreatorReader:createWithFilename('Resources/creator/Scene/helloworld.ccreator')
    creatorReaderStart:setup()
    local scene = creatorReaderStart:getSceneGraph()
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


    -------------------
    -- �������������� --
    -------------------
    schedule.setup()

    -------------------
    -- ��Ӳ˵��İ�ť --
    -------------------
    menu.mainButton()

end

return load