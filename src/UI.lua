require "algorithm"
require "piece"
require "score"

ui = {index = 1, temp = 2,}
--棋子所需要显示标签的数值 --
local ArrayPosition = {{25, 175}, {75, 175}, {125, 175}, {175, 175},
                {25, 125}, {75, 125}, {125, 125}, {175, 125},
                {25, 75}, {75, 75}, {125, 75}, {175, 75},
                {25, 25}, {75, 25}, {125, 25}, {175, 25}}
 --ui.position = ArrayPosition
local objTable = {}

-- 创建背景图层 --
function ui.createLayerBackground()
        
    local LayerBackground = cc.Layer:create()
    local visibleSize = cc.Director:getInstance():getVisibleSize()
    math.randomseed(tostring(os.time()):reverse():sub(1, 6))
    --------------------
    --     UI部分     --
    --------------------
    -- 把背景图加入图层 --
    local BackGround = cc.Sprite:create("background.jpg")
    BackGround:setPosition(visibleSize.width / 2, visibleSize.height / 2)
    LayerBackground:addChild(BackGround)
    

    -- 把游戏区域的背景图添加到图层 --
    local GameBoard = cc.Sprite:create("board.jpg")
    GameBoard:setPosition(visibleSize.width / 2 , visibleSize.height / 3)
    LayerBackground:addChild(GameBoard)
    ui.index = GameBoard

    -- 2048的LOGO --
    local LOGO = cc.Label:createWithTTF( "2048", "fonts/Fingerpop.ttf", 45)
    LOGO:enableShadow(cc.BLACK, cc.size(5,2), 3)
    LayerBackground:addChild(LOGO)
    LOGO:setPosition(120,290)
    LOGO:setAnchorPoint(0.5, 0.5)

    -- 把分数字体标签，显示在游戏区域的上方 --
    local ScoreLabel = cc.Label:createWithBMFont( "fonts/bitmapFontTest4.fnt", "Score:")
    LayerBackground:addChild(ScoreLabel)
    ScoreLabel:setPosition(45, 220)
    ScoreLabel:setAnchorPoint(0, 0)

    -- 加入restart按钮键 --
    local restartLabel = cc.Sprite:create("restart.png")
    restartLabel:setPosition(205, 240)
    LayerBackground:addChild(restartLabel) 

    
    -- 初始化对象 --
    initObject()
    -- 渲染最开始的棋盘界面 --
    ui.initUI()
    -- 处理鼠标动作--
    listener = mouse.mouseLinsener()
    local eventDispatcher = GameBoard:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, ui.index)

    -- 返回图层 -- 
    return LayerBackground

end

-- 设置一个Table，用来保存新建的对象,并且把位置刷进去 --
function initObject()
    ui.getTempNode()
    -- 棋子的对象 --
    for i=1,16 do 
	    local pieceObject = piece.index.new(0, ArrayPosition[i][1], ArrayPosition[i][2])
        ui.index:addChild(pieceObject)
        objTable[i] = pieceObject
    end
    -- 分数的对象 --
    local scoreObject = score.index.new(0, 130, 220)
    ui.index:addChild(scoreObject)
    objTable[17] = scoreObject
end


-- 最开始的时候棋盘上的ui界面 --
function ui.initUI()
    ui.getTempNode()
    ------------------
    --  初始化UI部分  --
    ------------------
    -- 把最开始的数据和分数刷上去 --
    print("Come in initUI function.")
    local initArray = algorithm.index
    for i,v in ipairs(initArray) do
        objTable[i]:Display(v)
    end
    objTable[17]:Display(score.count)
end

-- 每次重新刷新一次即可 --
function ui.ArrayDisplay(Array)
    ------------------
    --  初始化UI部分  --
    ------------------
    -- 把最开始的数据和分数刷上去 --
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

-- 新建用于渲染的图层节点，每次刷新完之后删除 --
function ui.getTempNode()
    local tempNode = cc.Node:create()
    tempNode:setPosition(0, 0)
    tempNode:setAnchorPoint(0, 0)
    ui.index:addChild(tempNode)
    ui.temp = tempNode
end

return ui

