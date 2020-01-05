local printKillFrame = CreateFrame('Frame', 'printKillFrame', UIParent);
local playerName = UnitName("player");
local killCount = 0;

function startLog(_,_,_, eventType,_, initiatorName,_, targetGUID, targetName)
  if eventType == "PARTY_KILL" and initiatorName == playerName and (tonumber(targetGUID:sub(5,5), 16) % 8) == 0 then
    killCount = killCount + 1;
    SendChatMessage("поимел новую жертву: " .. "{крест} " .. targetName .. " {крест} || Убийств: " .. killCount, "EMOTE");
    end
    if eventType == "UNIT_DIED" and targetName == playerName then
    killCount = 0;
    end
end

function init() 
  printKillFrame:RegisterEvent('COMBAT_LOG_EVENT');
  printKillFrame:SetScript('OnEvent', startLog);
end
