
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local hiddenObjects = {}

local function isCharacterOrNPC(obj)
    local current = obj

    while current and current ~= Workspace do
        if current:IsA("Model") then
            if current:FindFirstChildOfClass("Humanoid") then
                return true
            end
        end
        current = current.Parent
    end

    return false
end

local function hideMap()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not isCharacterOrNPC(obj) then
            hiddenObjects[obj] = {
                Transparency = obj.Transparency,
                CanCollide = obj.CanCollide,
                CastShadow = obj.CastShadow
            }

            obj.Transparency = 1
            obj.CanCollide = false
            obj.CastShadow = false
        end
    end

    Lighting.GlobalShadows = false
    print("Map hidden!")
end

local function restoreMap()
    for obj, data in pairs(hiddenObjects) do
        if obj and obj.Parent then
            obj.Transparency = data.Transparency
            obj.CanCollide = data.CanCollide
            obj.CastShadow = data.CastShadow
        end
    end

    table.clear(hiddenObjects)
    print("Map restored!")
end

-- Chạy thử:
hideMap()

-- Muốn khôi phục thì gọi:
-- restoreMap()
