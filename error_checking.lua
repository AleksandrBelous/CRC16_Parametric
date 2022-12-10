--[[

]]--

local namespace = {}

function namespace:is_One_Bit_err(xor)
    local _, c = string.gsub(xor, '1', '1')
    if c == 1 then
        return true
    else
        return false
    end
end

function namespace:is_Two_Diff_Bit_err(xor)
    local _, c = string.gsub(xor, '1', '1')
    local w1 = 0
    for _ in xor:gmatch('11') do
        w1 = w1 + 1
    end
    if c == 2 and w1 == 0 then
        return true
    else
        return false
    end
end

function namespace:is_Odd_Bit_err(xor)
    if self:is_Bit_Pack_err(xor) then
        return false
    end
    local _, c = string.gsub(xor, '1', '1')
    if c >= 3 and c % 2 ~= 0 then
        return true
    else
        return false
    end
end

function namespace:is_Bit_Pack_err(xor)
    
    local _, total = string.gsub(xor, '1', '1')
    local c = 0
    for i = 1, #xor do
        if xor:sub(i, i) == '1' then
            c = c + 1
            local toStop = false
            for j = i + 1, #xor do
                if xor:sub(j, j) == '1' and j == #xor then
                    c = c + 1
                    toStop = true
                    break
                elseif xor:sub(j, j) == '1' then
                    c = c + 1
                else
                    toStop = true
                    break
                end
            end
            if toStop then
                break
            end
        end
    end
    
    if c == total and total ~= 0 then
        return true
    else
        return false
    end
end

return namespace
