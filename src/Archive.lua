archive = {}

function archive.saveGame()
    -- print("Save game.")
    controller.infoDisplay("Game data saved successfully.")
    -- cc.UserDefault:getInstance():setIntegerForKey("score", score.value)
    -- cc.UserDefault:getInstance():setIntegerForKey("life", heroSet[1]:getLife())
    -- cc.UserDefault:getInstance():setIntegerForKey("hp", heroSet[1]:getHP())
    -- cc.UserDefault:getInstance():setIntegerForKey("bombnum", prop.bombnum)

    -- �����Ƿ�����ȷʹ��protobuf --
    local pbFilePath = cc.FileUtils:getInstance():fullPathForFilename("protobuf/MsgProtocol.pb")
    release_print("PB file path: "..pbFilePath)
    
    local buffer = read_protobuf_file_c(pbFilePath)
    protobuf.register(buffer) --ע:protobuf ����Ϊ��protobuf.lua����ʹ��module(protobuf)���޸�ȫ������
    
    local stringbuffer = protobuf.encode("Person",      
        {      
            name = "Alice",      
            id = 12345,      
            phone = {      
                {      
                    number = "87654321"      
                },      
            }      
        })           
    
    
    local slen = string.len(stringbuffer)
    release_print("slen = "..slen)
    
    local temp = ""
    for i=1, slen do
        temp = temp .. string.format("0xX, ", string.byte(stringbuffer, i))
    end
    release_print(temp)
    local result = protobuf.decode("Person", stringbuffer)
    release_print("result name: "..result.name)
    release_print("result name: "..result.id)

end

function archive.loadGame()
    -- print("Load game.")
    -- ��������е���Ϣ --
    gamelogic.shutdown()
    controller.initData()
    load.loadGame()
    controller.infoDisplay("The game data is loaded successfully.")
    
    -- ���ط��� --
    local scoreValue = cc.UserDefault:getInstance():getIntegerForKey("score")
    cclog("scoreValue is %d", scoreValue)
    score.value = scoreValue
    score.refreshScoreValue()

    -- ����Ӣ������ֵ --
    local heroLife = cc.UserDefault:getInstance():getIntegerForKey("life")
    cclog("heroLife is %d", heroLife)
    heroSet[1]:setLife(heroLife)

    local heroHP = cc.UserDefault:getInstance():getIntegerForKey("hp")
    cclog("heroHP is %d", heroHP)
    heroSet[1]:setHPbar(heroHP)

    local bombNumber = cc.UserDefault:getInstance():getIntegerForKey("bombnum")
    cclog("bombNumber is %d", bombNumber)
    prop.bombnum = bombNumber
    prop.refreshBombNum()
 
end

return archive