local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function showBigMessage(text, duration, fadeTime)
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "BigMessageGui"
	screenGui.Parent = playerGui
	screenGui.ResetOnSpawn = false

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.Position = UDim2.new(0, 0, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.Font = Enum.Font.GothamBlack
	label.TextSize = 72
	label.TextColor3 = Color3.fromRGB(255, 255, 255)
	label.TextStrokeTransparency = 1
	label.TextScaled = true
	label.Parent = screenGui

	task.wait(duration)

	local steps = 20
	for i = 1, steps do
		label.TextTransparency = i / steps
		task.wait(fadeTime / steps)
	end

	screenGui:Destroy()
end

spawn(function()
	showBigMessage("Vax Seas by DunKKJ", 2, 2)
end)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ExecutorUI"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local mainImage = Instance.new("ImageLabel")
mainImage.Size = UDim2.new(0, 320, 0, 460)
mainImage.Position = UDim2.new(0.5, -160, 0.5, -230)
mainImage.BackgroundTransparency = 0
mainImage.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainImage.Image = "rbxassetid://11911878009"
mainImage.Visible = false
mainImage.Parent = screenGui
mainImage.Active = true
mainImage.Draggable = true
local uiCorner = Instance.new("UICorner", mainImage)
uiCorner.CornerRadius = UDim.new(0, 16)

local titleBar = Instance.new("TextLabel")
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleBar.BorderSizePixel = 0
titleBar.Text = "Vax Saes V2?????"
titleBar.Font = Enum.Font.GothamBold
titleBar.TextSize = 18
titleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
titleBar.Parent = mainImage
titleBar.BackgroundTransparency = 1
local titleCorner = Instance.new("UICorner", titleBar)
titleCorner.CornerRadius = UDim.new(0, 16)

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 35, 1, 0)
closeButton.Position = UDim2.new(1, -35, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 18
closeButton.Parent = titleBar
closeButton.ClipsDescendants = true
local closeCorner = Instance.new("UICorner", closeButton)
closeCorner.CornerRadius = UDim.new(0, 10)
closeButton.MouseButton1Click:Connect(function()
	mainImage.Visible = false
end)

local function createHitbox()
	local character = player.Character
	if not character or not character:FindFirstChild("HumanoidRootPart") then return end

	local existingHitbox = character:FindFirstChild("BigHitbox")
	if existingHitbox then existingHitbox:Destroy() end

	local hitbox = Instance.new("Part")
	hitbox.Name = "BigHitbox"
	hitbox.Size = Vector3.new(50, 50, 50)
	hitbox.Transparency = 0.5
	hitbox.Anchored = false
	hitbox.CanCollide = false
	hitbox.CastShadow = false
	hitbox.Material = Enum.Material.Neon
	hitbox.Color = Color3.fromRGB(255, 0, 0)
	hitbox.CFrame = character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
	hitbox.Parent = character

	local weld = Instance.new("WeldConstraint")
	weld.Part0 = character.HumanoidRootPart
	weld.Part1 = hitbox
	weld.Parent = hitbox

	hitbox.Touched:Connect(function(hit)
		local h = hit.Parent:FindFirstChildOfClass("Humanoid")
		if h and h.Health > 0 and hit.Parent ~= character then
			h.Health = 0
		end
	end)
end

-- Função atualizada com parâmetro opcional para estilo
local function styleOptionGui(guiElement, styleType)
	if styleType == "title" or styleType == "description" then
		-- Para títulos e descrições: fundo totalmente opaco, sem stroke
		guiElement.BackgroundTransparency = 1
		guiElement.BackgroundColor3 = Color3.fromRGB(255, 255, 255) -- ou qualquer cor que queira
		-- Remove stroke se existir (caso reaplique)
		for _, child in pairs(guiElement:GetChildren()) do
			if child:IsA("UIStroke") then
				child:Destroy()
			end
		end
		-- Texto branco sem stroke
		if guiElement:IsA("TextLabel") or guiElement:IsA("TextButton") or guiElement:IsA("TextBox") then
			guiElement.TextColor3 = Color3.fromRGB(255, 255, 255)
			guiElement.TextStrokeTransparency = 1
		end
	elseif styleType == "button" then
		-- Para botões e caixas de texto: fundo branco com transparência, stroke cinza nas bordas
		guiElement.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		guiElement.BackgroundTransparency = 0.6
		local uiCorner = guiElement:FindFirstChildWhichIsA("UICorner") or Instance.new("UICorner")
		uiCorner.CornerRadius = UDim.new(0, 8)
		uiCorner.Parent = guiElement

		local uiStroke = guiElement:FindFirstChildWhichIsA("UIStroke") or Instance.new("UIStroke")
		uiStroke.Color = Color3.fromRGB(128, 128, 128)
		uiStroke.Thickness = 0.5
		uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		uiStroke.Parent = guiElement

		if guiElement:IsA("TextLabel") or guiElement:IsA("TextButton") or guiElement:IsA("TextBox") then
			guiElement.TextColor3 = Color3.fromRGB(255, 255, 255)
			guiElement.TextStrokeTransparency = 1
		end
	end
end

-- Criando UI com os estilos certos:

local hitboxButton = Instance.new("TextButton")
hitboxButton.Size = UDim2.new(1, -20, 0, 50)
hitboxButton.Position = UDim2.new(0, 10, 0, 40)
hitboxButton.Text = "HitBox Kill"
hitboxButton.Font = Enum.Font.GothamBold
hitboxButton.TextSize = 16
hitboxButton.Parent = mainImage
styleOptionGui(hitboxButton, "button")
hitboxButton.MouseButton1Click:Connect(createHitbox)

local descriptionLabel = Instance.new("TextLabel")
descriptionLabel.Size = UDim2.new(1, -20, 0, 50)
descriptionLabel.Position = UDim2.new(0, 10, 0, 100)
descriptionLabel.Text = "Esta opção serve para você criar uma hitbox mortal automaticamente, selecione uma missão e chegue perto dos NPCs na hitbox."
descriptionLabel.Font = Enum.Font.Gotham
descriptionLabel.TextSize = 14
descriptionLabel.TextWrapped = true
descriptionLabel.Parent = mainImage
styleOptionGui(descriptionLabel, "description")

local musicTitle = Instance.new("TextLabel")
musicTitle.Size = UDim2.new(1, -20, 0, 25)
musicTitle.Position = UDim2.new(0, 10, 0, 180)
musicTitle.Text = "Música"
musicTitle.Font = Enum.Font.GothamBold
musicTitle.TextSize = 18
musicTitle.TextXAlignment = Enum.TextXAlignment.Left
musicTitle.Parent = mainImage
styleOptionGui(musicTitle, "title")

local musicBox = Instance.new("TextBox")
musicBox.Size = UDim2.new(1, -20, 0, 30)
musicBox.Position = UDim2.new(0, 10, 0, 210)
musicBox.ClearTextOnFocus = false
musicBox.Font = Enum.Font.GothamBold
musicBox.TextSize = 16
musicBox.PlaceholderText = "Cole o ID da musica aqui"
musicBox.Parent = mainImage
styleOptionGui(musicBox, "button")

local musicButton = Instance.new("TextButton")
musicButton.Size = UDim2.new(1, -20, 0, 40)
musicButton.Position = UDim2.new(0, 10, 0, 250)
musicButton.Text = "Tocar Musiquinha boa"
musicButton.Font = Enum.Font.GothamBold
musicButton.TextSize = 14
musicButton.Parent = mainImage
styleOptionGui(musicButton, "button")

local musicPlaying = false
local sound

musicButton.MouseButton1Click:Connect(function()
	if musicPlaying then
		if sound then
			sound:Stop()
			sound:Destroy()
			sound = nil
		end
		musicButton.Text = "Tocar Música"
		musicPlaying = false
	else
		local id = musicBox.Text
		if id == "" then return end
		sound = Instance.new("Sound")
		sound.SoundId = "rbxassetid://"..id
		sound.Looped = true
		sound.Volume = 0.5
		sound.Parent = playerGui
		sound:Play()
		musicButton.Text = "Parar Música"
		musicPlaying = true
	end
end)

local speedTitle = Instance.new("TextLabel")
speedTitle.Size = UDim2.new(1, -20, 0, 25)
speedTitle.Position = UDim2.new(0, 10, 0, 300)
speedTitle.Text = "Velocidade do Player"
speedTitle.Font = Enum.Font.GothamBold
speedTitle.TextSize = 18
speedTitle.TextXAlignment = Enum.TextXAlignment.Left
speedTitle.Parent = mainImage
styleOptionGui(speedTitle, "title")

local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(1, -20, 0, 30)
speedBox.Position = UDim2.new(0, 10, 0, 330)
speedBox.ClearTextOnFocus = false
speedBox.Font = Enum.Font.GothamBold
speedBox.TextSize = 16
speedBox.PlaceholderText = "Digite a velocidade (ex: 16)"
speedBox.Parent = mainImage
styleOptionGui(speedBox, "button")

local function applySpeed()
	local speedValue = tonumber(speedBox.Text)
	if not speedValue then return end

	local character = player.Character
	if character and character:FindFirstChildOfClass("Humanoid") then
		character:FindFirstChildOfClass("Humanoid").WalkSpeed = speedValue
	end
end

local speedButton = Instance.new("TextButton")
speedButton.Size = UDim2.new(1, -20, 0, 40)
speedButton.Position = UDim2.new(0, 10, 0, 370)
speedButton.Text = "Aplicar Velocidade"
speedButton.Font = Enum.Font.GothamBold
speedButton.TextSize = 14
speedButton.Parent = mainImage
styleOptionGui(speedButton, "button")
speedButton.MouseButton1Click:Connect(applySpeed)

local floatButton = Instance.new("ImageButton")
floatButton.Size = UDim2.new(0, 55, 0, 55)
floatButton.Position = UDim2.new(0, 10, 0, 10)
floatButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
floatButton.BackgroundTransparency = 0.3
floatButton.Image = "rbxassetid://11911878009"
floatButton.Parent = screenGui
floatButton.AutoButtonColor = false
floatButton.ScaleType = Enum.ScaleType.Fit
floatButton.Modal = false
local uiCorner = Instance.new("UICorner", floatButton)
uiCorner.CornerRadius = UDim.new(0, 80)

local dragging
local dragInput
local dragStart
local startPos

floatButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = floatButton.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

floatButton.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		floatButton.Position = UDim2.new(
			math.clamp(startPos.X.Scale, 0, 1),
			math.clamp(startPos.X.Offset + delta.X, 0, workspace.CurrentCamera.ViewportSize.X - floatButton.AbsoluteSize.X),
			math.clamp(startPos.Y.Scale, 0, 1),
			math.clamp(startPos.Y.Offset + delta.Y, 0, workspace.CurrentCamera.ViewportSize.Y - floatButton.AbsoluteSize.Y)
		)
	end
end)

floatButton.MouseButton1Click:Connect(function()
	mainImage.Visible = not mainImage.Visible
end)
