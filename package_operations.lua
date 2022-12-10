--[[

]]--

function table.ireverse(t)
    local size = #t
    local new_Table = {}
    
    for i, v in ipairs(t) do
        new_Table[size - i + 1] = v
    end
    
    return new_Table
end

local namespace = {}

function namespace:number_to_Byte_Packet(num, bit_depth)
    bit_depth = bit_depth or 8
    local t = {}
    repeat
        t[#t + 1] = num % 2
        num = math.floor(num / 2)
    until num == 0
    while #t ~= bit_depth do
        t[#t + 1] = 0
    end
    t = table.ireverse(t)
    local pack = {}
    local j = 1
    local byte = 0
    for i = 1, #t do
        local d = t[i]
        byte = byte + math.floor(d * 2 ^ (8 - j))
        if j == 8 then
            table.insert(pack, byte)
            j = 1
            byte = 0
        else
            j = j + 1
        end
    end
    return pack
end

function namespace:pack_to_readable_Binary_String(pack)
    local res = ''
    for _, num in ipairs(pack) do
        local t = {}
        repeat
            t[#t + 1] = num % 2
            num = math.floor(num / 2)
        until num == 0
        while #t % 8 ~= 0 do
            t[#t + 1] = 0
        end
        local bits = table.concat(t):reverse()
        res = res .. bits .. ' '
    end
    return res
end

function namespace:pack_to_Binary_String(pack)
    local res = ''
    for _, num in ipairs(pack) do
        local t = {}
        repeat
            t[#t + 1] = num % 2
            num = math.floor(num / 2)
        until num == 0
        while #t % 8 ~= 0 do
            t[#t + 1] = 0
        end
        local bits = table.concat(t):reverse()
        res = res .. bits
    end
    return res
end

function namespace:xor_of_Packets(pack1, pack2)
    local xor = {}
    for i, v in ipairs(pack1) do
        xor[i] = v ~ pack2[i]
    end
    xor = self:pack_to_Binary_String(xor)
    return xor
end

return namespace