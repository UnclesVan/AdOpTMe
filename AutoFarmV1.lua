loadstring(game:HttpGet(('https://raw.githubusercontent.com/UnclesVan/AdoPtMe-/refs/heads/main/renameremotes.lua')))()

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LoadingGui"
screenGui.IgnoreGuiInset = true -- Make sure it covers the full screen
screenGui.Parent = playerGui

-- Create a Frame that fills the entire screen
local frame = Instance.new("Frame")
frame.Size = UDim2.new(1, 0, 1, 0) -- Fullscreen frame
frame.Position = UDim2.new(0, 0, 0, 0)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) -- Dark background
frame.BackgroundTransparency = 0 -- Fully opaque
frame.ZIndex = 10 -- Ensure the frame appears above other elements
frame.Parent = screenGui

-- Create a TextLabel for the loading message
local loadMessage = Instance.new("TextLabel")
loadMessage.Size = UDim2.new(1, 0, 0.15, 0) -- 15% height
loadMessage.Position = UDim2.new(0, 0, 0.4, 0) -- Centered vertically
loadMessage.Text = "Loading..."
loadMessage.TextColor3 = Color3.new(1, 1, 1) -- White text color
loadMessage.TextScaled = true
loadMessage.TextWrapped = true
loadMessage.BackgroundTransparency = 1
loadMessage.ZIndex = 11 -- Ensure this appears above the frame
loadMessage.Parent = frame

-- Create a TextLabel for progress visuals
local progressText = Instance.new("TextLabel")
progressText.Size = UDim2.new(1, 0, 0.15, 0) -- 15% height
progressText.Position = UDim2.new(0, 0, 0.55, 0) -- Below the loading message
progressText.Text = "Please wait..."
progressText.TextColor3 = Color3.new(1, 1, 1)
progressText.TextScaled = true
progressText.TextWrapped = true
progressText.BackgroundTransparency = 1
progressText.ZIndex = 11 -- Ensure this also appears above the frame
progressText.Parent = frame

-- Simulate loading steps with a loading animation
local loadingSteps = {
    "Loading remote events...",
    "Loading functions...",
    "Loading modules...",
}

for _, step in ipairs(loadingSteps) do
    loadMessage.Text = step
    wait(2) -- Wait for 2 seconds for each loading step
end

-- Show final message
loadMessage.Text = "Script has been loaded! Destroying UI..."
wait(2) -- Wait for 2 seconds before destroying the UI

-- Destroy the UI
screenGui:Destroy()


task.wait("3")


-- Flag to track subscription status
local hasSubscribed = false

--pickup selected pet

local pets = workspace.Pets:GetChildren()

-- Assuming you have a GUI where the user can select their pet
-- This part would typically be in the UI event handler

-- Example: user selects the first pet for demonstration
local userSelectedPet = pets[1] -- Replace with actual user selection logic

if userSelectedPet then
    local args = {
        [1] = userSelectedPet
    }
    game:GetService("ReplicatedStorage").API.HoldBaby:FireServer(unpack(args))
else
    warn("Please select a pet.")

end

-- Ensure Title GUI exists
local function ensureTitleLabelExists()
    local player = game.Players.LocalPlayer
    local titleScreen = player.PlayerGui:FindFirstChild("TitleScreen")
    
    if not titleScreen then
        titleScreen = Instance.new("ScreenGui")
        titleScreen.Name = "TitleScreen"
        titleScreen.Parent = player.PlayerGui
        -- Create a title label for the UI
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "TitleLabel"
        titleLabel.Size = UDim2.new(1, 0, 0.1, 0) -- Full width, 10% height
        titleLabel.Position = UDim2.new(0, 0, 0, 0) -- Top of the screen
        titleLabel.Text = "PET AUTOFARM V1 IN DEV"
        titleLabel.BackgroundColor3 = Color3.fromRGB(150, 150, 255) -- Background color
        titleLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
        titleLabel.Font = Enum.Font.SourceSansBold
        titleLabel.TextScaled = true
        titleLabel.TextXAlignment = Enum.TextXAlignment.Center
        titleLabel.TextYAlignment = Enum.TextYAlignment.Center
        titleLabel.Parent = titleScreen
    end
