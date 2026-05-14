-- @author sky!!
-- @description This is for scaping all the variables accessible by Velo and exporting them to be put into the wiki.
local util = require("Velo\\scripts\\skyutil")

local Categories = {TARGET = 1, VARIABLE = 2, CLASS = 3}
local types = {}
local not_class = {
    "bool"
    ,"string"
    ,"float"
    ,"int"
    ,"double"
    ,"ulong"
    ,"uint"
    ,"byte"
    ,"List"
}

local Variable = {}
-- categories
function Variable:new(_name, _category, _type)
    local obj = {}
    setmetatable(obj, Variable)
    self.__index = self

    self.name = _name or "unknown"
    self.category = _category or Categories.VARIABLE
    self.type = _type or "unknown"
    self.children = {} -- i don't think this class needs this
    self.description = "unknown"

    return obj
end


function scrapeVariables()
    local obj = {}
    local test = getBaseTargets()
    printVar(test[1])

    scrapeChildren(test[1])
end

function scrapeChildren(var)
    local fields = listFields(var.name)
    for k, v in pairs(fields) do
        local split = util.split(v, " : ")
        local name = split[1]
        local type = split[2]
        local category = Categories.CLASS
        if contains(not_class, type) then
            category = Categories.VARIABLE
        end

        if category == Categories.CLASS and not contains(types, type) then
            table.insert(types)
        end

    end
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

function contains(set, key)
    return set[key] ~= nil
end


local variableList = scrapeVariables()

