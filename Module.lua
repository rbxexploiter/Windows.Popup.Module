local Modules = {}

_G.UI_Enabled = false
local Speed = 0.05

local UserInputService = game:GetService("UserInputService")

local dragging
local dragInput
local dragStart
local startPos

local function UpdateFrame(input, Frame)
	local delta = input.Position - dragStart
	Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end


local function LoadUtilities(Style, Frame)
	local AppsList = nil
	if _G.UI_Enabled == false then
		_G.UI_Enabled = true
		AppsList = Instance.new("Frame", Frame)
		AppsList.AnchorPoint = Vector2.new(0, 1)
		AppsList.Size = UDim2.new(1, 0, 0, 70)
		AppsList.Name = "AppsList"
		AppsList.BorderSizePixel = 0
		AppsList.BackgroundTransparency = 1	
		
		local List = Instance.new("UIListLayout", AppsList)
		List.SortOrder = Enum.SortOrder.LayoutOrder
		List.FillDirection = Enum.FillDirection.Horizontal
		List.HorizontalAlignment = Enum.HorizontalAlignment.Right
		List.VerticalAlignment = Enum.VerticalAlignment.Bottom
		List.Padding = UDim.new(0, 10)
	end
	
	local AppIcon = Instance.new("TextButton", AppsList)
	AppIcon.Size = UDim2.new(0, 70, 1, 0)
	AppIcon.BorderSizePixel = 0
	AppIcon.Text = ""
	if tostring(Style[1]) == "11" then
		AppIcon.BackgroundColor3 = Color3.new(0.180392, 0.180392, 0.180392)
	else
		AppIcon.BackgroundColor3 = Color3.new(1, 1, 1)
	end	
	local AppCorner = Instance.new("UICorner", AppIcon)
	AppCorner.CornerRadius = UDim.new(0.3, 0)
	
	local AppRadius = Instance.new("UIAspectRatioConstraint", AppIcon)
	
	-- UTILITES
	local ListOfUtilites = Instance.new("Frame", Frame)
	ListOfUtilites.Size = UDim2.new(1, 0,0, 30)
	ListOfUtilites.AnchorPoint = Vector2.new(1, 0)
	ListOfUtilites.Position = UDim2.new(1, 0,0, 0)
	ListOfUtilites.BackgroundTransparency = 1
	ListOfUtilites.Name = "ListOfUtilites"

	local List = Instance.new("UIListLayout", ListOfUtilites)
	List.SortOrder = Enum.SortOrder.LayoutOrder
	List.FillDirection = Enum.FillDirection.Horizontal
	List.HorizontalAlignment = Enum.HorizontalAlignment.Right
	List.VerticalAlignment = Enum.VerticalAlignment.Top
	List.Padding = UDim.new(0, 4)

	local CloseButton = nil
	if tostring(Style[1]) == "11" then
		CloseButton = Instance.new("ImageButton", ListOfUtilites)
		CloseButton.Image = "rbxassetid://9151169116"
		CloseButton.BackgroundTransparency = 1
		CloseButton.ScaleType = Enum.ScaleType.Slice
		CloseButton.SliceCenter = Rect.new(0, 250, 0, 250)
		CloseButton.SliceScale = 0.025
		CloseButton.ImageTransparency = 1
		CloseButton.ImageColor3 = Color3.new(1,0,0)
		CloseButton.Size = UDim2.new(0,40,1,0)
		CloseButton.LayoutOrder = 1
		CloseButton.Name = "CloseButton"
	else
		CloseButton = Instance.new("TextButton", ListOfUtilites)
		CloseButton.BackgroundTransparency = 1
		CloseButton.BackgroundColor3 = Color3.new(1,0,0)
		CloseButton.Size = UDim2.new(0,40,1,0)
		CloseButton.LayoutOrder = 1
		CloseButton.Text = ""
		CloseButton.BorderSizePixel = 0
		CloseButton.Name = "CloseButton"
	end

	local SetBottom = Instance.new("TextButton", ListOfUtilites)
	SetBottom.BackgroundTransparency = 1
	SetBottom.BackgroundColor3 = Color3.new(0, 0, 0)
	SetBottom.Size = UDim2.new(0,40,1,0)
	SetBottom.LayoutOrder = 0
	SetBottom.Text = ""
	SetBottom.BorderSizePixel = 0
	SetBottom.Name = "SetBottom"

	local ICO = Instance.new("ImageLabel", CloseButton)
	ICO.Name = "ICO"
	ICO.AnchorPoint = Vector2.new(0, 0.5)
	ICO.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ICO.BackgroundTransparency = 1.000
	ICO.BorderSizePixel = 0
	ICO.Position = UDim2.new(0, 0, 0.5, 0)
	ICO.Size = UDim2.new(1, 0, 0.5, 0)
	ICO.Image = "rbxassetid://9151203899"
	ICO.ScaleType = Enum.ScaleType.Fit

	local ICO_2 = Instance.new("ImageLabel", SetBottom)
	ICO_2.Name = "ICO"
	ICO_2.AnchorPoint = Vector2.new(0, 0.5)
	ICO_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ICO_2.BackgroundTransparency = 1.000
	ICO_2.BorderSizePixel = 0
	ICO_2.Position = UDim2.new(0, 0, 0.5, 0)
	ICO_2.Size = UDim2.new(1, 0, 0.5, 0)
	ICO_2.Image = "rbxassetid://9151238741"
	ICO_2.ScaleType = Enum.ScaleType.Fit

	local TitleIcon = Instance.new("ImageLabel", Frame)
	TitleIcon.Size = UDim2.new(0, 30, 0, 27)
	TitleIcon.BackgroundTransparency = 1
	TitleIcon.Position = UDim2.new(0, 5, 0, 3)
	TitleIcon.Image = "rbxassetid://"..tostring(Style[3])
	TitleIcon.ScaleType = Enum.ScaleType.Fit
	TitleIcon.Name = "TitleIcon"

	local Title = Instance.new("TextLabel", Frame)
	Title.Size = UDim2.new(0.3, 0, 0, 15)
	Title.BackgroundTransparency = 1
	Title.Text = tostring(Style[4])
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.TextColor3 = Color3.new(1, 1, 1)
	Title.TextScaled = true
	Title.RichText = true
	Title.Name = "Title"

	game:GetService("RunService").RenderStepped:Connect(function()
		if TitleIcon.IsLoaded == true then
			Title.Position = UDim2.new(0, 37, 0, 7)
		else
			Title.Position = UDim2.new(0, 7, 0, 7)
		end
	end)

	CloseButton.MouseEnter:Connect(function()
		if CloseButton:IsA("ImageButton") then
			game:GetService("TweenService"):Create(CloseButton, TweenInfo.new(Speed), {
				ImageTransparency = 0
			}):Play()
		elseif CloseButton:IsA("TextButton") then
			game:GetService("TweenService"):Create(CloseButton, TweenInfo.new(Speed), {
				BackgroundTransparency = 0
			}):Play()
		end
		game:GetService("TweenService"):Create(ICO, TweenInfo.new(Speed), {
			ImageColor3 = Color3.new(1,1,1)
		}):Play()
	end)

	SetBottom.MouseEnter:Connect(function()
		game:GetService("TweenService"):Create(SetBottom, TweenInfo.new(Speed), {
			BackgroundTransparency = 0.9
		}):Play()
		game:GetService("TweenService"):Create(ICO_2, TweenInfo.new(Speed), {
			ImageColor3 = Color3.new(1,1,1)
		}):Play()
	end)

	CloseButton.MouseLeave:Connect(function()
		if CloseButton:IsA("ImageButton") then
			game:GetService("TweenService"):Create(CloseButton, TweenInfo.new(Speed + 0.2), {
				ImageTransparency = 1
			}):Play()
		elseif CloseButton:IsA("TextButton") then
			game:GetService("TweenService"):Create(CloseButton, TweenInfo.new(Speed + 0.2), {
				BackgroundTransparency = 1
			}):Play()
		end
		if Style[2]:lower() ~= "dark" then
			game:GetService("TweenService"):Create(ICO, TweenInfo.new(Speed + 0.2), {
				ImageColor3 = Color3.new(0, 0, 0)
			}):Play()
		end
	end)

	SetBottom.MouseLeave:Connect(function()
		game:GetService("TweenService"):Create(SetBottom, TweenInfo.new(Speed + 0.2), {
			BackgroundTransparency = 1
		}):Play()
		if Style[2]:lower() ~= "dark" then
			game:GetService("TweenService"):Create(ICO_2, TweenInfo.new(Speed + 0.2), {
				ImageColor3 = Color3.new(0, 0, 0)
			}):Play()
		end
	end)

	CloseButton.MouseButton1Up:Connect(function()
		if tostring(Style[1]) == "11" then
			Frame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 3)
		else
			Frame:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Linear, 3)
		end
		local Tween = game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
			BackgroundTransparency = 1,
		})
		if Frame:FindFirstChild("UIStroke") then
			game:GetService("TweenService"):Create(Frame:WaitForChild("UIStroke"), TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
				Transparency = 1,
			}):Play()
		else
		end
		Tween:Play()
		Tween.Completed:Connect(function()
			Frame.Parent:Destroy()
		end)
		for _,v in pairs(Frame:GetDescendants()) do
			if v:IsA("GuiBase2d") then
				if v:IsA("TextButton") or v:IsA("TextBox") or v:IsA("TextLabel") then
					game:GetService("TweenService"):Create(v, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
						BackgroundTransparency = 1,
						TextTransparency = 1,
					}):Play()
				elseif v:IsA("ImageLabel") or v:IsA("ImageButton") then
					game:GetService("TweenService"):Create(v, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
						BackgroundTransparency = 1,
						ImageTransparency = 1,
					}):Play()
				elseif v:IsA("Frame") then
					game:GetService("TweenService"):Create(v, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
						BackgroundTransparency = 1,
					}):Play()
				end
			end
		end
	end)

	SetBottom.MouseButton1Up:Connect(function()
		AppIcon:TweenSize(UDim2.new(0, 70, 1, 0))
		Frame:TweenPosition(AppIcon.Position)
		if tostring(Style[1]) == "11" then
			_G.FrameSize_TWEEN = game:GetService("TweenService"):Create(Frame, TweenInfo.new(3, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut, 0, true), {
				Size = UDim2.new(0, 0, 0, 0)
			})
			_G.FrameSize_TWEEN:Play()
			coroutine.resume(coroutine.create(function()
				task.wait(0.4)
				_G.FrameSize_TWEEN:Pause()
			end))
		else
			_G.FrameSize_TWEEN = game:GetService("TweenService"):Create(Frame, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, true), {
				Size = UDim2.new(0, 0, 0, 0)
			})
			_G.FrameSize_TWEEN:Play()
			coroutine.resume(coroutine.create(function()
				task.wait(0.4)
				_G.FrameSize_TWEEN:Pause()
			end))
		end
		_G.FRAME_TWEEN = game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {
			BackgroundTransparency = 1,
		})
		_G.FRAME_TWEEN:Play()
		coroutine.resume(coroutine.create(function()
			task.wait(0.4)
			_G.FRAME_TWEEN:Pause()
		end))
		if Frame:FindFirstChild("UIStroke") then
			_G.Stroke_TWEEN = game:GetService("TweenService"):Create(Frame:WaitForChild("UIStroke"), TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0, true), {
				Transparency = 1,
			})
			_G.Stroke_TWEEN:Play()
			coroutine.resume(coroutine.create(function()
				task.wait(0.4)
				_G.Stroke_TWEEN:Pause()
			end))
		else
		end
		for _,v in pairs(Frame:GetDescendants()) do
			if v:IsA("GuiBase2d") then
				if v:IsA("TextButton") or v:IsA("TextBox") or v:IsA("TextLabel") then
					_G.Texts_TWEEN = game:GetService("TweenService"):Create(v, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0, true), {
						BackgroundTransparency = 1,
						TextTransparency = 1,
					})
					_G.Texts_TWEEN:Play()
					coroutine.resume(coroutine.create(function()
						task.wait(0.4)
						_G.Texts_TWEEN:Pause()
					end))
				elseif v:IsA("ImageLabel") or v:IsA("ImageButton") then
					_G.Images_TWEEN = game:GetService("TweenService"):Create(v, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0, true), {
						BackgroundTransparency = 1,
						ImageTransparency = 1,
					})
					_G.Images_TWEEN:Play()
					coroutine.resume(coroutine.create(function()
						task.wait(0.4)
						_G.Images_TWEEN:Pause()
					end))
				elseif v:IsA("Frame") then
					_G.Frames_TWEEN = game:GetService("TweenService"):Create(v, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0, true), {
						BackgroundTransparency = 1,
					})
					_G.Frames_TWEEN:Play()
					coroutine.resume(coroutine.create(function()
						task.wait(0.4)
						_G.Frames_TWEEN:Pause()
					end))
				end
			end
		end
		AppIcon.MouseButton1Up:Connect(function()
			_G.FrameSize_TWEEN:Cancel()
			_G.FRAME_TWEEN:Cancel()
			_G.Stroke_TWEEN:Cancel()
			_G.Texts_TWEEN:Cancel()
			_G.Images_TWEEN:Cancel()
			_G.Frames_TWEEN:Cancel()
		end)
	end)

	if Style[2]:lower() ~= "dark" then
		ICO.ImageColor3 = Color3.new(0, 0, 0)
		ICO_2.ImageColor3 = Color3.new(0, 0, 0)
		Title.TextColor3 = Color3.new(0, 0, 0)
	end