end

-- Ensure HintApp GUI exists
local function ensureHintAppExists()
    local player = game.Players.LocalPlayer
    local hintApp = player.PlayerGui:FindFirstChild("HintApp")
    
    if not hintApp then
        hintApp = Instance.new("ScreenGui")
        hintApp.Name = "HintApp"
        hintApp.Parent = player.PlayerGui

        local textLabel = Instance.new("TextLabel")
        textLabel.Name = "TextLabel"
        textLabel.Size = UDim2.new(0, 400, 0, 50)
        textLabel.Position = UDim2.new(0.5, -200, 0.1, 0)
        textLabel.Text = ""
        textLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
        textLabel.Parent = hintApp
    end
    
    return hintApp
end

-- Display countdown messages
local function displayHintCountdown(seconds, message)
    local player = game.Players.LocalPlayer
    local hintApp = player.PlayerGui:FindFirstChild("HintApp")
    
    if not hintApp or not hintApp:FindFirstChild("TextLabel") then
        error("HintApp or TextLabel not found in PlayerGui!")
        return
    end

    local textLabel = hintApp.TextLabel
    textLabel.Visible = true
    for i = seconds, 1, -1 do
        textLabel.Text = message .. " " .. i .. " seconds"
        wait(1)
    end
    textLabel.Text = "Action now..."
    wait(2)
    textLabel.Text = ""
end

-- Teleport player to a target CFrame
local function instantTeleport(player, targetCFrame)
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid.PlatformStand = true
    end

    if player.Character then
        local primaryPart = player.Character.PrimaryPart
        if primaryPart then
            primaryPart.Transparency = 1
            player.Character:SetPrimaryPartCFrame(targetCFrame)
            wait(0.1)
            primaryPart.Transparency = 0
            if humanoid then
                humanoid.PlatformStand = false
            end
        end
    end
end

--pickup selected pet

local pets = workspace.Pets:GetChildren()

-- Assuming you have a GUI where the user can select their pet
-- This part would typically be in the UI event handler

-- Example: user selects the first pet for demonstration
local userSelectedPet = pets[1] -- Replace with actual user selection logic

if userSelectedPet then
    local args = {
        [1] = userSelectedPet
    }
    game:GetService("ReplicatedStorage").API.HoldBaby:FireServer(unpack(args))
else
    warn("Please select a pet.")

end

-- Function to unsubscribe from house
local function unsubscribeFromHouse(player)
    local unsubscribeFunction = game:GetService("ReplicatedStorage").API.UnsubscribeFromHouse
    unsubscribeFunction:InvokeServer(player, true)
end

-- Function to find the PizzaShop Main Door dynamically
local function findPizzaShopMainDoor()
    for _, model in pairs(workspace.Interiors:GetChildren()) do
        if model:IsA("Model") and model:FindFirstChild("Doors") then
            local pizzaShopDoor = model.Doors:FindFirstChild("PizzaShop/MainDoor")
            if pizzaShopDoor then
                return pizzaShopDoor
            end
        end
    end
    return nil
end

-- Function to find the Neighborhood model dynamically
local function findNeighborhoodModel()
    for _, model in pairs(workspace.Interiors:GetChildren()) do
        if model:IsA("Model") and model:FindFirstChild("Doors") then
            return model
        end
    end
    return nil
end

-- Teleport to Neighborhood Door
local function teleportToNeighborhoodDoor(player)
    displayHintCountdown(8, "Teleporting to Neighborhood Door")
    local neighborhood = findNeighborhoodModel()
    if neighborhood then
        local neighborhoodDoor = neighborhood:FindFirstChild("Doors"):FindFirstChild("MainDoor"):FindFirstChild("WorkingParts"):FindFirstChild("TouchToEnter")
        if neighborhoodDoor then
            instantTeleport(player, neighborhoodDoor.CFrame)
        else
            error("Neighborhood door not found!")
        end
    else
        error("Neighborhood model not found!")
    end
end

