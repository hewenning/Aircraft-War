archive = {infoTable= {},}

-- ����ͽ��뺯�� --
function archive.EncodeAndDecodeProtobuf()
    -- �����Ƿ�����ȷʹ��protobuf --
    -- ���ظ����ļ���������·�� --
    local pbFilePath = cc.FileUtils:getInstance():fullPathForFilename("protobuf/MsgProtocol.pb")
    -- �������·�� --
    release_print("PB file path: "..pbFilePath)
    -- pb.register_file "addressbook.pb"
    -- ע�ắ�� --
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

-- ������Ϸ --
function archive.saveGame()
    -- print("Save game.")
    controller.infoDisplay("Game data saved successfully.")
    archive.EncodeAndDecodeProtobuf()
end

-- ������Ϸ --
function archive.loadGame()
    -- print("Load game.")
    -- ��������е���Ϣ --
    gamelogic.shutdown()
    controller.initData()
    load.loadGame()
    controller.infoDisplay("The game data is loaded successfully.")

    -- ����,������Ϣ --
    -- ���ط��� --
    cclog("scoreValue is %d", archive.infoTable.score)
    score.value = archive.infoTable.score
    score.refreshScoreValue()
    -- ����Ӣ������ֵ --
    cclog("heroLife is %d", archive.infoTable.life)
    heroSet[1]:setLife(archive.infoTable.life)
    -- Ӣ�۵�Ѫ�� --
    cclog("heroHP is %d", archive.infoTable.hp)
    heroSet[1]:setHPbar(archive.infoTable.hp)
    -- Ӣ�۵�ը������ --
    cclog("bombNumber is %d", archive.infoTable.bombnum)
    prop.bombnum = archive.infoTable.bombnum
    prop.refreshBombNum()
 
end

return archive