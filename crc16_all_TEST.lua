--

local crc16 = require("crc16")

--  Unicode codes for  '1'   '2'   '3'   '4'   '5'   '6'   '7'   '8'   '9'
local check_TABLE = { 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39 }
--                      49    50    51    52    53    54    55    56    57

local namespace = {}

function namespace:show_ALL()
    for k, v in pairs(crc16) do
        print(string.format("%8s    %s", k, v(check_TABLE)))
    end
end

return namespace