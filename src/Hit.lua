hit = {}

function hit.update()
    -- print("hit >>>>>>>>>>>>>>>>>>")
    -- if table.getn(alien.set) ~= 0 and table.getn(bullet.set) ~= 0 then
        for indexAlien, alienObj in pairs(alien.set) do
            -- if alienObj ~= nil then
                ----------------------------
                -- �������ж��Ƿ��Ӣ����ײ --
                ----------------------------
                -- print(load.hero:getBoundingBox().x, load.hero:getBoundingBox().y)
                alienObj:refreshBox()
                if cc.rectIntersectsRect(alienObj:getBox(), hero.getBox()) then
                    -- print(">>>>>>>>>>>>>>>>>>>>")
                    -- print("Hero has intersected.")
                    -- print("<<<<<<<<<<<<<<<<<<<<")
                    hero.destroy()
                end
                ----------------------------
                -- �������ж��Ƿ���ӵ���ײ --
                ----------------------------
                for indexBullet, bulletObj in pairs(bullet.set) do 
                    -- if bulletObj ~= nil then
                        alienObj:refreshBox()
                        bulletObj:refreshBox()
                        -- print("hero:getBox():" ,load.hero:getBoundingBox().x ,load.hero:getBoundingBox().y ,load.hero:getBoundingBox().width ,load.hero:getBoundingBox().height)
                        -- print("alienObj:getBox():" ,alienObj:getBox().x ,alienObj:getBox().y ,alienObj:getBox().width ,alienObj:getBox().height)
                        -- print("bulletObj:getBox():" ,bulletObj:getBox().x ,bulletObj:getBox().y ,bulletObj:getBox().width ,bulletObj:getBox().height)
                        if cc.rectIntersectsRect(alienObj:getBox(), bulletObj:getBox()) then
                            print("----------------------------------")
                            print("The rectangles have intersected.")
                            print("----------------------------------")
                            -- �ཻ֮���ӵ�����ͷɻ���սڵ㣬���ҽ���Ӧλ������Ϊ��ֵ --
                            -- alienObj:boom()
                            score.refresh(alienObj:getScore())
                            alienObj:destroy()
                            bulletObj:destroy()
                            local hp = alienObj:getHP()

                            -- ������������ָ��û�����٣���һ��λ���ж� --
                            if hp == 0 then
                                alien.set[indexAlien] = nil
                            end
                            bullet.set[indexBullet] = nil
                            break
                        end
                    -- end                
                end
            -- end
        end 
    -- end
end

return hit