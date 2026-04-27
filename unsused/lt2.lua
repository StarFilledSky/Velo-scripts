local success, util = pcall(require, "Velo\\scripts\\skyutil")
if not success then
    print("Module failed to load: " .. util)
    return
end

-- local Target = {}

function newTarget(name)
    local t = {}
    t.name = name or ""
    t.children = {}
    t.kind = "Target"
    t.description = ""

    return t

end

-- local Variable = {}

function newVariable(name, kind)
    local v = {}
    v.name = name or ""
    v.children = {}
    v.kind = kind or ""
    v.description = ""

    return v
end


-- maybe byte should get a description, not sure how interacting with it will go
local basic_types = {
     "bool"
    ,"string"
    ,"float"
    ,"int"
    ,"double"
    ,"ulong"
    ,"uint"
    ,"byte"
    ,"List"} 

function isBasic(value)
    local is_class = true
    for _, v in pairs(basic_types) do
        if value == v then
            is_class = false
        end
    end
    if string.find("List", value) ~= nil or string.find("[]", value) ~= nil then
        is_class = false
    end



    return is_class
end

-- returns a table with targets and their fields added in
function organize_targets()
    local root = {}
    local targets = listTargets()


    for _, v in pairs(targets) do
        local t = newTarget(v)
        local fields = listFields(t.name)
        table.insert(root, t)

        for _, f in pairs(fields) do
            local name, kind = table.unpack(util.split(f, " : "))

            local v = newVariable(name, kind)
            table.insert(t.children, v)
        end
    end
    return root
end

function organize_classes(root, field)
    for _, target in pairs(root) do
        -- continue here

    end

end

local root = organize_targets()




-- for _, x in pairs(root) do
--     echo(x.name .. " | " .. x.kind)
--     for _, y in pairs(x.children) do
--         echo("$[in:2]" .. y.name .. " | " .. y.kind)
--     end
-- end