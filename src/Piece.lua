-- 设定一个显示的类，可以新建对象，每个对象可以使用里面的函数 --
-- 新建一个棋盘显示的类，并在类里面完成初始化 --

piece = {index = 1,}

local PieceClass = class("PieceClass", function ()
    return cc.Node:create()
end)

piece.index = PieceClass

-- 定义类的构造函数 --
function PieceClass:ctor(num, px, py)
	self.number = num
	self.px = px
	self.py = py
	-- 初始化 --
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

-- 用来获取数字的函数 --
function PieceClass:getNumber()
	return self.number
end

-- 动画效果函数 --
function PieceClass:play()
	self.numLabel:runAction(cc.Sequence:create(cc.ScaleTo:create(0, 0.4, 0.4), cc.ScaleTo:create(0.5, 1, 1)))
end

-- 定义用于储存信息的函数，关于位置和应该显示的数字 --
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