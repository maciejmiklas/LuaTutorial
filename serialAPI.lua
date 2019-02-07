sapi = { uratId = 0, baud = 115200 }
scmd = {}

local function onData(data)
    if data == nil then return end

    local dataLen = string.len(data);
    if dataLen < 5 then return end

    local status, err
    -- static command has 3 characters + \t\n
    if dataLen == 5 then
        local cmd = string.sub(data, 1, 3)
        status, err = pcall(scmd[cmd])

        -- dynamic command has folowwing format: [3 chars command][space][param]
    else
        local cmd = string.sub(data, 1, 3)
        local param = string.sub(data, 4, dataLen):gsub('%W', '')
        status, err = pcall(scmd[cmd], param)
    end

    if status ~= true then uart.write(0, "ERR:" .. err .. '\n') end
end

function sapi.start()
    --gpio.mode(sapi.pin, gpio.OUTPUT)

    -- configure for 115200, 8N1, no echo
    uart.setup(sapi.uratId, sapi.baud, 8, uart.PARITY_NONE, uart.STOPBITS_1, 0)
    uart.on("data", '\n', onData, 0)
end