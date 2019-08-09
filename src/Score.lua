require "piece"

score = {index =1, count = 0}

local ScoreClass = class("ScoreClass", piece.index)

score.index = ScoreClass

-- �̳������࣬����������Ĺ��캯�� --
function ScoreClass:cotr(num, px, py)
    -- �����˸���Ĺ��캯��֮�󣬱����ֶ����ø���Ĺ��췽�� --
    --ScoreClass.super:cotr(0, 0, 0)
    self.number = num
    self.px = px 
    self.py = py
    self.numLabel = cc.LabelTTF:create(num, "fonts/Marker Felt.ttf", 25)
    self.numLabel:setPosition(px, py)
    self.numLabel:setAnchorPoint(0.5, 0.5)
    self:addChild(self.numLabel)
end

-- ��д������ĺ��� --
function ScoreClass:Display(num)
    self.number = num
    self.numLabel:setString(num)
end

return score