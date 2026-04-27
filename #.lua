--[[
command: #
will index folders for scripts
command: # [scriptname]
will run the script or restart it if it's already running

todo:
add debug subcommand
]]

-- only use relative paths i think

local success, util = pcall(require, "Velo\\scripts\\skyutil")
if not success then
    print("Module failed to load: " .. util)
    return
end

-- directories = ['.', "unused", ]

function file_exists(name) -- don't think i need this
   local f=io.open(name, "r")
   if f~=nil then
        io.close(f)
        return true
    else
        return false
    end
end

function scan_files(directory)
    local handle = io.popen("dir /B /S " .. dir) -- barebones and subdirectories
    local result = handle:read("*a")
    handle:close()

    results = util.split(result, "\n")
    return results
end

function filter_lua(files) -- filter for only lua form scan_filse

function copy_file(file1, file2)
    if not file_exists(file1) then
        echo("can't copy file, it isn't real :(")
        return
    end
    f1 = io.open(file1, "r")
    f2 = io.open(file2, "w")

    if f1 and f2 then -- files could be opened
        local data = f1:read("a")
        f2:write(data)
    else
        echo("couldn't copy file ".. file1)
    end

    f1:close()
    f2:close()
end

-- copies a file from a directory into the main directory so it can be run, returns the temporary file name
function copy_instance(file_obj)
    local origin_handle = io.open(file, "r")
    local rand = math.rahdom(1000, 9999)
    local tmp_file = "tmp" .. tostring(rand) ".lua"
    local origin_handle = io.open(file, "w")

end




-- # a velo shell
-- directories = ['.', "unused", ]
-- echo("# shell")
-- local success, util = pcall(require, "Velo\\scripts\\skyutil")
-- if not success then
--     print("Module failed to load: " .. util)
--     return
-- end

-- dir = "velo\\scripts"
-- local handle = io.popen("dir /B /S " .. dir) -- barebones and subdirectories
-- local result = handle:read("*a")
-- handle:close()

-- test = util.split(result, "\n")

-- for _, line in ipairs(test) do
--     filelink = util.split(line, "\\")
--     if #filelink > 1 then
--         file_path_arr = {table.unpack(filelink, 1, #filelink-1)}
--         file_name = filelink[#filelink]
--         file_path = util.join(file_path_arr, "\\")
--         -- echo("a" .. file_path)

--         if string.gmatch(file_name, ".lua$") then
--             echo("script: " .. file_name)
--         end
--     end
-- end

-- function listDirectory(directory)
--     local handle = io.popen("dir /B /S " .. directory) -- barebones and subdirectories
--     local result = handle:read("*a")
--     handle:close()

--     -- error checks
--     if result == "The system cannot find the path specified." then
        
--         echo("urhm couldn't find that directory,,,")
--     end

-- end

-- function getScripts(directory)
--     directory = directory or ""
--     local handle = io.popen("dir /B /S " .. directory) -- barebones and subdirectories
-- local result = handle:read("*a")
-- handle:close()

-- end
-- onPostUpdate = function()
--     entry = tostring(await(readLine()))
--     echo("input: " .. entry)
    
--     if string.lower(entry) == "exit" then
--         exit()
--     end
-- end