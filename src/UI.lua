require "algorithm"
require "piece"
require "score"

ui = {index = 1, temp = 2,}
--��������Ҫ��ʾ��ǩ����ֵ --
local ArrayPosition = {{25, 175}, {75, 175}, {125, 175}, {175, 175},
                {25, 125}, {75, 125}, {125, 125}, {175, 125},
                {25, 75}, {75, 75}, {125, 75}, {175, 75},
                {25, 25}, {75, 25}, {125, 25}, {175, 25}}
 --ui.position = ArrayPosition
local objTable = {}

-- ��������ͼ�� --
function ui.createLayerBackground()
        
    local LayerBackground = cc.Layer:create()
    local visibleSize = cc.Director:getInstance():getVisibleSize()
    math.randomseed(tostring(os.time()):reverse():sub(1, 6))
    --------------------
    --     UI����     --
    --------------------
    -- �ѱ���ͼ����ͼ�� --
    local BackGround = cc.Sprite:create("background.jpg")
    BackGround:setPosition(visibleSize.width / 2, visibleSize.height / 2)
    LayerBackground:addChild(BackGround)
    

    -- ����Ϸ����ı���ͼ��ӵ�ͼ�� --
    local GameBoard = cc.Sprite:create("board.jpg")
    GameBoard:setPosition(visibleSize.width / 2 , visibleSize.height / 3)
    LayerBackground:addChild(GameBoard)
    ui.index = GameBoard

    -- 2048��LOGO --
    local LOGO = cc.Label:createWithTTF( "2048", "fonts/Fingerpop.ttf", 45)
    LOGO:enableShadow(cc.BLACK, cc.size(5,2), 3)
    LayerBackground:addChild(LOGO)
    LOGO:setPosition(120,290)
    LOGO:setAnchorPoint(0.5, 0.5)

    -- �ѷ��������ǩ����ʾ����Ϸ������Ϸ� --
    local ScoreLabel = cc.Label:createWithBMFont( "fonts/bitmapFontTest4.fnt", "Score:")
    LayerBackground:addChild(ScoreLabel)
    ScoreLabel:setPosition(45, 220)
    ScoreLabel:setAnchorPoint(0, 0)

    -- ����restart��ť�� --
    local restartLabel = cc.Sprite:create("restart.png")
    restartLabel:setPosition(205, 240)
    LayerBackground:addChild(restartLabel) 

    
    -- ��ʼ������ --
    initObject()
    -- ��Ⱦ�ʼ�����̽��� --
    ui.initUI()
    -- ������궯��--
    listener = mouse.mouseLinsener()
    local eventDispatcher = GameBoard:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, ui.index)

    -- ����ͼ�� -- 
    return LayerBackground

end

-- ����һ��Table�����������½��Ķ���,���Ұ�λ��ˢ��ȥ --
function initObject()
    ui.getTempNode()
    -- ���ӵĶ��� --
    for i=1,16 do 
	    local pieceObject = piece.index.new(0, ArrayPosition[i][1], ArrayPosition[i][2])
        ui.index:addChild(pieceObject)
        objTable[i] = pieceObject
    end
    -- �����Ķ��� --
    local scoreObject = score.index.new(0, 130, 220)
    ui.index:addChild(scoreObject)
    objTable[17] = scoreObject
end


-- �ʼ��ʱ�������ϵ�ui���� --
function ui.initUI()
    ui.getTempNode()
    ------------------
    --  ��ʼ��UI����  --
    ------------------
    -- ���ʼ�����ݺͷ���ˢ��ȥ --
    print("Come in initUI function.")
    local initArray = algorithm.index
    for i,v in ipairs(initArray) do
        objTable[i]:Display(v)
    end
    objTable[17]:Display(score.count)
end

-- ÿ������ˢ��һ�μ��� --
function ui.ArrayDisplay(Array)
    ------------------
    --  ��ʼ��UI����  --
    ------------------
    -- ���ʼ�����ݺͷ���ˢ��ȥ --
    print("Come in ArrayDisplay function.")
    local ArrayValue = algorithm.getRandomNumber(Array)
    local ArrayValue = Array
    for i,v in ipairs(ArrayValue) do
        objTable[i]:Display(v)
        objTable[i]:play()
    end
    objTable[17]:Display(score.count)
    objTable[17]:play()
end

-- �½�������Ⱦ��ͼ��ڵ㣬ÿ��ˢ����֮��ɾ�� --
function ui.getTempNode()
    local tempNode = cc.Node:create()
    tempNode:setPosition(0, 0)
    tempNode:setAnchorPoint(0, 0)
    ui.index:addChild(tempNode)
    ui.temp = tempNode
end

return ui

