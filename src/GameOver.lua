gameover ={Canvas = 0,}

function gameover.mainScene()
    cc.Director:getInstance():pause()
    local overReader = creator.CreatorReader:createWithFilename('Resources/creator/Scene/gameover.ccreator')
    overReader:setup()
    local overScene = overReader:getSceneGraph()
    cc.Director:getInstance():replaceScene(overScene)

    -- ��ȡ�����µĽڵ� -- 
    local children = overScene:getChildren()
    gameover.Canvas = children[2]

end

return gameover