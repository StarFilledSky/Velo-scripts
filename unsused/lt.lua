-- load targets but cleaner and better i think?
-- i don't actually have a use for this right now
--[[
a program for getting all the targets and putting it into a tree and writing it to a file
depth 1 contains targets and any unique field(subtargets) with subfields like actor
depth 2 has any fields that belong to the targets or subtargets

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

i move all the subtargets to the depth of 1 to avoid duplicates that would exponentially explode the node tree size if i just recursively added fields
]]

function spacer(character, amnt)
    str = ""
    for x = 1, amnt, 1 do
        str = str .. character
    end

    return str
end

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

function scanTargets(root, target_node)
    echo(target_node.name)
    fields = listFields(target_node.name)
    

    -- add subfields and check for unique fields
    for _, field in pairs(fields) do
        data = split(field, " : ")
        --creating and adding depth 2 nodes
        sub_node = newNode(data[1], data[2])
        target_node:addChild(sub_node)
        
        scanFields(root, sub_node)
    end
    
end

-- checking for unique values
function scanFields(root, node, depth)
    if depth == nil then depth = 0 end
    if depth == 4 then return end
    
    fields = listFields(node.obj_type)



    if node.obj_type == nil or node.obj_type == fields[1] or #fields < 1 then
        return
    end


    if root:isUnique(node.obj_type) then
        -- echo("breakpoint")
        -- add to depth 1 as a subtarget
        target_node = newNode(node.obj_type, "subtarget")
        root:addChild(target_node)
        
        -- add fields to subtarget
        for _, field in pairs(fields) do
            data = split(field, " : ")
            
            sub_node = newNode(data[1], data[2])
            target_node:addChild(sub_node)
            
            scanFields(root, sub_node, depth + 1)

        end

    end

end

function file_traversal(node, file, depth)

    if depth == nil then depth = 0 end
    if depth == 6 then return end
    
    if node.obj_type == nil then -- remove this 
        echo("there is a nil")
        echo(node.name)
    end
    
    str = spacer("\t", depth) .. node.name .. " | " .. node.obj_type .. "\n"
    file:write(str)
    
    for _, child in pairs(node.children) do
        file_traversal(child, file, depth + 1)
        -- echo("breakpoint")
    end
end


local root = newNode("root", "root")
local file = io.open("testing.txt", "w")

for _, target in pairs(listTargets()) do
    node =  newNode(target, "target")
    root:addChild(node)
end

for _, node in pairs(root.children) do
    scanTargets(root, node)
end

file_traversal(root, file)
file:close()