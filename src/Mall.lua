mall = {}
function mall.Choose()

    cc.Director.sharedDirector():pause()
    local mallReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/mall.ccreator')
    mallReader:setup()
    local sceneMall = mallReader:getSceneGraph()
    local mallground = sceneMall:getChildByName("mall")
    mallground:removeFromParent(false)
    load.Canvas:addChild(mallground)

end

-- ¼ÌÐøÓÎÏ· --
function mall.Resume()
    load.Canvas:getChildByName("mall"):removeFromParent()
    cc.Director.sharedDirector():resume()
end

return mall