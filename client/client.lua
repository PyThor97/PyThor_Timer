function Dev()

end

RegisterCommand("timer", function(source, args)
    local amount = tonumber(args[1])
    local unit = args[2]

    if not amount or not unit then
        print("שימוש: /timer [מספר] [sec|min|hour]")
        return
    end

    local totalSeconds = 0
    unit = string.lower(unit)

    if unit == "sec" or unit == "second" or unit == "seconds" then
        totalSeconds = amount
    elseif unit == "min" or unit == "minute" or unit == "minutes" then
        totalSeconds = amount * 60
    elseif unit == "hour" or unit == "hours" then
        totalSeconds = amount * 3600
    else
        print("יחידת זמן לא חוקית. השתמש ב-sec, min או hour.")
        return
    end

    TriggerEvent("my_timer:start", totalSeconds)
end, false)
