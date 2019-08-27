score = {value =0,}
function score.addScoreValue(num)
    score.value = score.value + num
    print(score.value)
    score.refreshScoreValue()
end

function score.refreshScoreValue()
    local label = load.Canvas:getChildByName("label")
    local scorevalue = label:getChildByName("scorevalue")
    scorevalue:setString(score.value)
end
return score