bag = {}

function bag.bagView()
    local bagViewReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/bagview.ccreator')
    local bagScene = bagViewReader:getSceneGraph()
    local bagNode = bagScene:getChildByName("bag")
    bagNode:removeFromParent(false)
    load.Canvas:addChild(bagNode)
    --bag.propPurchase()
end

return bag