local _, AddonTable = ...
local L = AddonTable.L

local AdiBags = LibStub("AceAddon-3.0"):GetAddon("AdiBags")
local Core = LibStub("AceAddon-3.0"):NewAddon("AdiBags_SniperTBC")
local namespace = 'Sniper TBC Classic'

-- Addon Debug (ViragDevTools)
function Core:Dump(str, obj) if ViragDevTool_AddData then ViragDevTool_AddData(obj, str) end end

function Core:GetOptions() return {} end
function Core:GetProfile() return { SnipersReputation = true } end

function Core:DefaultFilter(slotData)
  local tables = {
    -- Professions
    ['prof'] = 'Trade Goods: General',
    ['alchemy'] = 'Trade Goods: Alchemy',
    ['bs'] = 'Trade Goods: Blacksmithing',
    ['ench'] = 'Trade Goods: Enchanting',
    ['eng'] = 'Trade Goods: Engineering',
    ['lw'] = 'Trade Goods: Leatherworking',
    ['tailor'] = 'Trade Goods: Tailoring',
    ['tools'] = 'Tools',
    -- Trade Goods
    ['trade'] = 'Trade Goods: General',
    ['cloth'] = 'Trade Goods: Cloth',
    ['herbs'] = 'Trade Goods: Herbalism',
    ['ore'] = 'Trade Goods: Ore',
    ['stone'] = 'Trade Goods: Stone',
    ['gems'] = 'Trade Goods: Gems',
    -- Reputation
    ['ad'] = 'Rep: Argent Dawn',
    ['tb'] = 'Rep: Thorium Brotherhood',
    ['timbermaw'] = 'Rep: Timbermaw',
    -- Class
    ['druid'] = 'Druid',
    ['mage'] = 'Mage',
    ['paladin'] = 'Paladin',
    ['priest'] = 'Priest',
    ['rogue'] = 'Rogue',
    ['shaman'] = 'Shaman',
    ['warlock'] = 'Warlock',
    ['warrior'] = 'Warrior',
    -- Warlock
    ['shards'] = 'Soul Shards',
    -- Other
    ['vendor'] = 'Vendor Trash',
    ['keys'] = 'Keys',
    ['travel'] = 'Travel',
    ['ammo'] = 'Ammunition',
    ['darkmoon'] = 'Darkmoon Faire',
    -- Misc
    ['containers'] = 'Containers',
    ['openables'] = 'Openables',
    ['lockboxes'] = 'Lockboxes'
  }

  for tbl,desc in pairs(tables) do
    if AddonTable[tbl] then
      if AddonTable[tbl]['items'] then
        if AddonTable[tbl]['items'][slotData.itemId] then
          return desc
        end
      end
    end
  end

  if AddonTable.boe.cloth[slotData.itemId] then return "BoE: Cloth" end
  if AddonTable.boe.leather[slotData.itemId] then return "BoE: Leather" end
  if AddonTable.boe.mail[slotData.itemId] then return "BoE: Mail" end
  if AddonTable.boe.plate[slotData.itemId] then return "BoE: Plate" end
  if AddonTable.boe.jewelry[slotData.itemId] then return "BoE: Jewelry" end

  if AddonTable.boe.axes[slotData.itemId] then return "BoE: Axes" end
  if AddonTable.boe.bows[slotData.itemId] then return "BoE: Bows" end
  if AddonTable.boe.daggers[slotData.itemId] then return "BoE: Daggers" end
  if AddonTable.boe.guns[slotData.itemId] then return "BoE: Guns" end
  if AddonTable.boe.maces[slotData.itemId] then return "BoE: Maces" end
  if AddonTable.boe.offhands[slotData.itemId] then return "BoE: Off-Hands" end
  if AddonTable.boe.polearms[slotData.itemId] then return "BoE: Polearms" end
  if AddonTable.boe.staves[slotData.itemId] then return "BoE: Staves" end
  if AddonTable.boe.shields[slotData.itemId] then return "BoE: Shields" end
  if AddonTable.boe.swords[slotData.itemId] then return "BoE: Swords" end
  if AddonTable.boe.wands[slotData.itemId] then return "BoE: Wands" end
end

local filter = AdiBags:RegisterFilter(namespace, 95)
filter.uiName = 'Sniper TBC Classic'
filter.description = 'Sniper TBC Classic Filters'

function filter:Filter(slotData)
  return Core:DefaultFilter(slotData)
end

function filter:OnInitialize()
  self.db = AdiBags.db:RegisterNamespace(namespace, {
      profile = Core:GetProfile()
  })
end

function filter:GetOptions()
  return Core:GetOptions(), AdiBags:GetOptionHandler(self, true)
end
