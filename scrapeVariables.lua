-- @author sky!!
-- @description This is for scaping all the variables accessible by Velo and exporting them to be put into the wiki. Rewrite from lt and lt2.
local util = require("Velo\\scripts\\skyutil")

local variablesPath = "C:/Home/Projects/Velo-Docs/src/Variables.md"
local classesPath = "C:/Home/Projects/Velo-Docs/src/Classes.md"

local Categories = {
    TARGET = 1,
    VARIABLE = 2,
    CLASS = 3
}
local passAmount = 3 -- the amount of times to scan for new classes buried in other classes

local types = {}
local coveredTypes = {}
local notClass = {
    bool = 1,
    string = 1,
    float = 1,
    int = 1,
    double = 1,
    ulong = 1,
    uint = 1,
    byte = 1,
    List = 1
}

local Variable = {}
-- categories
function Variable:new(_name, _category, _type)
    local obj = {}
    setmetatable(obj, Variable)
    self.__index = self

    obj.name = _name or "unknown"
    obj.category = _category or Categories.VARIABLE
    obj.type = _type or "unknown"
    obj.children = {}
    obj.description = "unknown"

    return obj
end

function scrapeVariables()
    local obj = {}
    local data = getBaseTargets()

    for k, v in pairs(data) do

        local children = scrapeChildren(v.name)
        v.children = children

    end

    for i = 1, passAmount do
        for type, _ in pairs(types) do
            if not contains(coveredTypes, type) then -- if it hasn't already been added
                local children = scrapeChildren(type)
                if #children > 1 then
                    local x = Variable:new(type, Categories.CLASS, "Class")
                    x.children = children

                    coveredTypes[type] = 1
                    table.insert(data, x)
                end
            end
        end
    end

    return data
end

function scrapeChildren(fieldName)
    local fields = listFields(fieldName)
    local obj = {}

    for k, v in pairs(fields) do
        local split = util.split(v, " : ")
        local name = split[1]
        local type = split[2]
        local category = Categories.CLASS

        if contains(notClass, type) then
            category = Categories.VARIABLE
        end

        if category == Categories.CLASS and not contains(types, type) then
            types[type] = 1
        end

        local x = Variable:new(name, category, type)
        table.insert(obj, x)
    end

    return obj
end

function getBaseTargets()
    local obj = {}
    local targetList = listTargets()

    for k, target in pairs(targetList) do
        local x = Variable:new(target, Categories.TARGET, target)
        table.insert(obj, x)
    end

    return obj
end

function printVar(var)
    local str = string.format("%s %s %s", var.name, var.category, var.type)
    echo(str)
end

function writeVariablesPage(set)
    local file = io.open(path, "w")

    for k, v in ipairs(set) do
        local str = string.format("## `%s` %s  \n", EnumPretty(Categories, v.category), v.name)
        for _, child in pairs(v.children) do
            str = str .. string.format("> `%s` %s  \n", child.type, child.name)
        end
        -- > <!-- replacement --> `float`<!--:--> height  

        file:write(str)
    end

    file:close()
end

function writeClassPage(set)

end

function printJson(set)
    -- todo probably don't need this for now, just going to format and export directly
end

function contains(set, key)
    return set[key] ~= nil
end

-- todo think of better name
function EnumPretty(enum, value)
    if value == Categories.CLASS then
        return "Class"
    end
    if value == Categories.TARGET then
        return "Target"
    end
    if value == Categories.VARIABLE then
        return "Variable"
    end
end

-- todo think of better name
function EnumMap(enum, value)
    for k, v in pairs(enum) do
        if v == value then
            return k
        end
    end
    return nil
end

local variableList = scrapeVariables()
writeVariablesPage(variableList)
