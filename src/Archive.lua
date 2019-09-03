archive = {infoTable= {},}

-- 编码和解码函数 --
function archive.protobufRegister()

end

-- 保存游戏 --
function archive.saveGame()
    -- print("Save game.")
    controller.infoDisplay("Game data saved successfully.")
    -- 注册pb文件 --
    local pbFilePath = cc.FileUtils:getInstance():fullPathForFilename("protobuf/MsgProtocol.pb")
    release_print("PB file path: "..pbFilePath)
    local buffer = read_protobuf_file_c(pbFilePath)
    protobuf.register(buffer)

    -- 把要存入的数据进行解析 --
    local data = protobuf.encode("Hero",      
        {      
            score = score.value,      
            life = heroSet[1]:getLife(),
            hp = heroSet[1]:getHP(),
            bombnum =  prop.bombnum,        
        })
    -- 把缓冲数据写入文件 --
    local txtFilePath = cc.FileUtils:getInstance():fullPathForFilename("protobuf/test.txt")     
    local txtFile = io.open(txtFilePath, "w")
    txtFile:write(data)
    txtFile.close()
    print("Save content to test.txt.")
end

-- 载入游戏 --
function archive.loadGame()
    -- print("Load game.")
    -- 先清空所有的信息 --
    gamelogic.shutdown()
    controller.initData()
    load.loadGame()
    controller.infoDisplay("The game data is loaded successfully.")

    -- 注册pb文件，并利用pb文件进行解码 --
    local pbFilePath = cc.FileUtils:getInstance():fullPathForFilename("protobuf/MsgProtocol.pb")
    release_print("PB file path: "..pbFilePath)
    local buffer = read_protobuf_file_c(pbFilePath)
    protobuf.register(buffer)
    -- 读取txt文件中的字符串 --
    local txtFilePath = cc.FileUtils:getInstance():fullPathForFilename("protobuf/test.txt")     
    local txtFile = io.open(txtFilePath, "r")
    local stringbuffer = txtFile:read("*all")
    txtFile:close()
    print("Load data from test.txt.")
    -- 进行解码 --
    local loadArchiveInfo = protobuf.decode("Hero", stringbuffer)
    print(loadArchiveInfo)
    
    -- 加载分数 --
    cclog("scoreValue is %d", loadArchiveInfo.score)
    score.value = loadArchiveInfo.score
    score.refreshScoreValue()
    -- 加载英雄生命值 --
    cclog("heroLife is %d", loadArchiveInfo.life)
    heroSet[1]:setLife(loadArchiveInfo.life)
    -- 英雄的血条 --
    cclog("heroHP is %d", loadArchiveInfo.hp)
    heroSet[1]:setHPbar(loadArchiveInfo.hp)
    -- 英雄的炸弹数量 --
    cclog("bombNumber is %d", loadArchiveInfo.bombnum)
    prop.bombnum = loadArchiveInfo.bombnum
    prop.refreshBombNum()
 
end

return archive