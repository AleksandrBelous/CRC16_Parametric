--[[

]]--

local package_operations = require('package_operations')
local crc16 = require('crc16')

local namespace = {}

--[[
 2^8  = 256
 2^16 = 65536
 2^24 = 16777216
 2^32 = 4294967296
]]--

namespace.collisions = {}

function namespace:unstoppable()
    local n, dev = 0, 100
    local hashes = {}
    while true do
        local message = package_operations:number_to_Byte_Packet(n, 32)
        n = n + 1
        if n % dev == 0 then
            print(n)
        end
        for crc_name, crc_fn in pairs(crc16) do
            if hashes[crc_name] == nil then
                hashes[crc_name] = {}
            end
            local hash = crc_fn(message)
            if hashes[crc_name][hash] == nil then
                hashes[crc_name][hash] = 1
                hashes[crc_name]['coll'] = 0
            else
                hashes[crc_name][hash] = hashes[crc_name][hash] + 1
                hashes[crc_name]['coll'] = hashes[crc_name]['coll'] + 1
            end
            if n % dev == 0 then
                print(string.format('%8s, collisions happened: %s, relation: %.6f %%', crc_name, hashes[crc_name]['coll'], hashes[crc_name]['coll'] / n * 100))
            end
        end
        if n >= 100 * dev then
            dev = 50 * dev
        end
    end
end

--[[
 2^8  = 256
 2^16 = 65536
 2^24 = 16777216
 2^32 = 4294967296
]]--

function namespace:n_Byte_Packet()
    
    for x = 16, 40, 8 do
        local d = math.floor(2 ^ x)
        print()
        print(string.format('Key\'s distribution on [%s; %s]', d - 65536, d - 1))
        local hashes = {}
        for i = d - 65536, d - 1 do
            --main body
            local message = package_operations:number_to_Byte_Packet(i, x + 8)
            for crc_name, crc_fn in pairs(crc16) do
                if hashes[crc_name] == nil then
                    hashes[crc_name] = {}
                end
                local hash = crc_fn(message)
                if hashes[crc_name][hash] == nil then
                    hashes[crc_name][hash] = {}
                end
                table.insert(hashes[crc_name][hash], package_operations:pack_to_readable_Binary_String(message))
            end
        end
        for crc_name, sub_t in pairs(hashes) do
            print()
            print('=== ' .. crc_name .. ' ===')
            print()
            local c = 0
            for hash, number in pairs(sub_t) do
                c = c + 1
            end
            print('Used hashes: ' .. c)
        end
        print()
        print(string.format('Key\'s distribution on [%s; %s]', d, d + 65535))
        hashes = {}
        for i = d, d + 65535 do
            -- main body
            local message = package_operations:number_to_Byte_Packet(i, x + 8)
            for crc_name, crc_fn in pairs(crc16) do
                if hashes[crc_name] == nil then
                    hashes[crc_name] = {}
                end
                local hash = crc_fn(message)
                if hashes[crc_name][hash] == nil then
                    hashes[crc_name][hash] = {}
                end
                table.insert(hashes[crc_name][hash], package_operations:pack_to_readable_Binary_String(message))
            end
        end
        for crc_name, sub_t in pairs(hashes) do
            print()
            print('=== ' .. crc_name .. ' ===')
            print()
            local c = 0
            for hash, number in pairs(sub_t) do
                c = c + 1
            end
            print('Used hashes: ' .. c)
        end
    end
    
    --local hashes = {}
    --
    --local start, finish = 0, 65545
    --
    --for i = start, finish do
    --
    --    local message = package_operations:number_to_Byte_Packet(i, 32)
    --
    --    for crc_name, crc_fn in pairs(crc16) do
    --
    --        if hashes[crc_name] == nil then
    --            hashes[crc_name] = {}
    --        end
    --
    --        local hash = crc_fn(message)
    --
    --        if hashes[crc_name][hash] == nil then
    --            hashes[crc_name][hash] = {}
    --        end
    --
    --        table.insert(hashes[crc_name][hash], package_operations:pack_to_Binary_String(message))
    --    end
    --
    --end
    --for crc_name, sub_t in pairs(hashes) do
    --    print()
    --    print('=== ' .. crc_name .. ' ===')
    --    print()
    --    local c = 0
    --    for hash, number in pairs(sub_t) do
    --        c = c + 1
    --    end
    --    print('Used hashes: ' .. c)
    --end
end

return namespace