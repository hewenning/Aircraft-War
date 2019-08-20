score = {value =0,}
function score.refresh(num)
    score.value = score.value + num
    print(score.value)
    local label = load.Canvas:getChildByName("label")
    local scorevalue = label:getChildByName("scorevalue")
    scorevalue:setString(score.value)
end
return score