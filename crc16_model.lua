--[[

]]--

local namespace = {}

namespace.rev_TABLE = { 0x0, 0x8, 0x4, 0xC, 0x2, 0xA, 0x6, 0xE, 0x1, 0x9, 0x5, 0xD, 0x3, 0xB, 0x7, 0xF }

function namespace:reverse_bits(byte)
    -- reverses the right and left half-bits, then swap them
    return (self.rev_TABLE[(byte & 0xF) + 1] << 4) | self.rev_TABLE[(byte >> 4) + 1]
end

function namespace:reverse_bytes(byte_byte)
    return (self:reverse_bits(byte_byte & 0xFF) << 8) | self:reverse_bits(byte_byte >> 8)
end
-- ref is reflect
function namespace:crc16_Parametric(package, polynomial, xorIn, xorOut, refIn, refOut)
    local crc = xorIn
    for _, byte in ipairs(package) do
        if refIn then
            crc = (self:reverse_bits(byte) << 8) ~ crc
        else
            crc = (byte << 8) ~ crc
        end
        for _ = 1, 8 do
            if crc & 0x8000 == 0x8000 then
                crc = (crc << 1) ~ polynomial
            else
                crc = crc << 1
            end
        end
    end
    if refOut then
        crc = self:reverse_bytes(crc)
    end
    crc = crc ~ xorOut
    return string.format('%04X', crc)
end

function namespace:crc16_Parametric_explicit(package, polynomial, xorIn, xorOut, refIn, refOut)
    print('----- start -----')
    local package_operations = require('package_operations')
    local crc = xorIn
    for _, byte in ipairs(package) do
        --crc = crc & 0xFFFF
        print('crc: ' .. package_operations:pack_to_readable_Binary_String({ crc }))
        print('byte:' .. package_operations:pack_to_readable_Binary_String({ byte }))
        if refIn then
            crc = (self:reverse_bits(byte) << 8) ~ crc
        else
            crc = (byte << 8) ~ crc
        end
        print('crc: ' .. package_operations:pack_to_readable_Binary_String({ crc }))
        for i = 1, 8 do
            print('i = ' .. i)
            if crc & 0x8000 == 0x8000 then
                print('MSB == 1')
                print('crc     : ' .. package_operations:pack_to_readable_Binary_String({ crc }))
                print('crc << 1: ' .. package_operations:pack_to_readable_Binary_String({ crc << 1 }))
                print('poly    : ' .. package_operations:pack_to_readable_Binary_String({ polynomial }))
                crc = ((crc << 1) ~ polynomial) --& 0xffff
                print('crc     : ' .. package_operations:pack_to_readable_Binary_String({ crc }))
            else
                print('MSB == 0')
                print('crc     : ' .. package_operations:pack_to_readable_Binary_String({ crc }))
                print('crc << 1: ' .. package_operations:pack_to_readable_Binary_String({ crc << 1 }))
                crc = (crc << 1) --& 0xffff
            end
        end
    end
    if refOut then
        crc = self:reverse_bytes(crc)
    end
    crc = crc ~ xorOut
    print('----- end -----')
    return string.format('%04X', crc)
end

return namespace