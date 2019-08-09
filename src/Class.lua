function class(classname, ...)
    local cls = {__cname = classname}

    -- ֧�ֶ��ؼ̳� --
    local supers = {...}
    for _, super in ipairs(supers) do
        local superType = type(super)
        assert(superType == "nil" or superType == "table" or superType == "function",
            string.format("class() - create class \"%s\" with invalid super class type \"%s\"",
                classname, superType))
        
        --������class�̳еĵ�һ��������̳�һ��������������new֮ǰ��ִ�е��ڽ�����__create��
        if superType == "function" then
            assert(cls.__create == nil,
                string.format("class() - create class \"%s\" with more than one creating function",
                    classname));
            -- if super is function, set it to __create
            -- ���super��һ����������superֱ�Ӹ��Ƹ��ڽ�����__create
            cls.__create = super
        -- ������class�ĵڶ������������������������ֵ��table���͵�ʱ��
        -- ��lua��table�����֣�һ����lua��table����һ����c��ת��������һ�����ͽ�userTable������tolua
        elseif superType == "table" then
            -- ���������ǵڶ������
            -- �����.isclass���ֵ��˵���Ǵ�c++ת�����������ݽṹ
            if super[".isclass"] then
                -- super is native class    
                assert(cls.__create == nil,
                    string.format("class() - create class \"%s\" with more than one creating function or native class",
                        classname));                
                -- ������Կ������ּ̳���c�ṹ��������ʵҲֻ��ִ������֮ǰִ����һ�������������ķ���
                cls.__create = function() return super:create() end
            else
                -- ��������ǵ����������������lua�̳еĸ���Ҳ��lua����������һ���ڽ�����__supers�����������Ǵ�Ÿ������飨������ܲ�ֹһ����
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

    -- __index������һ��������ָ�ϡ�
    -- �����__index���ڼ̳й��ܵ�ģ��Ҳ�ܹؼ�
    -- ���򵥵�˵�������ҵ��÷�����ʱ��class�����ʵ�ּ̳й��ܵģ������������Լ��ĺ���δ�����ͻᰴ��__index��ָ��ȥ�������࣬ȥѰ�ҷ�����
    cls.__index = cls
    -- �������ĸ��಻���ڻ���ֻ����ֻ��һ������ô����������ָ��Ψһ�ĸ���
    if not cls.__supers or #cls.__supers == 1 then
        setmetatable(cls, {__index = cls.super})
    else
        -- �������Ĵ��ڶ�����࣬��ô������������������еĸ���
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

    -- �����new������ģ��cocos2dx����Ĵ�������
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
    
    -- ����ֻ��Ϊ��ģ��cocos2dx�ı��ϰ��
    cls.create = function(_, ...)
        return cls.new(...)
    end

    return cls
end