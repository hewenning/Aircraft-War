bag = {}
function bag.Choose()

    cc.Director.sharedDirector():pause()
    local bagReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/bag.ccreator')
    bagReader:setup()
    local scenebag = bagReader:getSceneGraph()
    local bagground = scenebag:getChildByName("bag")
    bagground:removeFromParent(false)
    load.Canvas:addChild(bagground)

end

-- ¼ÌÐøÓÎÏ· --
function bag.Resume()
    load.Canvas:getChildByName("bag"):removeFromParent()
    cc.Director.sharedDirector():resume()
end

return bag