local printKillFrame = CreateFrame('Frame', 'printKillFrame', UIParent);
local playerName = UnitName("player");
local killCount = 0;
local slash = "/flex - выводит информацию о доступных командах аддона flexKill";
local slash_on = "/flex on - активирует аддон flexKill";
local slash_off = "/flex off - отключает аддон flexKill";
local slash_kill = "/flex kill - показывает текущее кол-во убийств";
local slash_reset= "/flex reset - сбрасывает кол-во убийств";
local slash_commands = {
  slash,
  slash_on,
  slash_off,
  slash_kill,
  slash_reset,
}

local function flexStop()
  printKillFrame:UnregisterEvent('COMBAT_LOG_EVENT');
  PartyMemberFrame1:SetScript("OnEvent", nil);
  print('|cffff0000flexKill отключен');
end

local function flexPrintKill()
  print("|cff1eff00flexKill: Кол-во убийств: " .. killCount);
end

local function flexShowInfo()
  for i = 1, #slash_commands, 1 do
    print(slash_commands[i]);
  end
end

local function flexReset()
  if killCount ~= 0 then
    killCount = 0;
    print("|cffffd100flexKill: Убийства сброшены");
  end
end

local actions = {
  ["on"] = function() flexInit() end,
  ["off"] = function() flexStop() end,
  ["kill"] = function() flexPrintKill() end,
  ["reset"] = function() flexReset() end,
};

local function slashHandler(msg)
  if (actions[msg]) then
  actions[msg]();
  else
    flexShowInfo();
  end
end

function flexStartLog(_,_,_, eventType,_, initiatorName,_, targetGUID, targetName)
  if eventType == "PARTY_KILL" and initiatorName == playerName and (tonumber(targetGUID:sub(5,5), 16) % 8) == 0 then
    killCount = killCount + 1;
    SendChatMessage("поимел новую жертву: " .. "{крест} " .. targetName .. " {крест} || Убийств: " .. killCount, "EMOTE");
    end
    if eventType == "UNIT_DIED" and targetName == playerName then
      flexReset();
    end
end

function flexInit() 
  printKillFrame:RegisterEvent('COMBAT_LOG_EVENT');
  printKillFrame:SetScript('OnEvent', flexStartLog);
  print('|cffa335eeflexKill активирован. Вы звезда PvP');
end

SLASH_FLEX1 = "/flex"
SlashCmdList["FLEX"] = slashHandler