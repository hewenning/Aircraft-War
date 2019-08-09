require "mouse"
algorithm = {index =1,init = 1,}


-- ��ʼ�����飬��������� --
local ArrayValue = {}
for i=1, 16 do
    table.insert(ArrayValue, 0)
end

-- ����ͷ�����ʼ������ --
function algorithm.initArrayValue()
    ArrayValue = {}
    for i=1, 16 do
        table.insert(ArrayValue, 0)
    end
    score.count = 0
end

-- ��������� --
function algorithm.getRandomNumber(afterRandomArray)
    local tempArray = {}
    -- �ڲ���0��λ�����������2 --
    for position, value in ipairs(afterRandomArray) do
        if value == 0 then
            table.insert(tempArray, position)
        end
    end

    length = table.getn(tempArray)
    -- �ж��Ƿ��еط�������� --
    if length == 0 then
        return afterRandomArray
    end

    
    randomNum = math.random(1, length)
    -- ȷ���������λ��
    randomPosition = tempArray[randomNum]
    afterRandomArray[randomPosition] = 2

    return afterRandomArray
end

-- ���������ֵ --
algorithm.index = algorithm.getRandomNumber(ArrayValue)


--------------------
--    �㷨�߼����� --
--------------------
-- ���������ƶ����򣬴Ӷ���������ƶ� --
function algorithm.direction(move)
    -- ����һ��1*16����洢ÿ���ڵ���ֵ���Ϣ,��ʼ��ʱ�򶼳�ʼ��Ϊ0,���ֵ�ֵ�����λ�ó��ֵ����֣�ֻ������2�ı��� --
    -- ���ݽ��յĲ��������������ƶ����� --
    -- �����ƶ�
    if move == 1 then
        print("up")
        -- �������зǿ�Ԫ��
        for position, value in ipairs(ArrayValue) do
            if ArrayValue[position] ~= 0 then
                -- �����ǰԪ���ڵ�һ��λ��
                if position == 1 or position == 2 or position == 3 or position == 4 then
                    -- ����
                    --ArrayValue[position] = ArrayValue[position]
                -- ������ڵ�һ��λ��
                else
                    -- �����ǰԪ���Ϸ��ǿ�Ԫ��
                    if ArrayValue[position-12] == 0 and ArrayValue[position-8] == 0 and ArrayValue[position-4] == 0 then
                        ArrayValue[position-12] = ArrayValue[position]
                        ArrayValue[position] = 0
                    elseif ArrayValue[position-8] == 0 and ArrayValue[position-4] == 0 then
                        -- �����ƶ�
                        ArrayValue[position-8] = ArrayValue[position]
                        ArrayValue[position] = 0
                    elseif ArrayValue[position-4] == 0 then
                        -- �����ƶ�
                        ArrayValue[position-4] = ArrayValue[position]
                        ArrayValue[position] = 0
                    -- �����ǰԪ���Ϸ��Ƿǿ�Ԫ��
                    else
                        -- ����Ϸ�Ԫ�غ͵�ǰԪ�ص����ݲ�ͬ
                        if ArrayValue[position-4] ~= ArrayValue[position] then
                            -- ���� 
                            --ArrayValue[position-4] = ArrayValue[position-4]
                            --ArrayValue[position] = ArrayValue[position]
                        -- ����Ϸ�Ԫ���뵱ǰԪ��������ͬ 
                        else
                            -- ���Ϻϲ�
                            ArrayValue[position-4] = ArrayValue[position-4] + ArrayValue[position]
                            score.count = score.count + ArrayValue[position-4]
                            ArrayValue[position] = 0
                        end
                    end
                end
            end  
        end
        print("-------------")
        print("-- up over --")
        print("-------------")
        return ArrayValue
    end

    -- �����ƶ�
    if move == 2 then
        print("down")
        -- �������зǿ�Ԫ��
        for position, value in ipairs(ArrayValue) do
            if ArrayValue[position] ~= 0 then
                -- �����ǰԪ���ڵ�һ��λ��
                if position == 13 or position == 14 or position == 15 or position == 16 then
                    -- ����
                    --ArrayValue[position] = ArrayValue[position]
                -- ������ڵ�һ��λ��
                else
                    -- �����ǰԪ���·��ǿ�Ԫ��
                    if ArrayValue[position+4] == 0 then
                        -- �����ƶ�
                        ArrayValue[position+4] = ArrayValue[position]
                        ArrayValue[position] = 0
                    -- �����ǰԪ���·��Ƿǿ�Ԫ��
                    else
                        -- ����·�Ԫ�غ͵�ǰԪ�ص����ݲ�ͬ
                        if ArrayValue[position+4] ~= ArrayValue[position] then
                            -- ���� 
                            --ArrayValue[position+4] = ArrayValue[position+4]
                            --ArrayValue[position] = ArrayValue[position]
                        -- ����·�Ԫ���뵱ǰԪ��������ͬ 
                        else
                            -- ���ºϲ�
                            ArrayValue[position+4] = ArrayValue[position+4] + ArrayValue[position]
                            score.count = score.count + ArrayValue[position+4]
                            ArrayValue[position] = 0
                        end
                    end
                end
            end  
        end
        print("---------------")
        print("-- down over --")
        print("---------------")
        return ArrayValue
    end 
    
    -- �����ƶ�
    if move == 3 then
        print("left")
        -- �������зǿ�Ԫ��
        for position, value in ipairs(ArrayValue) do
            if ArrayValue[position] ~= 0 then
                -- �����ǰԪ���ڵ�һ��λ��
                if position == 1 or position == 5 or position == 9 or position == 13 then
                    -- ����
                    -- ArrayValue[position] = ArrayValue[position]
                -- ������ڵ�һ��λ��
                else
                    -- �����ǰԪ������ǿ�Ԫ�� --
                    if position == 4 or position == 8 or position == 12 or position == 16 then
                        if ArrayValue[position-3] == 0 and ArrayValue[position-2] == 0 and ArrayValue[position-1] == 0 then
                            -- �����ƶ�
                            ArrayValue[position-3] = ArrayValue[position]
                            ArrayValue[position] = 0                  
                        elseif ArrayValue[position-2] == 0 and ArrayValue[position-1] == 0 then
                            -- �����ƶ�
                            ArrayValue[position-2] = ArrayValue[position]
                            ArrayValue[position] = 0
                        elseif ArrayValue[position-1] == 0 then
                            -- �����ƶ�
                            ArrayValue[position-1] = ArrayValue[position]
                            ArrayValue[position] = 0
                        else
                            -- ������Ԫ�غ͵�ǰԪ�ص����ݲ�ͬ
                            if ArrayValue[position-1] ~= ArrayValue[position] then
                                -- ���� 
                                -- ArrayValue[position-1] = ArrayValue[position-1]
                                -- ArrayValue[position] = ArrayValue[position]
                            -- ������Ԫ���뵱ǰԪ��������ͬ 
                            else
                                -- ����ϲ�
                                ArrayValue[position-1] = ArrayValue[position-1] + ArrayValue[position]
                                score.count = score.count + ArrayValue[position-1]
                                ArrayValue[position] = 0
                            end
                        end
                    elseif position == 3 or position == 7 or position == 11 or position == 15 then
                        if ArrayValue[position-2] == 0 and ArrayValue[position-1] == 0 then
                            -- �����ƶ�
                            ArrayValue[position-2] = ArrayValue[position]
                            ArrayValue[position] = 0
                        elseif ArrayValue[position-1] == 0 then
                            -- �����ƶ�
                            ArrayValue[position-1] = ArrayValue[position]
                            ArrayValue[position] = 0
                        else
                            -- ������Ԫ�غ͵�ǰԪ�ص����ݲ�ͬ
                            if ArrayValue[position-1] ~= ArrayValue[position] then
                                -- ���� 
                                -- ArrayValue[position-1] = ArrayValue[position-1]
                                -- ArrayValue[position] = ArrayValue[position]
                            -- ������Ԫ���뵱ǰԪ��������ͬ 
                            else
                                -- ����ϲ�
                                ArrayValue[position-1] = ArrayValue[position-1] + ArrayValue[position]
                                score.count = score.count + ArrayValue[position-1]
                                ArrayValue[position] = 0
                            end
                        end
                    elseif ArrayValue[position-1] == 0 then
                        -- �����ƶ�
                        ArrayValue[position-1] = ArrayValue[position]
                        ArrayValue[position] = 0
                    else
                        -- ������Ԫ�غ͵�ǰԪ�ص����ݲ�ͬ
                        if ArrayValue[position-1] ~= ArrayValue[position] then
                            -- ���� 
                            -- ArrayValue[position-1] = ArrayValue[position-1]
                            -- ArrayValue[position] = ArrayValue[position]
                        -- ������Ԫ���뵱ǰԪ��������ͬ 
                        else
                            -- ����ϲ�
                            ArrayValue[position-1] = ArrayValue[position-1] + ArrayValue[position]
                            score.count = score.count + ArrayValue[position-1]
                            ArrayValue[position] = 0
                        end                    
                    end
                end
            end  
        end
        print("---------------")
        print("-- left over --")
        print("---------------")
        return ArrayValue
    end

    -- �����ƶ�
    if move == 4 then
        print("right")
        -- �������зǿ�Ԫ��
        for position, value in ipairs(ArrayValue) do
            if ArrayValue[position] ~= 0 then
                -- �����ǰԪ���ڵ�һ��λ��
                if position == 4 or position == 8 or position == 12 or position == 16 then
                    -- ����
                    -- ArrayValue[position] = ArrayValue[position]
                -- ������ڵ�һ��λ��
                else
                    -- �����ǰԪ���Ҳ��ǿ�Ԫ��
                    if ArrayValue[position+1] == 0 then
                        -- �����ƶ�
                        ArrayValue[position+1] = ArrayValue[position]
                        ArrayValue[position] = 0
                    -- �����ǰԪ���Ҳ��Ƿǿ�Ԫ��
                    else
                        -- ����Ҳ�Ԫ�غ͵�ǰԪ�ص����ݲ�ͬ
                        if ArrayValue[position+1] ~= ArrayValue[position] then
                            -- ���� 
                            -- ArrayValue[position+1] = ArrayValue[position+1]
                            -- ArrayValue[position] = ArrayValue[position]
                        -- ������Ԫ���뵱ǰԪ��������ͬ 
                        else
                            -- ����ϲ�
                            ArrayValue[position+1] = ArrayValue[position+1] + ArrayValue[position]
                            score.count = score.count + ArrayValue[position+1]
                            ArrayValue[position] = 0
                        end
                    end
                end
            end  
        end
        print("----------------")
        print("-- right over --")
        print("----------------")
        return ArrayValue
    end
