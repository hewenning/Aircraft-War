-- �趨һ����ʾ���࣬�����½�����ÿ���������ʹ������ĺ��� --
-- �½�һ��������ʾ���࣬������������ɳ�ʼ�� --

piece = {index = 1,}

local PieceClass = class("PieceClass", function ()
    return cc.Node:create()
end)

piece.index = PieceClass

-- ������Ĺ��캯�� --
function PieceClass:ctor(num, px, py)
	self.number = num
	self.px = px
	self.py = py
	-- ��ʼ�� --
	if num > 0 then
		self.numLabel = cc.LabelTTF:create(num, "fonts/Marker Felt.ttf", 20)
		self.numLabel:setPosition(px, py)
		self.numLabel:setAnchorPoint(0.5, 0.5)
	else
		self.numLabel = cc.LabelTTF:create("", "fonts/Marker Felt.ttf", 20)
		self.numLabel:setPosition(px, py)
		self.numLabel:setAnchorPoint(0.5, 0.5)
	end
	self:addChild(self.numLabel)
end

-- ������ȡ���ֵĺ��� --
function PieceClass:getNumber()
	return self.number
end

-- ����Ч������ --
function PieceClass:play()
	self.numLabel:runAction(cc.Sequence:create(cc.ScaleTo:create(0, 0.4, 0.4), cc.ScaleTo:create(0.5, 1, 1)))
end

-- �������ڴ�����Ϣ�ĺ���������λ�ú�Ӧ����ʾ������ --
function PieceClass:Display(num)
	self.number = num

	if num > 0 then
		self.numLabel:setString(num)
	else
		self.numLabel:setString("")
	end
end

function PieceClass:print_x(num)
	print(num)
end

return piece