-- @author sky!!
-- @description This is for scaping all the variables accessible by Velo and exporting them to be put into the wiki.

local Category

local Target = {}
local Variable = {} -- sub-variables of target or class
local Class = {}

function Target:new()
    local obj = {}
    setmetatable(obj, Target)
    self.__index = self


    self.name = ""
    self.category = "Target"
    self.type = ""
    self.children = {}
    self.description = ""

    return obj
end
-- categories
function Variable:new()
    local obj = {}
    setmetatable(obj, Target)
    self.__index = self


    self.name = ""
    self.category = "Variable"
    self.type = ""
    self.children = {} -- i don't think this class needs this
    self.description = ""

    return obj

end

function Class:new()
    local obj = {}
    setmetatable(obj, Class)
    self.__index = self

    self.name = ""
    self.category = "Class"
    self.type = ""
    self.ClassName = ""
    self.children = {}
    self.description =  ""

    return obj
end