end

-- �ж���Ϸ�Ƿ�ʤ�� --
function algorithm.getWin()
    -- �������ֵ�ﵽ2048��ֱ�ӽ�����Ϸ�����YouWin --
    for maxPosition, maxValue in ipairs(ArrayValue) do
        if maxValue == 2048 then
            local YouWin = cc.LabelTTF:create("You Win!", "fonts/Marker Felt.ttf", 40)
            ui.temp:addChild(YouWin)
            YouWin:setPosition(100, 100)
            YouWin:setAnchorPoint(0.5, 0.5)
            print("--------------")
            print("-- You Win! --")
            print("--------------")
        end
    end    
end

-- �ж���Ϸ�Ƿ���� --
function algorithm.getOver()
    -- �ж���Ϸ�Ƿ���� --
    local count = 0
    -- ��¼�ǿ�Ԫ�صĸ���
    for JudgeEnd, JudgeValue in ipairs(ArrayValue) do
        if JudgeValue ~= 0 then
            count = count +1
        end
    end
    -- ����ǿ�Ԫ�صĸ���Ϊ16
    if count == 16 then
        -- ѭ���������зǿ�Ԫ��
        for index, value in ipairs(ArrayValue) do
            -- ����Ԫ�ش��ڲ��Һ͵�ǰԪ��������ͬ
            if value == ArrayValue[index-4] then
                break
            -- ����Ԫ�ش��ڲ��Һ͵�ǰԪ��������ͬ
            elseif value == ArrayValue[index+4] then
                break
            -- ���Ԫ�ش��ڲ��Һ͵�ǰԪ��������ͬ
            elseif value == ArrayValue[index-1] then
                break
            -- �Ҳ�Ԫ�ش��ڲ��Һ͵�ǰԪ��������ͬ
            elseif value == ArrayValue[index+1] then
                break
            -- ���������������㣬��Ϸ����
            else
                local over = cc.LabelTTF:create("Game Over!", "fonts/Marker Felt.ttf", 40)
                ui.temp:addChild(over)
                over:setPosition(100, 100)
                over:setAnchorPoint(0.5, 0.5)
                print("----------------")
                print("-- Game Over! --")
                print("----------------")
            end  
        end                
    end    
end

return algorithm