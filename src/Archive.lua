archive = {infoTable= {},}

-- ����ͽ��뺯�� --
function archive.protobufRegister()

end

-- ������Ϸ --
function archive.saveGame()
    -- print("Save game.")
    controller.infoDisplay("Game data saved successfully.")
    -- ע��pb�ļ� --
    local pbFilePath = cc.FileUtils:getInstance():fullPathForFilename("protobuf/MsgProtocol.pb")
    release_print("PB file path: "..pbFilePath)
    local buffer = read_protobuf_file_c(pbFilePath)
    protobuf.register(buffer)

    -- ��Ҫ��������ݽ��н��� --
    local data = protobuf.encode("Hero",      
        {      
            score = score.value,      
            life = heroSet[1]:getLife(),
            hp = heroSet[1]:getHP(),
            bombnum =  prop.bombnum,        
        })
    -- �ѻ�������д���ļ� --
    local txtFilePath = cc.FileUtils:getInstance():fullPathForFilename("protobuf/test.txt")     
    local txtFile = io.open(txtFilePath, "w")
    txtFile:write(data)
    txtFile.close()
    print("Save content to test.txt.")
end

-- ������Ϸ --
function archive.loadGame()
    -- print("Load game.")
    -- ��������е���Ϣ --
    gamelogic.shutdown()
    controller.initData()
    load.loadGame()
    controller.infoDisplay("The game data is loaded successfully.")

    -- ע��pb�ļ���������pb�ļ����н��� --
    local pbFilePath = cc.FileUtils:getInstance():fullPathForFilename("protobuf/MsgProtocol.pb")
    release_print("PB file path: "..pbFilePath)
    local buffer = read_protobuf_file_c(pbFilePath)
    protobuf.register(buffer)
    -- ��ȡtxt�ļ��е��ַ��� --
    local txtFilePath = cc.FileUtils:getInstance():fullPathForFilename("protobuf/test.txt")     
    local txtFile = io.open(txtFilePath, "r")
    local stringbuffer = txtFile:read("*all")
    txtFile:close()
    print("Load data from test.txt.")
    -- ���н��� --
    local loadArchiveInfo = protobuf.decode("Hero", stringbuffer)
    print(loadArchiveInfo)
    
    -- ���ط��� --
    cclog("scoreValue is %d", loadArchiveInfo.score)
    score.value = loadArchiveInfo.score
    score.refreshScoreValue()
    -- ����Ӣ������ֵ --
    cclog("heroLife is %d", loadArchiveInfo.life)
    heroSet[1]:setLife(loadArchiveInfo.life)
    -- Ӣ�۵�Ѫ�� --
    cclog("heroHP is %d", loadArchiveInfo.hp)
    heroSet[1]:setHPbar(loadArchiveInfo.hp)
    -- Ӣ�۵�ը������ --
    cclog("bombNumber is %d", loadArchiveInfo.bombnum)
    prop.bombnum = loadArchiveInfo.bombnum
    prop.refreshBombNum()
 
end

return archive