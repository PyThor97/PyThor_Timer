local VorpCore = {}
local timerOn = false

TriggerEvent("getCore", function(core)
    VorpCore = core
end)

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

TriggerEvent('chat:addSuggestion', '/' .. Config.Command, 'Starts a countdown timer', {
    {
        name = "Time unit",
        help = "The unit type "
            .. "[Hours: " .. Config.TimeUnits.Hours ..
            "| Minutes: " .. Config.TimeUnits.Minutes ..
            "| Seconds: " .. Config.TimeUnits.Seconds .. ']'
    },
    { name = "amount", help = "The number of units (e.g. 5)" }
})

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
        isValid = true
    elseif unit == Config.TimeUnits.Minutes then
        totalSeconds = amount * 60
        Dev("Command valid seconds: " .. totalSeconds)
        isValid = true
    elseif unit == Config.TimeUnits.Hours then
        totalSeconds = amount * 3600
        Dev("Command valid seconds: " .. totalSeconds)
        isValid = true
    else
        print("Invalid time unit")
        return
    end
    if isValid and not timerOn then
        timerOn = true

        SendNUIMessage({
            type = 'time',
            seconds = totalSeconds
        })

        CreateThread(function()
            Wait(totalSeconds * 1000)
            timerOn = false
        end)
    else
        VorpCore.NotifyRightTip("You already have a timer running!", 4000)
    end
end, false)

TriggerEvent('chat:addSuggestion', '/' .. Config.CommandStopTimer, 'Stop an active countdown timer')

RegisterCommand(Config.CommandStopTimer, function()
    if timerOn then
        timerOn = false
        SendNUIMessage({ action = "hide" })
        SetNuiFocus(false, false)
        VorpCore.NotifyRightTip("Timer stopped manually.", 4000)
    else
        VorpCore.NotifyRightTip("No timer is currently running.", 4000)
    end
end, false)
