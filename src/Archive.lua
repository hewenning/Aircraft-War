archive = {infoTable= {},}

-- 编码和解码函数 --
function archive.EncodeAndDecodeProtobuf()
    -- 测试是否能正确使用protobuf --
    -- 返回给定文件名的完整路径 --
    local pbFilePath = cc.FileUtils:getInstance():fullPathForFilename("protobuf/MsgProtocol.pb")
    -- 打出完整路径 --
    release_print("PB file path: "..pbFilePath)
    -- pb.register_file "addressbook.pb"
    -- 注册函数 --
    local buffer = read_protobuf_file_c(pbFilePath)
    protobuf.register(buffer)

    local stringbuffer = protobuf.encode("Hero",      
        {      
            score = score.value,      
            life = heroSet[1]:getLife(),
            hp = heroSet[1]:getHP(),
            bombnum =  prop.bombnum,        
        })           
    local loadArchiveInfo = protobuf.decode("Hero", stringbuffer)
    archive.infoTable = loadArchiveInfo
end

-- 保存游戏 --
function archive.saveGame()
    -- print("Save game.")
    controller.infoDisplay("Game data saved successfully.")
    archive.EncodeAndDecodeProtobuf()
end

-- 载入游戏 --
function archive.loadGame()
    -- print("Load game.")
    -- 先清空所有的信息 --
    gamelogic.shutdown()
    controller.initData()
    load.loadGame()
    controller.infoDisplay("The game data is loaded successfully.")

    -- 解码,加载信息 --
    -- 加载分数 --
    cclog("scoreValue is %d", archive.infoTable.score)
    score.value = archive.infoTable.score
    score.refreshScoreValue()
    -- 加载英雄生命值 --
    cclog("heroLife is %d", archive.infoTable.life)
    heroSet[1]:setLife(archive.infoTable.life)
    -- 英雄的血条 --
    cclog("heroHP is %d", archive.infoTable.hp)
    heroSet[1]:setHPbar(archive.infoTable.hp)
    -- 英雄的炸弹数量 --
    cclog("bombNumber is %d", archive.infoTable.bombnum)
    prop.bombnum = archive.infoTable.bombnum
    prop.refreshBombNum()
 
end

return archive