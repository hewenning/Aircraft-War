bag = {chooseTag = 1,}

function bag.ChooseAndResume()
    if bag.chooseTag%2 ~= 0 then
        cc.Director.sharedDirector():pause()
        local bagReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/bag.ccreator')
        bagReader:setup()
        local scenebag = bagReader:getSceneGraph()
        local bagground = scenebag:getChildByName("bag")
        bagground:removeFromParent(false)
        load.Canvas:addChild(bagground)    
    end

    if bag.chooseTag%2 == 0 then
        load.Canvas:getChildByName("bag"):removeFromParent()
        cc.Director.sharedDirector():resume()
    end

    bag.chooseTag = bag.chooseTag + 1
    print(bag.chooseTag)
end

return bag