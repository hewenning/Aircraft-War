controller = {}

function controller.PauesAndResume()
    -- -- ������ײϵͳ --
    -- local  manager = cc.Director.getCollisionManager()
    -- manager.enabled = true
    -- -- ������ײ���� --
    -- cc.Director.getCollisionManager().enabledDebugDraw = true
    local controller = creator.CreatorReader:createWithFilename('Resources/creator/Scene/controller.ccreator')
    controller:setup()
    local sceneController = controller:getSceneGraph()
    local controlground = sceneController:getChildByName("controlground")
    controlground:removeFromParent(false)
    load.Canvas:addChild(controlground)

end

return controller