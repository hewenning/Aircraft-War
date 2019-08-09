require "piece"

score = {index =1, count = 0}

local ScoreClass = class("ScoreClass", piece.index)

score.index = ScoreClass

-- 继承棋子类，覆盖棋子类的构造函数 --
function ScoreClass:cotr(num, px, py)
    -- 覆盖了父类的构造函数之后，必须手动调用父类的构造方法 --
    --ScoreClass.super:cotr(0, 0, 0)
    self.number = num
    self.px = px 
    self.py = py
    self.numLabel = cc.LabelTTF:create(num, "fonts/Marker Felt.ttf", 25)
    self.numLabel:setPosition(px, py)
    self.numLabel:setAnchorPoint(0.5, 0.5)
    self:addChild(self.numLabel)
end

-- 重写棋子类的函数 --
function ScoreClass:Display(num)
    self.number = num
    self.numLabel:setString(num)
end

return score