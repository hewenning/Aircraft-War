hit = {}

function hit.checkBulletToAlien()
    -- print("hit >>>>>>>>>>>>>>>>>>")
    -- if table.getn(alien.set) ~= 0 and table.getn(bullet.set) ~= 0 then
        for indexAlien, alienObj in pairs(alien.set) do
            -- if alienObj ~= nil then
                ----------------------------
                -- 在这里判断是否和英雄碰撞 --
                ----------------------------
                --print(load.hero:getBoundingBox().x, load.hero:getBoundingBox().y)
                -- alienObj:refreshBox()
                -- if cc.rectIntersectsRect(alienObj:getBox(), hero.getBox()) then
                --     -- print(hero.getBox().x, hero.getBox().y)
                --     -- 敌人和飞机同归于尽 --
                --     alienObj:setHP(1)
                --     alienObj:destroy()
                --     alien.set[indexAlien] = nil
                --     -- 飞机死亡 --
                --     hero.destroy()
                --     --print(hero.getHP())
                --     -- hero.getHP()
                --     hero.getLife()
                --     break
                -- end 
                ----------------------------
                -- 在这里判断是否和子弹碰撞 --
                ----------------------------
                for indexBullet, bulletObj in pairs(bullet.set) do 
                    -- if bulletObj ~= nil then
                        alienObj:refreshBox()
                        bulletObj:refreshBox()
                        ----------------------------
                        -- 在这里判断是否和子弹碰撞 --
                        ----------------------------
                        if cc.rectIntersectsRect(alienObj:getBox(), bulletObj:getBox()) then
                            print("----------------------------------")
                            print("The rectangles have intersected.")
                            print("----------------------------------")
                            -- 相交之后子弹对象和飞机清空节点，并且将对应位置设置为空值 --
                            -- alienObj:boom()
                            score.addScoreValue(alienObj:getScore())
                            alienObj:destroy()
                            bulletObj:destroy()
                            local hp = alienObj:getHP()

                            -- 可能有遗留的指针没有销毁，后期加一个位置判断 --
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

function hit.checkAlienToHero()
    for i, alienObject in pairs(alien.set) do
        ----------------------------
        -- 在这里判断是否和英雄碰撞 --
        ----------------------------
        -- print(load.hero:getBoundingBox().x, load.hero:getBoundingBox().y)
        alienObject:refreshBox()
        local alienBox = alienObject:getBox()
        alienBox.x = alienBox.x + 320
        alienBox.y = alienBox.y + 520
        if cc.rectIntersectsRect(alienObject:getBox(), hero.getBox()) then
            -- print(hero.getBox().x, hero.getBox().y)
            hero.destroy()
            hero.getLife()
            alienObject:setHP(1)
            alienObject:destroy()
            alien.set[i] = nil
            break
        end              
    end
end

return hit