mall = {chooseTag = 1,}

function mall.ChooseAndResume()
    if mall.chooseTag%2 ~= 0 then
        cc.Director.sharedDirector():pause()
        local mallReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/mall.ccreator')
        mallReader:setup()
        local sceneMall = mallReader:getSceneGraph()
        local mallground = sceneMall:getChildByName("mall")
        mallground:removeFromParent(false)
        load.Canvas:addChild(mallground)
    end

    if mall.chooseTag%2 == 0 then
        load.Canvas:getChildByName("mall"):removeFromParent()
        cc.Director.sharedDirector():resume()
    end

    mall.chooseTag = mall.chooseTag + 1
    print(mall.chooseTag)

end

return mall