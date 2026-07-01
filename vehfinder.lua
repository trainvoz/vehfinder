local findModel = nil

function main()
    repeat wait(0) until isSampAvailable()

    sampRegisterChatCommand("vehfind", function(arg)
        local id = tonumber(arg)
        if not id then
            sampAddChatMessage("{FF0000}Usage: /vehfind <model id>", -1)
            return
        end
        findModel = id
        sampAddChatMessage("{00FF00}Finding vehicles with model ID: " .. id, -1)
    end)

    sampRegisterChatCommand("vehreset", function()
        findModel = nil
        sampAddChatMessage("{FFFFFF}Vehicle finder reset.", -1)
    end)

    while true do
        wait(0)

        if findModel ~= nil then
            drawFilteredVehicleLines()
        end
    end
end

function drawFilteredVehicleLines()
    local px, py, pz = getCharCoordinates(PLAYER_PED)

    for _, veh in ipairs(getAllVehicles()) do
        if doesVehicleExist(veh) then
            local model = getCarModel(veh)

            if model == findModel then
                local vx, vy, vz = getCarCoordinates(veh)

                local sx1, sy1 = convert3DCoordsToScreen(px, py, pz)
                local sx2, sy2 = convert3DCoordsToScreen(vx, vy, vz)

                if sx1 and sy1 and sx2 and sy2 then
                    renderDrawLine(sx1, sy1, sx2, sy2, 2.0, 0xFFFFFFFF)
                end
            end
        end
    end
end
