function Dev(...)
    if Config.DevMode then
        print(...)
    end
end

Citizen.CreateThread(function(threadId)
    local rn = GetCurrentResourceName()
    if rn ~= "PyThor_Timer" then
        print("Please don't change the resource name")
        StopResource(GetCurrentResourceName())
    end
end)

RegisterCommand(Config.Command, function(source, args)
    local amount = tonumber(args[2])
    local unit = args[1]

    if not amount or not unit then
        print("Usage: /" ..
            Config.Command ..
            " [" ..
            Config.TimeUnits.Seconds .. " / " .. Config.TimeUnits.Minutes .. " / " ..
            Config.TimeUnits.Hours .. "] " .. " [number]")
        return
    end

    local isValid = false
    local totalSeconds = 0
    unit = string.lower(unit)

    if unit == Config.TimeUnits.Seconds then
        totalSeconds = amount
        Dev("Command valid seconds: " .. totalSeconds)
    elseif unit == Config.TimeUnits.Minutes then
        totalSeconds = amount * 60
        Dev("Command valid seconds: " .. totalSeconds)
    elseif unit == Config.TimeUnits.Hours then
        totalSeconds = amount * 3600
        Dev("Command valid seconds: " .. totalSeconds)
    else
        print("Invalid time unit")
        return
    end
    if isValid then
        SendNUIMessage({
            type = 'time',
            seconds = totalSeconds
        })
    end
end, false)
