for i = 1, 10, 1 do
    local test = "this should be defined before the other test"
    echo("test string " .. tostring(test))
end

local test = "this is a test string"

echo("test string " .. tostring(test))
