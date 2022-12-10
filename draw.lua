--[[

]]--

function table.maxKeyLen(t)
    local maxLen = 0
    for k, _ in pairs(t) do
        if string.len(k) > maxLen then
            maxLen = string.len(k)
        end
    end
    return maxLen
end

local namespace = {}

function namespace:draw_TABLE(t, margin)
    margin = margin or 0
    local max = table.maxKeyLen(t)
    for k, v in pairs(t) do
        io.write('\n' .. string.rep(' ', margin + math.abs(max - string.len(k))))
        io.write(string.format('%s', k) .. ' :')
        margin = max + margin + 2
        if type(v) == 'table' then
            self:draw_TABLE(v, margin)
        else
            io.write(' ' .. v)
        end
        margin = margin - max - 2
    end
    io.write('\n')
end

return namespace