-- Teleport to Pizza Shop Main Door
local function teleportToPizzaShopMainDoor(player)
    displayHintCountdown(8, "Teleporting to Pizza Shop Main Door")
    local pizzaShopMainDoor = findPizzaShopMainDoor()
    if pizzaShopMainDoor then
        local pizzaShopDoorPart = pizzaShopMainDoor:FindFirstChild("WorkingParts"):FindFirstChild("TouchToEnter")
        if pizzaShopDoorPart then
            instantTeleport(player, pizzaShopDoorPart.CFrame)
        else
            error("Pizza Shop Main Door Working Parts not found!")
        end
    else
        error("Pizza Shop Main Door not found!")
    end
end

-- Teleport to Pizza Shop Interior Origin
local function teleportToInteriorOrigin(player)
    local pizzaShopInteriorOrigin
    repeat
        pizzaShopInteriorOrigin = workspace.Interiors:FindFirstChild("PizzaShop") and workspace.Interiors.PizzaShop:FindFirstChild("InteriorOrigin")
        wait(1)
    until pizzaShopInteriorOrigin

    instantTeleport(player, pizzaShopInteriorOrigin.CFrame)
end

-- Change Pizza Shop destination_id to "Salon"
local function changePizzaShopDestinationIdToSalon()
    local pizzaShopModel = workspace.Interiors:FindFirstChild("PizzaShop")
    if pizzaShopModel then
        local destinationIdPath = pizzaShopModel.Doors.MainDoor.WorkingParts.Configuration:FindFirstChild("destination_id")
        if destinationIdPath and destinationIdPath:IsA("StringValue") then
            destinationIdPath.Value = "Salon"
            print("Pizza Shop destination_id updated to 'Salon'")
        else
            warn("Pizza Shop destination_id not found or is not a StringValue")
        end
    else
        print("Pizza Shop model not found.")
    end
end

-- Change Salon destination_id to "School"
local function changeSalonDestinationIdToSchool()
    local salonModel = workspace.Interiors:FindFirstChild("Salon")
    if salonModel then
        local destinationIdPath = salonModel.Doors.MainDoor.WorkingParts.Configuration:FindFirstChild("destination_id")
        if destinationIdPath and destinationIdPath:IsA("StringValue") then
            destinationIdPath.Value = "School"
            print("Salon destination_id updated to 'School'")
        else
            warn("Salon destination_id not found or is not a StringValue")
        end
    else
        print("Salon model not found.")
    end
end

-- Teleport to Pizza Shop Left Door
local function teleportToPizzaShopLeftDoor(player)
    displayHintCountdown(20, "Teleporting to Pizza Shop Left Door")
    local pizzaShopLeftDoor = workspace.Interiors:FindFirstChild("PizzaShop") and workspace.Interiors.PizzaShop:FindFirstChild("Doors") 
        and workspace.Interiors.PizzaShop.Doors:FindFirstChild("MainDoor") 
        and workspace.Interiors.PizzaShop.Doors.MainDoor:FindFirstChild("Left") 
        and workspace.Interiors.PizzaShop.Doors.MainDoor.Left:FindFirstChild("Door")

    if pizzaShopLeftDoor then
        instantTeleport(player, pizzaShopLeftDoor.CFrame)
    else
        error("Pizza Shop Left Door not found!")
    end
end

-- Continuous function to update both destination_ids if their respective models exist
local function continuousDestinationIdUpdate()
    while true do
        -- Check and update destination_id for PizzaShop
        changePizzaShopDestinationIdToSalon()

        -- Check and update destination_id for Salon
        changeSalonDestinationIdToSchool()

        wait(5)  -- Wait for 5 seconds before updating again
    end
end

-- Function to find the School InteriorOrigin dynamically
local function findSchoolInteriorOrigin()
    return workspace.Interiors:FindFirstChild("School") and workspace.Interiors.School:FindFirstChild("InteriorOrigin")
end

-- Function to teleport to School Interior Origin
local function teleportToSchoolInteriorOrigin(player)
    local schoolInteriorOrigin
    repeat
        schoolInteriorOrigin = findSchoolInteriorOrigin()
        wait(1)
    until schoolInteriorOrigin

    instantTeleport(player, schoolInteriorOrigin.CFrame)
end

