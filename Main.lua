local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local hiddenObjects = {}
local originalGlobalShadows
local isHidden = false

local function isCharacterOrNPC(obj)
    local current = obj

    while current and current ~= Workspace do
        if current:IsA("Model") and current:FindFirstChildOfClass("Humanoid") then
            return true
        end
        current = current.Parent
    end

    return false
end

local function hideMap()
    if isHidden then
        warn("Map is already hidden")
        return
    end

    isHidden = true
    originalGlobalShadows = Lighting.GlobalShadows

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
    if not isHidden then
        warn("Map is not hidden")
        return
    end

    for obj, data in pairs(hiddenObjects) do
        if obj.Parent then
            obj.Transparency = data.Transparency
            obj.CanCollide = data.CanCollide
            obj.CastShadow = data.CastShadow
        end
    end

    table.clear(hiddenObjects)
    Lighting.GlobalShadows = originalGlobalShadows
    isHidden = false
    print("Map restored!")
end
