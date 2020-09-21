-----------------------------------------------------------------------
--    DisplayDungeon - Created by Smokey - https://smokeydev.pl/     --
-----------------------------------------------------------------------

-- Display handler

local tankFrame = CreateFrame("Frame", nil, UIParent)
tankFrame:SetSize(20, 20)
tankFrame:SetPoint("TOPRIGHT", -118 - Config.MarginRight, -175 - Config.MarginTop)
local tankTxd = tankFrame:CreateTexture()
tankTxd:SetTexture("Interface\\Addons\\DisplayDungeon\\Textures\\tank")
tankTxd:SetPoint("CENTER")
tankTxd:SetSize(20, 20)

local healFrame = CreateFrame("Frame", nil, UIParent)
healFrame:SetSize(20, 20)
healFrame:SetPoint("TOPRIGHT", -97 - Config.MarginRight, -175 - Config.MarginTop)
local healTxd = healFrame:CreateTexture()
healTxd:SetTexture("Interface\\Addons\\DisplayDungeon\\Textures\\healer")
healTxd:SetPoint("CENTER")
healTxd:SetSize(20, 20)

local dps1Frame = CreateFrame("Frame", nil, UIParent)
dps1Frame:SetSize(20, 20)
dps1Frame:SetPoint("TOPRIGHT", -76 - Config.MarginRight, -175 - Config.MarginTop)
local dps1Txd = dps1Frame:CreateTexture()
dps1Txd:SetTexture("Interface\\Addons\\DisplayDungeon\\Textures\\dps")
dps1Txd:SetPoint("CENTER")
dps1Txd:SetSize(20, 20)

local dps2Frame = CreateFrame("Frame", nil, UIParent)
dps2Frame:SetSize(20, 20)
dps2Frame:SetPoint("TOPRIGHT", -55 - Config.MarginRight, -175 - Config.MarginTop)
local dps2Txd = dps2Frame:CreateTexture()
dps2Txd:SetTexture("Interface\\Addons\\DisplayDungeon\\Textures\\dps")
dps2Txd:SetPoint("CENTER")
dps2Txd:SetSize(20, 20)

local dps3Frame = CreateFrame("Frame", nil, UIParent)
dps3Frame:SetSize(20, 20)
dps3Frame:SetPoint("TOPRIGHT", -34 - Config.MarginRight, -175 - Config.MarginTop)
local dps3Txd = dps3Frame:CreateTexture()
dps3Txd:SetTexture("Interface\\Addons\\DisplayDungeon\\Textures\\dps")
dps3Txd:SetPoint("CENTER")
dps3Txd:SetSize(20, 20)
 
-- Actual script stuff

function display(show, tank, heal, dps)
    if not show then
        tankFrame:Hide()
        healFrame:Hide()
        dps1Frame:Hide()
        dps2Frame:Hide()
        dps3Frame:Hide()
    else
        tankFrame:Show()
        healFrame:Show()
        dps1Frame:Show()
        dps2Frame:Show()
        dps3Frame:Show()
        tankTxd:Show()
        healTxd:Show()
        dps1Txd:Show()
        dps2Txd:Show()
        dps3Txd:Show()
        if tank == 0 then
            tankTxd:SetTexture("Interface\\Addons\\DisplayDungeon\\Textures\\tankReady")
        else
            tankTxd:SetTexture("Interface\\Addons\\DisplayDungeon\\Textures\\tank")
        end
        if heal == 0 then
            healTxd:SetTexture("Interface\\Addons\\DisplayDungeon\\Textures\\healerReady")
        else
            healTxd:SetTexture("Interface\\Addons\\DisplayDungeon\\Textures\\healer")
        end
        if dps == 0 then
            dps1Txd:SetTexture("Interface\\Addons\\DisplayDungeon\\Textures\\dpsReady")
            dps2Txd:SetTexture("Interface\\Addons\\DisplayDungeon\\Textures\\dpsReady")
            dps3Txd:SetTexture("Interface\\Addons\\DisplayDungeon\\Textures\\dpsReady")
        elseif dps == 1 then
            dps1Txd:SetTexture("Interface\\Addons\\DisplayDungeon\\Textures\\dps")
            dps2Txd:SetTexture("Interface\\Addons\\DisplayDungeon\\Textures\\dpsReady")
            dps3Txd:SetTexture("Interface\\Addons\\DisplayDungeon\\Textures\\dpsReady")
        elseif dps == 2 then
            dps1Txd:SetTexture("Interface\\Addons\\DisplayDungeon\\Textures\\dps")
            dps2Txd:SetTexture("Interface\\Addons\\DisplayDungeon\\Textures\\dps")
            dps3Txd:SetTexture("Interface\\Addons\\DisplayDungeon\\Textures\\dpsReady")
        else
            dps1Txd:SetTexture("Interface\\Addons\\DisplayDungeon\\Textures\\dps")
            dps2Txd:SetTexture("Interface\\Addons\\DisplayDungeon\\Textures\\dps")
            dps3Txd:SetTexture("Interface\\Addons\\DisplayDungeon\\Textures\\dps")
        end
    end
end

tankFrame:RegisterEvent("LFG_UPDATE")
tankFrame:RegisterEvent("LFG_PROPOSAL_SUCCEEDED")
tankFrame:RegisterEvent("LFG_PROPOSAL_SHOW")
tankFrame:RegisterEvent("LFG_PROPOSAL_FAILED")
tankFrame:RegisterEvent("LFG_PROPOSAL_UPDATE")
tankFrame:RegisterEvent("LFG_QUEUE_STATUS_UPDATE")
tankFrame:RegisterEvent("PARTY_MEMBERS_CHANGED")
tankFrame:RegisterEvent("UPDATE_LFG_LIST")
Display = function(self, event, ...)
    if event == "LFG_PROPOSAL_SHOW" or event == "LFG_PROPOSAL_SUCCEEDED" then -- stop queue text
        display(false)
    else -- re/start queue text
        local inParty, joined, queued, noPartialClear, achievements, lfgComment, slotCount = GetLFGInfoServer()
        if queued then
            local hasData, leaderNeeds, tankNeeds, healerNeeds, dpsNeeds, totalTanks, totalHealers, totalDPS, instanceType, instanceSubType, instanceName, averageWait, tankWait, healerWait, damageWait, myWait, queuedTime = GetLFGQueueStats();
            tankNeeds = tankNeeds or 1
            healerNeeds = healerNeeds or 1
            dpsNeeds = dpsNeeds or 3
            display(true, tankNeeds, healerNeeds, dpsNeeds)
        else
            display(false)
        end
    end
end
tankFrame:SetScript("OnEvent", Display)
display(false)
print("|cffff00ddDisplayDungeon loaded. Good luck!|r")