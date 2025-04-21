# RedM Timer Script ⏱️

This is a lightweight and clean NUI-based countdown timer for RedM using VORP Core.

## 🔧 Features

- Command-based countdown: `/timer [amount] [unit]`
- Supported units: `sec`, `min`, `hour`
- Fully animated NUI display (fade-in / fade-out)
- Color flashing during the last 10 seconds
- Optional cancel command in config
- Fully client-side, efficient and isolated per player
- Chat suggestions for both commands

## Installation
- Download the resource in your resources folder
- Add `ensure PyThor_Timer` to you server.cfg

## 🚀 Commands

- `/timer 5 min` → Starts a 5-minute countdown
- `/stoptimer` → Stops the countdown instantly

## 🛠️ Requirements

- VORP Core

## ✅ To-do (optional)

- Add sound notification at the end
- Add multi-timer support
- Discord logs(?)

## 📸 Preview

https://www.youtube.com/watch?v=_DO7N54KxHA

---

# Please don't change the resource name to give credit


# PyThor_Timer - Exports Documentation

## Overview
This documentation covers the export functions available in the PyThor_Timer resource, allowing other resources to start and manage timers without using chat commands.

## Export Functions

### startTimer(amount, unit)
Starts a countdown timer with the specified amount and time unit.

**Parameters:**
- `amount` (number): The quantity of time units
- `unit` (string): Time unit - must be one of the values defined in Config.TimeUnits ("sec", "min", "hr")

**Returns:**
- `boolean`: True if the timer was started successfully, false otherwise

**Example:**
```lua
exports['PyThor_Timer']:startTimer(5, "min")
```

### stopTimer()
Stops the currently running timer.

**Returns:**
- `boolean`: True if a timer was stopped, false if no timer was running

**Example:**
```lua
exports['PyThor_Timer']:stopTimer()
```

### isTimerRunning()
Checks if a timer is currently running.

**Returns:**
- `boolean`: True if a timer is running, false otherwise

**Example:**
```lua
local isTimerActive = exports['PyThor_Timer']:isTimerRunning()
```

## Usage Examples

### Basic Usage
```lua
-- Start a 5-minute timer
exports['PyThor_Timer']:startTimer(5, "min")

-- Check if a timer is currently running
local isTimerActive = exports['PyThor_Timer']:isTimerRunning()

-- Stop the current timer
exports['PyThor_Timer']:stopTimer()
```

### Conditional Usage
```lua
if not exports['PyThor_Timer']:isTimerRunning() then
    -- Only start the timer if no timer is currently running
    exports['PyThor_Timer']:startTimer(30, "sec")
    print("Timer started successfully")
else
    print("Cannot start timer, another one is already running")
end
```

### Error Handling
```lua
local success = exports['PyThor_Timer']:startTimer(2, "hr")
if success then
    print("Two hour timer started successfully")
else
    print("Failed to start timer")
end
```

### Event Integration
```lua
RegisterNetEvent('myResource:startEvent')
AddEventHandler('myResource:startEvent', function()
    -- Stop any existing timer first
    exports['PyThor_Timer']:stopTimer()
    -- Start a 10-second countdown
    exports['PyThor_Timer']:startTimer(10, "sec")
    -- Do something when the timer ends
    Citizen.CreateThread(function()
        Citizen.Wait(10000) -- 10 seconds
        -- Timer has finished, execute event code here
    end)
end)
```

## Notes
- Only one timer can run at a time per client
- If a timer is already running, `startTimer()` will return false
- The timer is client-side and works independently for each player