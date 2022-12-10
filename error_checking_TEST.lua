--
local error_checking = require('error_checking')

local bitErrCheck = {
    ['One bit err'] = {},
    ['Two diff bit err'] = {},
    ['Odd bit err'] = {},
    ['Bit PACK err'] = {}
}

for byte in io.lines('bit_8_test_base.txt') do
    if error_checking:is_One_Bit_err(byte) then
        table.insert(bitErrCheck['One bit err'], byte)
    elseif error_checking:is_Two_Diff_Bit_err(byte) then
        table.insert(bitErrCheck['Two diff bit err'], byte)
    elseif error_checking:is_Odd_Bit_err(byte) then
        table.insert(bitErrCheck['Odd bit err'], byte)
    elseif error_checking:is_Bit_Pack_err(byte) then
        table.insert(bitErrCheck['Bit PACK err'], byte)
    end
end

local draw = require('draw')

draw:draw_TABLE(bitErrCheck)