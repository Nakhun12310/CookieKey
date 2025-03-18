local KeyGuardLibrary = loadstring(game:HttpGet("https://cdn.keyguardian.org/library/v1.0.0.lua"))()
local trueData = "ada93ccf591c4fd9a2501f47ad1484ef"
local falseData = "fb46ce25695e4fbb883a5f513814c78b"

KeyGuardLibrary.Set({
    publicToken = "7fba9d9ed25a4fc39ba25b078a94355d",
    privateToken = "977e83efba474130af14a9d66ec28bcc",
    trueData = trueData,
    falseData = falseData,
})

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/zepthical/Vayfield/refs/heads/main/README.md'))()

local Window = Rayfield:CreateWindow({
    Name = "Key System",
    LoadingTitle = "Authenticating...",
    LoadingSubtitle = "Please wait",
    ConfigurationSaving = {
        Enabled = false
    },
    KeySystem = false
})

local key = ""
local player = game.Players.LocalPlayer -- Get the player

-- Notification function
local function showNotification(title, message, success)
    Rayfield:Notify({
        Title = title,
        Content = message,
        Duration = 3, -- Auto close in 3 seconds
        Image = success and 4483362458 or 4483345998, -- Success (green) / Error (red)
        Actions = {} -- No buttons
    })
end

-- Create a tab for Key System
local KeySystemTab = Window:CreateTab("Key System", 4483362458) -- Icon: key

-- Create a section for Key Input
KeySystemTab:CreateSection("Enter Your Key")

-- Create a key input box
KeySystemTab:CreateInput({
    Name = "Enter Key",
    PlaceholderText = "Enter your key here...",
    RemoveTextAfterFocusLost = false,
    Callback = function(Value)
        key = Value
    end
})

-- Create a button to check the key
KeySystemTab:CreateButton({
    Name = "Check Key",
    Callback = function()
        local success, response = pcall(KeyGuardLibrary.validateDefaultKey, key)
        if success then
            if response == trueData then
                showNotification("Key System", "✅ Key is valid!", true)
                task.wait(1)
                loadstring(game:HttpGet("https://raw.githubusercontent.com/Nakhun12310/CookieHub/refs/heads/main/GameList.lua", true))()  
            else
                showNotification("Key System", "❌ Key is invalid. You will be kicked.", false)
                task.wait(3) -- Wait 3 seconds before kicking
                player:Kick("Invalid Key! Please get a valid key.")  
            end
        else
            showNotification("Key System", "⚠️ Error validating key. Try later.", false)
        end
    end
})

-- Button to copy the key link
KeySystemTab:CreateButton({
    Name = "Get Key",
    Callback = function()
        local keyLink = "https://key-link.com" -- Replace with your link
        setclipboard(keyLink)
        showNotification("Key System", "🔗 Key link copied to clipboard!", true)
    end
})
