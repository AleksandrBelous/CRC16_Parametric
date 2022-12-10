--[[

]]--

local crc16 = require("crc16")
local package_operations = require('package_operations')
local draw = require('draw')
local error_checking = require('error_checking')
local TABLE = require('hash_TABLE')

function table.size(t)
    local c = 0
    for _ in pairs(t) do
        c = c + 1
    end
    return c
end

local namespace = {}

--namespace.hex_TABLE = { 0x00, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39 }

function namespace:statistics()
    local files = {
        [1] = '1_byte_test_base.txt',
        [2] = '2_byte_test_base.txt',
        [3] = '3_byte_test_base.txt',
        [4] = '4_byte_test_base.txt',
        [5] = '5_byte_p-1_test_base.txt'
    }
    for _, file_name in ipairs(files) do
        print(file_name)
        local hashes = {}
        for line in io.lines(file_name) do
            local package = {}
            for i = 1, #line do
                package[i] = TABLE[tonumber(string.sub(line, i, i)) + 1][i]
                ---- or ----
                --package[i] = string.byte(line, i, i)
            end
            for crc_name, crc_fn in pairs(crc16) do
                if hashes[crc_name] == nil then
                    hashes[crc_name] = { ['total'] = 0 }
                end
                local hash = crc_fn(package)
                if hashes[crc_name][hash] == nil then
                    hashes[crc_name][hash] = {}
                    hashes[crc_name]['total'] = hashes[crc_name]['total'] + 1
                end
                table.insert(hashes[crc_name][hash], package)
            end
        end
        local collisions = {}
        for crc_name, hash_info in pairs(hashes) do
            collisions[crc_name] = {}
            local single_bit_err = 'One bit err'
            local two_bit_err = 'Two bit err'
            local odd_bit_err = 'Odd bit err'
            local bit_pack_err = 'Bit PACK err'
            collisions[crc_name][single_bit_err] = 0
            collisions[crc_name][two_bit_err] = 0
            collisions[crc_name][bit_pack_err] = 0
            collisions[crc_name][odd_bit_err] = 0
            for hash_name, err_packs in pairs(hash_info) do
                if type(err_packs) == 'number' then
                    collisions[crc_name]['Used hashes'] = err_packs
                end
                if type(err_packs) == 'table' then
                    local size = table.size(err_packs)
                    if size > 1 then
                        for i = 1, size do
                            for j = i + 1, size do
                                local xor = package_operations:xor_of_Packets(err_packs[i], err_packs[j])
                                if error_checking:is_One_Bit_err(xor) then
                                    collisions[crc_name][single_bit_err] = collisions[crc_name][single_bit_err] + 1
                                elseif error_checking:is_Two_Diff_Bit_err(xor) then
                                    collisions[crc_name][two_bit_err] = collisions[crc_name][two_bit_err] + 1
                                elseif error_checking:is_Odd_Bit_err(xor) then
                                    collisions[crc_name][odd_bit_err] = collisions[crc_name][odd_bit_err] + 1
                                elseif error_checking:is_Bit_Pack_err(xor) then
                                    collisions[crc_name][bit_pack_err] = collisions[crc_name][bit_pack_err] + 1
                                end
                            end
                        end
                    end
                end
            end
        end
        draw:draw_TABLE(collisions)
    end
end

function namespace:explicit()
    local files = {
        [1] = '1_byte_test_base.txt',
        [2] = '2_byte_test_base.txt',
        [3] = '3_byte_test_base.txt',
        [4] = '4_byte_test_base.txt',
        [5] = '5_byte_p-1_test_base.txt'
    }
    for _, file_name in ipairs(files) do
        print(file_name)
        local hashes = {}
        for line in io.lines(file_name) do
            local package = {}
            for i = 1, #line do
                package[i] = string.byte(line, i, i)
                ---- or ----
                --package[i] = TABLE[tonumber(string.sub(line, i, i)) + 1][i]
            end
            for crc_name, crc_fn in pairs(crc16) do
                if hashes[crc_name] == nil then
                    hashes[crc_name] = { ['total'] = 0 }
                end
                local hash = crc_fn(package)
                if hashes[crc_name][hash] == nil then
                    hashes[crc_name][hash] = {}
                    hashes[crc_name]['total'] = hashes[crc_name]['total'] + 1
                end
                table.insert(hashes[crc_name][hash], package)
            end
        end
        local collisions = {}
        for crc_name, hash_info in pairs(hashes) do
            collisions[crc_name] = {}
            local single_bit_err = 'One bit err'
            local two_bit_err = 'Two bit err'
            local odd_bit_err = 'Odd bit err'
            local bit_pack_err = 'Bit PACK err'
            collisions[crc_name][single_bit_err] = {}
            collisions[crc_name][two_bit_err] = {}
            collisions[crc_name][bit_pack_err] = {}
            collisions[crc_name][odd_bit_err] = {}
            for hash_name, err_packs in pairs(hash_info) do
                if type(err_packs) == 'number' then
                    collisions[crc_name]['Used hashes'] = err_packs
                end
                if type(err_packs) == 'table' then
                    local size = table.size(err_packs)
                    if size > 1 then
                        for i = 1, size do
                            for j = i + 1, size do
                                local xor = package_operations:xor_of_Packets(err_packs[i], err_packs[j])
                                if error_checking:is_One_Bit_err(xor) then
                                    table.insert(collisions[crc_name][single_bit_err], xor)
                                elseif error_checking:is_Two_Diff_Bit_err(xor) then
                                    table.insert(collisions[crc_name][two_bit_err], xor)
                                elseif error_checking:is_Odd_Bit_err(xor) then
                                    table.insert(collisions[crc_name][odd_bit_err], xor)
                                elseif error_checking:is_Bit_Pack_err(xor) then
                                    table.insert(collisions[crc_name][bit_pack_err], xor)
                                end
                            end
                        end
                    end
                end
            end
        end
        draw:draw_TABLE(collisions)
    end
end

return namespace