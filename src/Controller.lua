controller = {}

function controller.PauesAndResume()
    -- -- 开启碰撞系统 --
    -- local  manager = cc.Director.getCollisionManager()
    -- manager.enabled = true
    -- -- 绘制碰撞区域 --
    -- cc.Director.getCollisionManager().enabledDebugDraw = true
    local controller = creator.CreatorReader:createWithFilename('Resources/creator/Scene/controller.ccreator')
    controller:setup()
    local sceneController = controller:getSceneGraph()
    local controlground = sceneController:getChildByName("controlground")
    controlground:removeFromParent(false)
    load.Canvas:addChild(controlground)

end

return controller