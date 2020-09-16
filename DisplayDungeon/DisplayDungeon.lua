-----------------------------------------------------------------------
--    DisplayDungeon - Created by Smokey - https://smokeydev.pl/     --
-----------------------------------------------------------------------

--------------------------------------------------
--    Description:
--    This simple AddOn shows a small text under a minimap
--    which shows current RDF queue status.
--    Example: "Dungeon: 3/5"
--    You no longer have to hover queue icon
--    to check RDF status!
--    You can change text color and duration
--    in the config below.
--------------------------------------------------

-- Config
local Config = {}
Config.Color = {
   ['red'] = false,
   ['pink'] = false,
   ['purple'] = false,
   ['blue'] = false,
   ['cyan'] = false,
   ['green'] = false,
   ['yellow'] = true -- active
}

-- Variables
local DisplayDungeon = {}
DisplayDungeon.Colors = {
    ['red'] = 'ff0000',
    ['pink'] = 'ff00dd',
    ['purple'] = '9000ff',
    ['blue'] = '0033ff',
    ['cyan'] = '00fff7',
    ['green'] = '0dff00',
    ['yellow'] = 'fff700'
}

-- Text display handler

local f1 = CreateFrame("Frame", nil, UIParent)
f1:SetWidth(1) 
f1:SetHeight(1) 
f1:SetAlpha(.90)
f1:SetPoint("RIGHT", -80, 260)
f1.text = f1:CreateFontString(nil, "ARTWORK") 
f1.text:SetFont("Fonts\\ARIALN.ttf", 15, "THICKOUTLINE")
f1.text:SetPoint("Right", 0, 0)
f1:Hide()

-- Updating display text

function displayupdate(show, message)
    if show then
        f1.text:SetText(message)
        f1:Show()
    else
        f1:Hide()
    end
end
 
-- Actual script stuff

f1:RegisterEvent("LFG_UPDATE")
f1:RegisterEvent("LFG_PROPOSAL_SUCCEEDED")
f1:RegisterEvent("LFG_PROPOSAL_SHOW")
f1:RegisterEvent("LFG_PROPOSAL_FAILED")
f1:RegisterEvent("LFG_PROPOSAL_UPDATE")
f1:RegisterEvent("LFG_QUEUE_STATUS_UPDATE")
f1:RegisterEvent("PARTY_MEMBERS_CHANGED")
f1:RegisterEvent("UPDATE_LFG_LIST")
DisplayDungeon.Text = function(self, event, ...)
    if event == "LFG_PROPOSAL_SHOW" or event == "LFG_PROPOSAL_SUCCEEDED" then -- stop queue text
        displayupdate(false)
    else -- re/start queue text
        local inParty, joined, queued, noPartialClear, achievements, lfgComment, slotCount = GetLFGInfoServer()
        if queued then
            local hasData,  leaderNeeds, tankNeeds, healerNeeds, dpsNeeds, totalTanks, totalHealers, totalDPS, instanceType, instanceSubType, instanceName, averageWait, tankWait, healerWait, damageWait, myWait, queuedTime = GetLFGQueueStats();
            tankNeeds = tankNeeds or 1
            healerNeeds = healerNeeds or 1
            dpsNeeds = dpsNeeds or 3
            local slotCount = 5 - tankNeeds - healerNeeds - dpsNeeds
            displayupdate(true, "|cff"..DisplayDungeon.Colors[Config.Color].."Dungeon: "..tostring(slotCount).."/5")
        else
            displayupdate(false)
        end
    end
end
f1:SetScript("OnEvent", DisplayDungeon.Text)