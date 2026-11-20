-- Event handlers for various ambulance/death status systems
RegisterNetEvent("osp_amblance:setDeathStatus", function(isDead)
  local src = source
  changeDeadStatus(src, isDead)
end)

RegisterNetEvent("esx_ambulancejob:setDeathStatus", function(isDead)
  local src = source
  changeDeadStatus(src, isDead)
end)

RegisterNetEvent("hospital:server:SetDeathStatus", function(isDead)
  local src = source
  changeDeadStatus(src, isDead)
end)

RegisterNetEvent("hospital:server:SetLaststandStatus", function(isDead)
  local src = source
  changeDeadStatus(src, isDead)
end)

RegisterNetEvent("wasabi_ambulance:setDeathStatus", function(isDead)
  local src = source
  changeDeadStatus(src, isDead)
end)

-- Function to sync death status to client
function changeDeadStatus(playerId, isDead)
  if isDead ~= nil then
      TriggerClientEvent("wais:change:deadstate", playerId, isDead)
  end
end