-- Function to find the School TouchToEnter part dynamically
local function findSchoolTouchToEnter()
    return workspace.Interiors:FindFirstChild("School") and workspace.Interiors.School.Doors.MainDoor.WorkingParts:FindFirstChild("TouchToEnter")
end

-- Function to teleport to School TouchToEnter after countdown
local function teleportToSchoolTouchToEnter(player)
    displayHintCountdown(20, "Teleporting to School Main Door")
    local touchToEnter
    repeat
        touchToEnter = findSchoolTouchToEnter()
        wait(1)
    until touchToEnter 

    instantTeleport(player, touchToEnter.CFrame)
end

-- Function to continuously find and teleport to the Salon Interior Origin
local function teleportToSalonInteriorOrigin(player)
    local salonInteriorOrigin
    while true do
        salonInteriorOrigin = workspace.Interiors:FindFirstChild("Salon") and workspace.Interiors.Salon:FindFirstChild("InteriorOrigin")
        if salonInteriorOrigin then
            instantTeleport(player, salonInteriorOrigin.CFrame)
            displayHintCountdown(20, "You have entered the Salon Shop!")
            break -- Exit the loop after teleporting once
        end
        wait(1)
    end
end

-- Teleport to Salon Main Door after entering the Salon Interior Origin
local function teleportToSalonMainDoor(player)
    displayHintCountdown(20, "Teleporting to Salon Main Door")
    local salonMainDoor
    repeat
        salonMainDoor = workspace.Interiors:FindFirstChild("Salon") and workspace.Interiors.Salon.Doors.MainDoor.WorkingParts:FindFirstChild("TouchToEnter")
        
        if not salonMainDoor then
            print("Finding Salon Main Door...")
        end
        wait(1)
    until salonMainDoor
    
    instantTeleport(player, salonMainDoor.CFrame)
    print("Teleported to the Salon Main Door.")
end

-- Teleport to Campsite Origin
local function teleportToCampsiteOrigin(player)
    displayHintCountdown(20, "Teleporting to Campsite Origin")
    local campsiteOrigin = workspace.StaticMap.Campsite.CampsiteOrigin
    if campsiteOrigin then
        local targetCFrame = campsiteOrigin.CFrame + Vector3.new(0, 5, 0) -- Adjust to stand on top of the CampsiteOrigin
        instantTeleport(player, targetCFrame)
        wait(0.1)
        
        -- Change the CampsiteOrigin to Baseplate
        campsiteOrigin.BrickColor = BrickColor.new("Bright blue") -- Change color if needed
        campsiteOrigin.Transparency = 0 -- Make it visible
        campsiteOrigin.CanCollide = true -- Ensure it can be stood on
        
        displayHintCountdown(40, "You are now at the Campsite! Standing by...")
    else
        error("CampsiteOrigin not found!")
    end
end

-- Main function to execute the teleportation sequence in loop
local function runTeleportationSequence()
    local player = game.Players.LocalPlayer
    ensureTitleLabelExists()  -- Initialize Title UI
    ensureHintAppExists()      -- Initialize Hint App

    if not hasSubscribed then
        unsubscribeFromHouse(player)
        hasSubscribed = true  -- Set to true to avoid unsubscribing again
    end

    teleportToNeighborhoodDoor(player)
    wait(1) -- Only teleport to the neighborhood once.

    -- Start the loop for Pizza Shop, Salon, School, and Campsite tasks
    while true do
        teleportToPizzaShopMainDoor(player)
        wait(1)

        teleportToInteriorOrigin(player)
        wait(1)

        teleportToPizzaShopLeftDoor(player)
        wait(1)

        teleportToSalonInteriorOrigin(player)
        wait(1)

        teleportToSalonMainDoor(player)
        wait(1)

        teleportToSchoolInteriorOrigin(player)
        wait(1)

        teleportToSchoolTouchToEnter(player)
        wait(1)

        teleportToCampsiteOrigin(player)
        wait(1)
    end
end

-- Start the teleportation sequences
coroutine.wrap(runTeleportationSequence)()

-- Start the continuous update for destination_ids in a separate coroutine
coroutine.wrap(continuousDestinationIdUpdate)()




