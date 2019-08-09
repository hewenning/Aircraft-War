function class(classname, ...)
    local cls = {__cname = classname}

    -- 支持多重继承 --
    local supers = {...}
    for _, super in ipairs(supers) do
        local superType = type(super)
        assert(superType == "nil" or superType == "table" or superType == "function",
            string.format("class() - create class \"%s\" with invalid super class type \"%s\"",
                classname, superType))
        
        --这里是class继承的第一种情况，继承一个方法（在子类new之前先执行的内建函数__create）
        if superType == "function" then
            assert(cls.__create == nil,
                string.format("class() - create class \"%s\" with more than one creating function",
                    classname));
            -- if super is function, set it to __create
            -- 如果super是一个方法，把super直接复制给内建函数__create
            cls.__create = super
        -- 下面是class的第二，第三种情况，当传过来的值是table类型的时候
        -- 在lua里table分两种，一种是lua的table，另一种是c里转换过来的一种类型叫userTable，在用tolua
        elseif superType == "table" then
            -- 下面这种是第二种情况
            -- 如果有.isclass这个值则说明是从c++转换过来的数据结构
            if super[".isclass"] then
                -- super is native class    
                assert(cls.__create == nil,
                    string.format("class() - create class \"%s\" with more than one creating function or native class",
                        classname));                
                -- 这里可以看出这种继承了c结构的子类其实也只是执行子类之前执行了一个创建父类对象的方法
                cls.__create = function() return super:create() end
            else
                -- 后面这个是第三种情况，子类是lua继承的父类也是lua，这里有另一个内建函数__supers，他的作用是存放父类数组（父类可能不止一个）
                -- super is pure lua class
                cls.__supers = cls.__supers or {}
                cls.__supers[#cls.__supers + 1] = super
                if not cls.super then
                    -- set first super pure lua class as class.super
                    cls.super = super
                end
            end
        else
            error(string.format("class() - create class \"%s\" with invalid super type",
                        classname), 0)
        end
    end

    -- __index方法是一个“操作指南”
    -- 下面的__index对于继承功能的模拟也很关键
    -- 更简单的说就是在我调用方法的时候，class是如何实现继承功能的（当子类搜索自己的函数未果，就会按照__index的指引去搜索父类，去寻找方法）
    cls.__index = cls
    -- 如果子类的父类不存在或者只存在只有一个，那么把索引方法指向唯一的父类
    if not cls.__supers or #cls.__supers == 1 then
        setmetatable(cls, {__index = cls.super})
    else
        -- 如果子类的存在多个父类，那么把索引方法会遍历所有的父类
        setmetatable(cls, {__index = function(_, key)
            local supers = cls.__supers
            for i = 1, #supers do
                local super = supers[i]
                if super[key] then return super[key] end
            end
        end})
    end

    if not cls.ctor then
        -- add default constructor
        cls.ctor = function() end
    end

    -- 这里的new方法是模拟cocos2dx里面的创建对象
    cls.new = function(...)
        local instance
        if cls.__create then
            instance = cls.__create(...)
        else
            instance = {}
        end
        setmetatableindex(instance, cls)
        instance.class = cls
        instance:ctor(...)
        return instance
    end
    
    -- 这里只是为了模拟cocos2dx的编程习惯
    cls.create = function(_, ...)
        return cls.new(...)
    end

    return cls
end