local isUIOpen = false
local isNUIReady = false
local nuiWaitTime = Config.NUIReadyTime
local isPlayerDead = false
local currentCamera = nil
local lastPlayerCoords = nil
local savedComponents = {}
local savedProps = {}

local openKey = Config.Keys.open

-- Event handlers
RegisterNetEvent("wais:change:deadstate", function(deadState)
    isPlayerDead = deadState
    if isUIOpen then
        closeUI()
    end
end)

RegisterNetEvent("wais:openWheel", function()
    openUI()
end)

-- NUI Callbacks
RegisterNUICallback("ready", function(data, cb)
    isNUIReady = true
    cb("ok")
end)

RegisterNUICallback("close", function(data, cb)
    closeUI()
    cb("ok")
end)

RegisterNUICallback("playBeep", function(data, cb)
    PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
    cb("ok")
end)

RegisterNUICallback("action", function(data, cb)
    local success = processData(data)
    cb(success)
end)

-- Initialize NUI
local function initNUI()
    while true do
        if isNUIReady then
            break
        end
        nuiWaitTime = nuiWaitTime - 1000
        if nuiWaitTime <= 0 then
            print("NUI is not ready")
            return
        end
        Wait(1000)
    end
    
    nuiWaitTime = Config.NUIReadyTime
    SendNUIMessage({
        type = "SEND_DEFAULT_THINGS",
        close = Config.Keys.close,
        items = Config.Drawables,
        position = Config.WheelPosition
    })
end

