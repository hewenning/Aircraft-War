hit = {}

function hit.checkBulletToAlien()
    -- print("hit >>>>>>>>>>>>>>>>>>")
    -- if table.getn(alien.set) ~= 0 and table.getn(bullet.set) ~= 0 then
        for indexAlien, alienObj in pairs(alien.set) do
            -- if alienObj ~= nil then
                ----------------------------
                -- �������ж��Ƿ��Ӣ����ײ --
                ----------------------------
                -- print(load.hero:getBoundingBox().x, load.hero:getBoundingBox().y)
                -- alienObj:refreshBox()
                -- if cc.rectIntersectsRect(alienObj:getBox(), hero.getBox()) then
                --     -- print(hero.getBox().x, hero.getBox().y)
                --     -- ���˺ͷɻ�ͬ���ھ� --
                --     alienObj:setHP(1)
                --     alienObj:destroy()
                --     alien.set[indexAlien] = nil
                --     -- �ɻ����� --
                --     hero.destroy()
                --     --print(hero.getHP())
                --     -- hero.getHP()
                --     hero.getLife()
                --     break
                -- end 
                ----------------------------
                -- �������ж��Ƿ���ӵ���ײ --
                ----------------------------
                for indexBullet, bulletObj in pairs(bullet.set) do 
                    -- if bulletObj ~= nil then
                        alienObj:refreshBox()
                        bulletObj:refreshBox()
                        ----------------------------
                        -- �������ж��Ƿ���ӵ���ײ --
                        ----------------------------
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

-- function hit.checkAlienToHero()
--     for k, alienObject in pairs(alien.set) do
--         ----------------------------
--         -- �������ж��Ƿ��Ӣ����ײ --
--         ----------------------------
--         -- print(load.hero:getBoundingBox().x, load.hero:getBoundingBox().y)
--         alienObject:refreshBox()
--         if cc.rectIntersectsRect(alienObject:getBox(), hero.getBox()) then
--             -- print(hero.getBox().x, hero.getBox().y)
--             hero.destroy()
--             print(hero.getHP())
--         end              
--     end
-- end

return hit