end

function Modules:CreateFrame(Style, Size)
	local CreateScreenUI = Instance.new("ScreenGui")
	CreateScreenUI.Parent = _G.Parent
	CreateScreenUI.Name = "Popup"
	CreateScreenUI.DisplayOrder = 1616
	CreateScreenUI.IgnoreGuiInset = true

	local Frame = Instance.new("TextButton")
	Frame.Parent = CreateScreenUI
	Frame.Text = ""
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
	Frame.Size = Size
	Frame.AutoButtonColor = false
	Frame.BorderSizePixel = 0
	Frame.Name = "POPUP.DISPLAY"

	local x = Frame.AbsoluteSize.X
	local y = Frame.AbsoluteSize.y
	local ratio = x/y

	if Frame:FindFirstChildWhichIsA("UIAspectRatioConstraint") then
		Frame:FindFirstChildWhichIsA("UIAspectRatioConstraint").AspectRatio = ratio
	else
		local constraint = Instance.new("UIAspectRatioConstraint")
		constraint.Parent = Frame
		constraint.AspectRatio = ratio
	end

	local Shadow = Instance.new("ImageLabel", Frame)
	Shadow.BackgroundTransparency = 1
	Shadow.ScaleType = Enum.ScaleType.Slice
	Shadow.ImageTransparency = 0.7
	Shadow.ImageColor3 = Color3.new(0, 0, 0)
	Shadow.Image = "rbxassetid://7912134082"
	Shadow.SliceCenter = Rect.new(210, 210, 210, 210)
	Shadow.SliceScale = 0.35
	Shadow.Size = UDim2.new(1, 25, 1, 25)
	Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
	Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	Shadow.ZIndex = 0
	Shadow.Name = "POPUP.GRADIENT"

	LoadUtilities(Style, Frame)
	local connect
	connect = game:GetService("RunService").RenderStepped:Connect(function()
		if Frame:FindFirstChild("ListOfUtilites") then
			connect:Disconnect()
			Frame:WaitForChild("ListOfUtilites").InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					dragStart = input.Position
					startPos = Frame.Position

					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragging = false
						end
					end)
				end
			end)

			Frame:WaitForChild("ListOfUtilites").InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					dragInput = input
				end
			end)
		end
		task.wait()
	end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		UpdateFrame(input, Frame)
	end
end)

if Style[2]:lower() == "dark" then
	Frame.BackgroundColor3 = Color3.new(0.180392, 0.180392, 0.180392)
else
	Frame.BackgroundColor3 = Color3.new(1, 1, 1)
end
if tostring(Style[1]) == "11" then
	local Corner = Instance.new("UICorner", Frame)
	Corner.CornerRadius = UDim.new(0, 6)
else
	local Stroke = Instance.new("UIStroke", Frame)
	Stroke.Color = Color3.new(0, 0, 0)
	Stroke.Thickness = 1
	Stroke.LineJoinMode = Enum.LineJoinMode.Miter
	Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
end
end

return Modules