-- Process clothing changes
function processData(actionData)
    local promiseResult = promise.new()
    local playerPed = PlayerPedId()
    local drawableConfig = Config.Drawables[actionData.name]
    
    if drawableConfig == nil then
        return false
    end
    
    local playerModel = GetEntityModel(playerPed)
    local isMale = (playerModel == joaat("mp_m_freemode_01"))
    local gender = isMale and "male" or "female"
    
    -- Check glove dependency
    if actionData.name == "gloves" and savedComponents.torso == nil then
        PlaySoundFrontend(-1, "Beep_Red", "DLC_HEIST_HACKING_SNAKE_SOUNDS", 1)
        promiseResult:reject(false)
        return Citizen.Await(promiseResult)
    end
    
    -- Play animation if enabled
    if Config.UseAnimation then
        local anim = drawableConfig.animation
        if anim ~= nil then
            local animName = savedComponents[actionData.name] ~= nil and anim.dress or anim.undress
            if animName then
                animatePlayer(animName)
            end
        end
    end
    
    local itemType = drawableConfig.drawable.type
    
    -- Handle component changes
    if itemType == "component" then
        if savedComponents[actionData.name] ~= nil then
            -- Remove item (restore saved)
            SetPedComponentVariation(playerPed, drawableConfig.drawable.componentid, 
                savedComponents[actionData.name].drawable, savedComponents[actionData.name].texture, 0)
            savedComponents[actionData.name] = nil
        else
            -- Add item (save current)
            savedComponents[actionData.name] = {
                drawable = GetPedDrawableVariation(playerPed, drawableConfig.drawable.componentid),
                texture = GetPedTextureVariation(playerPed, drawableConfig.drawable.componentid)
            }
            SetPedComponentVariation(playerPed, drawableConfig.drawable.componentid,
                drawableConfig.drawable[gender].default, drawableConfig.drawable[gender].texture, 0)
        end
        
    -- Handle prop changes
    elseif itemType == "prop" then
        if savedProps[actionData.name] ~= nil then
            SetPedPropIndex(playerPed, drawableConfig.drawable.componentid,
                savedProps[actionData.name].drawable, savedProps[actionData.name].texture, true)
            savedProps[actionData.name] = nil
        else
            savedProps[actionData.name] = {
                drawable = GetPedPropIndex(playerPed, drawableConfig.drawable.componentid),
                texture = GetPedPropTextureIndex(playerPed, drawableConfig.drawable.componentid)
            }
            ClearPedProp(playerPed, drawableConfig.drawable.componentid)
        end
    end
    
    -- Handle extra items
    if drawableConfig.extras ~= nil then
        for extraKey, extraData in pairs(drawableConfig.extras[gender] or {}) do
            if savedComponents["extra_" .. actionData.name] == nil then
                savedComponents["extra_" .. actionData.name] = {}
            end
            
            if extraData.type == "component" then
                if savedComponents["extra_" .. actionData.name][extraKey] ~= nil then
                    SetPedComponentVariation(playerPed, extraData.componentid,
                        savedComponents["extra_" .. actionData.name][extraKey].drawable,
                        savedComponents["extra_" .. actionData.name][extraKey].texture, 0)
                    savedComponents["extra_" .. actionData.name][extraKey] = nil
                else
                    savedComponents["extra_" .. actionData.name][extraKey] = {
                        drawable = GetPedDrawableVariation(playerPed, extraData.componentid),
                        texture = GetPedTextureVariation(playerPed, extraData.componentid)
                    }
                    SetPedComponentVariation(playerPed, extraData.componentid, extraData.default, extraData.texture, 0)
                end
            elseif extraData.type == "prop" then
                if savedComponents["extra_" .. actionData.name][extraKey] ~= nil then
                    SetPedPropIndex(playerPed, extraData.componentid,
                        savedComponents["extra_" .. actionData.name][extraKey].drawable,
                        savedComponents["extra_" .. actionData.name][extraKey].texture, true)
                    savedComponents["extra_" .. actionData.name][extraKey] = nil
                else
                    savedComponents["extra_" .. actionData.name][extraKey] = {
                        drawable = GetPedPropIndex(playerPed, extraData.componentid),
                        texture = GetPedPropTextureIndex(playerPed, extraData.componentid)
                    }
                    SetPedPropIndex(playerPed, extraData.componentid, extraData.drawable, extraData.texture, true)
                end
            end
        end
    end
    
    PlaySoundFrontend(-1, "TOGGLE_ON", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    promiseResult:resolve(true)
    return Citizen.Await(promiseResult)
end

-- Play animation function
function animatePlayer(animation)
    local playerPed = PlayerPedId()
    
    RequestAnimDict(animation.dict)
    while not HasAnimDictLoaded(animation.dict) do
        RequestAnimDict(animation.dict)
        Wait(250)
    end
    
    FreezeEntityPosition(playerPed, true)
    TaskPlayAnim(playerPed, animation.dict, animation.name, 3.0, 3.0, animation.time, animation.move, 0, false, false, false)
    Wait(animation.time)
    ClearPedTasks(playerPed)
    RemoveAnimDict(animation.dict)
    FreezeEntityPosition(playerPed, false)
end

-- Camera functions
function createCamera()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local heading = GetEntityHeading(playerPed)
    local distance = 3.0
    
    local radHeading = math.rad(heading)
    local camX = coords.x - (distance * math.sin(radHeading)) + Config.CameraOffsets.x
    local camY = coords.y + (distance * math.cos(radHeading)) + Config.CameraOffsets.y
    local camZ = coords.z + Config.CameraOffsets.z
    
    currentCamera = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", camX, camY, camZ, 0.0, 0.0, heading + 180.0, Config.CamFov, false, 0)
    SetCamActive(currentCamera, true)
    RenderScriptCams(true, true, 550, true, true)
    SetCamUseShallowDofMode(currentCamera, true)
    SetCamNearDof(currentCamera, 0.1)
    SetCamFarDof(currentCamera, 1.0)
    SetCamDofStrength(currentCamera, 1)
    SetCamDofFocalLengthMultiplier(currentCamera, 100.0)
    PointCamAtCoord(currentCamera, coords.x, coords.y, coords.z + Config.CameraOffsets.zRot)
    
    lastPlayerCoords = coords
end

function destroyCamera()
    if currentCamera ~= nil then
        RenderScriptCams(false, true, 550, true, true)
        DestroyCam(currentCamera, false)
        currentCamera = nil
        lastPlayerCoords = nil
    end
end

-- UI control functions
function openUI()
    if IsPedInAnyVehicle(PlayerPedId(), false) and not Config.CanOpenInCar then
        return
    end
    
    if Config.ShowCharacter then
        createCamera()
    end
    
    SetNuiFocus(true, true)
    SendNUIMessage({ type = "SHOW_UI" })
    isUIOpen = true
end

function closeUI()
    if Config.ShowCharacter then
        destroyCamera()
    end
    
    isUIOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({ type = "HIDE_UI" })
end

-- Key mapping setup
if Config.UseKeyMapping.use then
    RegisterKeyMapping("_dress", "Open Dress Wheel", "keyboard", Config.UseKeyMapping.key)
    RegisterCommand("_dress", function()
        if not isPlayerDead then
            openUI()
        end
    end, false)
else
    CreateThread(function()
        while true do
            Wait(5)
            if IsControlJustPressed(0, openKey) and not isPlayerDead then
                openUI()
            end
        end
    end)
end

-- Camera distance check thread
CreateThread(function()
    while true do
        Wait(1000)
        if currentCamera ~= nil then
            Wait(5)
            local currentCoords = GetEntityCoords(PlayerPedId())
            if #(lastPlayerCoords - currentCoords) > 3 then
                closeUI()
            end
        end
    end
end)

-- Initialize on session start
CreateThread(function()
    while true do
        Wait(0)
        if NetworkIsSessionStarted() then
            initNUI()
            break
        end
    end
end)