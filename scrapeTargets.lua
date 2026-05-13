-- @author sky!!
-- @description This is for scaping all the variables accessible by Velo and exporting them to be put into the wiki.

local Category = {TARGET = 1, Variable = 2, Class = 3}

local Variable = {}

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
