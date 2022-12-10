--[[

]]--

local model = require('crc16_model')

local namespace = {
    -----------------------------------------------------------------------------------
    --_10000_ = function(package)
    --    return model:crc16_Parametric(package, 0x10000, 0x0000, 0x0000, false, false)
    --end
    --,
    --    _10001_ = function(package)
    --        return model:crc16_Parametric(package, 0x10001, 0x0000, 0x0000, false, false)
    --    end
    --,
    --_18000_ = function(package)
    --    return model:crc16_Parametric(package, 0x18000, 0x0000, 0x0000, false, false)
    --end
    --,
    --    _18001_ = function(package)
    --        return model:crc16_Parametric(package, 0x18001, 0x0000, 0x0000, false, false)
    --    end
    --,
    --    _11021_ = function(package)
    --        return model:crc16_Parametric(package, 0x11021, 0x0000, 0x0000, false, false)
    --    end
    --,
    --    _18005_ = function(package)
    --        return model:crc16_Parametric(package, 0x18005, 0x0000, 0x0000, false, false)
    --    end
    --,
    -----------------------------------------------------------------------------------
    XMODEM = function(package)
        --- CRC-16/XMODEM
        --- Alias: CRC-16/ACORN, CRC-16/LTE, CRC-16/V-41-MSB, XMODEM, ZMODEM
        return model:crc16_Parametric(package, 0x11021, 0x0000, 0x0000, false, false)
    end
,
    IBM_3740 = function(package)
        --- CRC16/IBM-7340
        --- Alias: CRC-16/AUTOSAR, CRC-16/CCITT-FALSE
        return model:crc16_Parametric(package, 0x11021, 0xFFFF, 0x0000, false, false)
    end
,
    GSM = function(package)
        --- CRC-16/GSM
        --- Alias:
        return model:crc16_Parametric(package, 0x11021, 0x0000, 0xFFFF, false, false)
    end
,
    GENIBUS = function(package)
        --- CRC-16/GENIBUS
        --- Alias: CRC-16/DARC, CRC-16/EPC, CRC-16/EPC-C1G2, CRC-16/I-CODE
        return model:crc16_Parametric(package, 0x11021, 0xFFFF, 0xFFFF, false, false)
    end
,
    FUJITSU = function(package)
        --- CRC-16/SPI-FUJITSU
        --- Alias: CRC-16/AUG-CCITT
        return model:crc16_Parametric(package, 0x11021, 0x1D0F, 0x0000, false, false)
    end
,
    KERMIT = function(package)
        --- CRC16/KERMIT
        --- Alias: CRC-16/BLUETOOTH, CRC-16/CCITT, CRC-16/CCITT-TRUE, CRC-16/V-41-LSB, CRC-CCITT, KERMIT
        return model:crc16_Parametric(package, 0x11021, 0x0000, 0x0000, true, true)
    end
,
    MCRF4XX = function(package)
        --- CRC16/MCRF4XX
        --- Alias:
        return model:crc16_Parametric(package, 0x11021, 0xFFFF, 0x0000, true, true)
    end
,
    IBM_SDLC = function(package)
        --- CRC16/IBM-SDLC
        --- Alias: CRC-16/ISO-HDLC, CRC-16/ISO-IEC-14443-3-B, CRC-16/X-25, CRC-B, X-25
        return model:crc16_Parametric(package, 0x11021, 0xFFFF, 0xFFFF, true, true)
    end
,
    ISO_IEC = function(package)
        --- CRC16/ISO-IEC
        --- Alias: CRC-A
        return model:crc16_Parametric(package, 0x11021, 0xC6C6, 0x0000, true, true)
    end
    --,
    --    -------------------------------------------------------------------------------------------------------------------
    --
    --    UMTS = function(package)
    --        --- CRC16/
    --        --- Alias:
    --        return model:crc16_Parametric(package, 0x18005, 0x0000, 0x0000, true, true)
    --    end
    --,
    --    MODBUS = function(package)
    --        --- CRC16/MODBUS
    --        --- Alias:
    --        return model:crc16_Parametric(package, 0x18005, 0xFFFF, 0x0000, true, true)
    --    end
    --,
    --    C001 = function(package)
    --        --- CRC16/
    --        --- Alias:
    --        return model:crc16_Parametric(package, 0xC001, 0x0000, 0x0000, false, false)
    --    end
    --------------------------------------------------
    -- 0x11 is interesting
    --_00011_ = function(package)
    --    return model:crc16_Parametric(package, 0x0011, 0x0000, 0x0000, false, false)
    --end
    --------------------------------------------------
}

return namespace