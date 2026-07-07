-- ScorpionX UI Library
local Library = {}
Library.__index = Library

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

function Library:MakeWindow(cfg)
    local gui = Instance.new("ScreenGui")
    gui.Name = cfg.Title or "ScorpionX"
    gui.ResetOnSpawn = false
    gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

    local window = Instance.new("Frame")
    window.Size = UDim2.new(0, 520, 0, 360)
    window.Position = UDim2.new(0.5, -260, 0.5, -180)
    window.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    window.Parent = gui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 32)
    title.BackgroundTransparency = 1
    title.Text = (cfg.Title or "Window") .. " - " .. (cfg.SubTitle or "")
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.Parent = window

    local tabHolder = Instance.new("Frame")
    tabHolder.Size = UDim2.new(0, 130, 1, -40)
    tabHolder.Position = UDim2.new(0, 5, 0, 40)
    tabHolder.BackgroundTransparency = 1
    tabHolder.Parent = window

    local contentHolder = Instance.new("Frame")
    contentHolder.Size = UDim2.new(1, -140, 1, -40)
    contentHolder.Position = UDim2.new(0, 135, 0, 40)
    contentHolder.BackgroundTransparency = 1
    contentHolder.Parent = window

    local WindowObj = {
        Tabs = {},
        TabHolder = tabHolder,
        ContentHolder = contentHolder
    }

    function WindowObj:MakeTab(cfg)
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(1, 0, 0, 32)
        tabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.Font = Enum.Font.Gotham
        tabButton.TextSize = 14
        tabButton.Text = cfg.Title or "Tab"
        tabButton.Parent = self.TabHolder

        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabContent.BackgroundTransparency = 1
        tabContent.Visible = false
        tabContent.Parent = self.ContentHolder

        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 6)
        layout.Parent = tabContent

        local TabObj = {
            Button = tabButton,
            Content = tabContent
        }

        function TabObj:Select()
            for _, t in pairs(WindowObj.Tabs) do
                t.Content.Visible = false
                t.Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            end
            self.Content.Visible = true
            self.Button.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
        end

        function TabObj:AddSection(name)
            local SectionObj = {}

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -10, 0, 24)
            label.BackgroundTransparency = 1
            label.Text = name or "Section"
            label.TextColor3 = Color3.fromRGB(255, 255, 255)
            label.Font = Enum.Font.GothamBold
            label.TextSize = 16
            label.Parent = tabContent

            function SectionObj:AddButton(cfg)
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, -10, 0, 28)
                btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                btn.Font = Enum.Font.Gotham
                btn.TextSize = 14
                btn.Text = cfg.Name or "Button"
                btn.Parent = tabContent

                btn.MouseButton1Click:Connect(function()
                    if cfg.Callback then cfg.Callback() end
                end)
            end

            function SectionObj:AddToggle(cfg)
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1, -10, 0, 28)
                frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                frame.Parent = tabContent

                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(0.7, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.Text = cfg.Name or "Toggle"
                label.TextColor3 = Color3.fromRGB(255, 255, 255)
                label.Font = Enum.Font.Gotham
                label.TextSize = 14
                label.Parent = frame

                local button = Instance.new("TextButton")
                button.Size = UDim2.new(0.25, 0, 0.7, 0)
                button.Position = UDim2.new(0.72, 0, 0.15, 0)
                button.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
                button.Text = "OFF"
                button.TextColor3 = Color3.fromRGB(255, 255, 255)
                button.Font = Enum.Font.GothamBold
                button.TextSize = 14
                button.Parent = frame

                local state = cfg.Default or false

                local function update()
                    if state then
                        button.BackgroundColor3 = Color3.fromRGB(0, 80, 0)
                        button.Text = "ON"
                    else
                        button.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
                        button.Text = "OFF"
                    end
                end

                update()

                button.MouseButton1Click:Connect(function()
                    state = not state
                    update()
                    if cfg.Callback then cfg.Callback(state) end
                end)
            end

            function SectionObj:AddSlider(cfg)
                local frame = Instance.new("Frame")
                frame.Size = UDim2.new(1, -10, 0, 40)
                frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                frame.Parent = tabContent

                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, 0, 0, 18)
                label.BackgroundTransparency = 1
                label.Text = cfg.Name or "Slider"
                label.TextColor3 = Color3.fromRGB(255, 255, 255)
                label.Font = Enum.Font.Gotham
                label.TextSize = 14
                label.Parent = frame

                local bar = Instance.new("Frame")
                bar.Size = UDim2.new(1, -10, 0, 10)
                bar.Position = UDim2.new(0, 5, 0, 22)
                bar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                bar.Parent = frame

                local fill = Instance.new("Frame")
                fill.Size = UDim2.new(0, 0, 1, 0)
                fill.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
                fill.Parent = bar

                local min = cfg.Min or 0
                local max = cfg.Max or 100
                local value = cfg.Default or min

                local function setValue(v)
                    v = math.clamp(v, min, max)
                    value = v
                    fill.Size = UDim2.new((v - min) / (max - min), 0, 1, 0)
                    label.Text = cfg.Name .. " (" .. math.floor(v) .. ")"
                    if cfg.Callback then cfg.Callback(v) end
                end

                setValue(value)

                local uis = game:GetService("UserInputService")
                local dragging = false

                bar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                    end
                end)

                bar.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)

                uis.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local rel = (input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X
                        setValue(min + (max - min) * rel)
                    end
                end)
            end

            return SectionObj
        end

        table.insert(WindowObj.Tabs, TabObj)
        if #WindowObj.Tabs == 1 then TabObj:Select() end

        return TabObj
    end

    return WindowObj
end

return Library
