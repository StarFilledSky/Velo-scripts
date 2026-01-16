--[[
a program for getting all the targets and putting it into a tree and writing it to a file
depth 1 contains targets and any unique field with subfields like actor
depth 2 has any fields that belong to the targets or fields with sub-fields

actor for example is a field with a subfield so it would show up like

Player: target
    actor: CActor
    airtime: int
	badConnectionImage: somethingsomething
    ...
CActor: subtarget
    velocity: Vector 2
    id: int
    ...


i move all the subtargets to the depth of 1 to avoid duplicates 
]]




function split(str, delimiter)
    local returnTable = {}
    
    for k, v in string.gmatch(str, "([^" .. delimiter .. "]+)") 
    do
        returnTable[#returnTable+1] = k
    end
    
    return returnTable
end



function newNode(name, obj_type)
    node = {}
    node.name = name
    node.obj_type = obj_type
    node.children = {}

    function node:addChild(child_node)
        table.insert(self.children, child_node)
    end

    function node:isUnique(entry)
        unique = true
        
        for k, child in pairs(self.children) do
            
            if child.name == entry then
                unique = false
                break
            end
        end

        return unique
    end
    
    return node
end




local root = newNode("root", "root")

-- add first layer targets
for k, target in pairs(listTargets()) do
    root:addChild(newNode(target, "target"))
end



function addType(root, target, depth)
    if depth == nil then depth = 0 end
    if depth == 3 then
        -- echo("probably stuck in some recursive hellhole")
        return
    end

    fields = listFields(target)

    if #fields < 1 or target == fields[1] then -- no sub fields or oddities like double : double
        return
    end

    node = newNode(target, "subtarget")
    -- tables are pass by reference so we can add the node here and add children to it later
    root:addChild(node)

    
    -- check for unique sub-fields
    for _, field in pairs(fields) do
        data = split(field, " : ")
        
        sub_node = newNode(data[1], data[2])
        node:addChild(sub_node)
        if root:isUnique(data[2]) then
            addType(root, data[1], depth + 1)
        end

    end

end

for unused1, node in pairs(root.children) do
    fields = listFields(node.name)
    
    for unused2, field in pairs(fields) do
        data = split(field, " : ")

        n = newNode(data[1], data[2])
    -- tables are pass by reference so we can add the node here and add children to it later
        node:addChild(n)

        -- if the type is not in the 1st lvl depth
        if root:isUnique(data[2]) then

            addType(root, data[2])
        end
    --     subfields = listFields(data[2])

    end

end


function spacer(character, amnt)
    str = ""
    for x = 1, amnt, 1 do
        str = str .. character
    end

    return str
end

local testfile = io.open("testing.txt", "w")

function df_traversal(node, depth)
    
    if depth == nil then depth = 0 end
    if depth == 6 then return end

    if node.obj_type == nil then
        echo("there is a nil")
        echo(node.name)
    end

    str = spacer("\t", depth) .. node.name .. " | " .. node.obj_type .. "\n"
    testfile:write(str)

    for _, child in pairs(node.children) do
        df_traversal(child, depth+1)
    end
    
end
df_traversal(root)
testfile:close()