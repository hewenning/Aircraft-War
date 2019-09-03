archive = {}

function archive.saveGame()
    -- print("Save game.")
    controller.infoDisplay("Game data saved successfully.")
    -- cc.UserDefault:getInstance():setIntegerForKey("score", score.value)
    -- cc.UserDefault:getInstance():setIntegerForKey("life", heroSet[1]:getLife())
    -- cc.UserDefault:getInstance():setIntegerForKey("hp", heroSet[1]:getHP())
    -- cc.UserDefault:getInstance():setIntegerForKey("bombnum", prop.bombnum)

    -- 测试是否能正确使用protobuf --
    local pbFilePath = cc.FileUtils:getInstance():fullPathForFilename("protobuf/MsgProtocol.pb")
    release_print("PB file path: "..pbFilePath)
    
    local buffer = read_protobuf_file_c(pbFilePath)
    protobuf.register(buffer) --注:protobuf 是因为在protobuf.lua里面使用module(protobuf)来修改全局名字
    
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
    -- 先清空所有的信息 --
    gamelogic.shutdown()
    controller.initData()
    load.loadGame()
    controller.infoDisplay("The game data is loaded successfully.")
    
    -- 加载分数 --
    local scoreValue = cc.UserDefault:getInstance():getIntegerForKey("score")
    cclog("scoreValue is %d", scoreValue)
    score.value = scoreValue
    score.refreshScoreValue()

    -- 加载英雄生命值 --
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