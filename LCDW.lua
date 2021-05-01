----------------------------------------------------------
----/////////////////////// VARS ///////////////////////--
----------------------------------------------------------
local name, addonNamespace = ...
addonNamespace.Helpers = {}
addonNamespace.UIElements = {}

local Helpers = addonNamespace.Helpers
local UIElements = addonNamespace.UIElements

local customAddonName = "Le codex de Willios"
local addonVersion = "0.8 Alpha"

local INITIAL_RATIO = 1.43016759777
local MAIN_FRAME_WITH = 600
local MAIN_FRAME_HEIGHT = 500
local FRAME_TITLE_CONTAINER_WIDTH = 100
local FRAME_TITLE_CONTAINER_HEIGHT = 40
local GUIDE_WIDTH = 850
local GUIDE_HEIGHT = 850
local ICONS_PATH = "Interface\\ICONS\\"
local PVE_FOLDER_PATH = "Interface\\AddOns\\LCDW\\guides\\pve\\"
local DUNGEONS_FOLDER_PATH = PVE_FOLDER_PATH .. "dungeons\\"
local RAIDS_FOLDER_PATH = PVE_FOLDER_PATH .. "raids\\"
local PVP_FOLDER_PATH = "Interface\\AddOns\\LCDW\\guides\\pvp\\"
local GLOSSARY_FOLDER_PATH = "Interface\\AddOns\\LCDW\\guides\\glossary\\"
local MINIMAP_ICON_PATH = "Interface\\AddOns\\LCDW\\misc\\minimap-icon"
local COPY_ICON_PATH = "Interface\\AddOns\\LCDW\\misc\\copy-icon"
local DUNGEONS_ICONS_PATH = "Interface\\ENCOUNTERJOURNAL\\UI-EJ-DUNGEONBUTTON-"
local CLASSES_ICONS_PATH = ICONS_PATH .. "ClassIcon_"
local ARROW_TITLE_SECTION = "Interface\\RAIDFRAME\\UI-RAIDFRAME-ARROW"
local QUESTIONMARK_PATH = "Interface\\Calendar\\EventNotification"
local PVP_ICON = "Interface\\Calendar\\UI-Calendar-Event-PVP"
local PVE_ICON = "Interface\\LFGFRAME\\UI-LFR-PORTRAIT"
local DUNGEON_THUMBNAIL_PATH = "Interface\\LFGFRAME\\LFGIcon-"
local SOCIAL_NETWORK_FOLDER_PATH = "Interface\\AddOns\\LCDW\\misc\\social-networks\\"
local SPECS_ICONS_PATH = "Interface\\AddOns\\LCDW\\misc\\specs-icons\\"
local NAME_COL = 1
local ICON_COL = 2
local DUNGEON_THUMBNAIL_COL = 3
local _, _, _, TOC_VERSION = GetBuildInfo()

local GREEN = "|cff00ff00"
local YELLOW = "|cffffff00"
local RED = "|cffff0000"
local BLUE = "|cff0198e1"
local ORANGE = "|cffff9933"
local WHITE = "|cffffffff"

local FRIZQT_FONT = "Fonts\\FRIZQT__.TTF"
local MORPHEUS_FONT = "Fonts\\MORPHEUS.TTF"

local SOCIAL_NETWORK_TEXT = "Pour me suivre : "
local CREDITS_TEXT = "Made by Aecx & Willios"

local textureShown = {}
local dungeonsFrames = {}
local raidsFrames = {}
local classesFrames = {}

local pveDGuidesTextures = {}
local pveRGuidesTextures = {}
local pvpGuidesTextures = {}
local glossaryTextures = {}

local dungeons = {
    {
        "Sillage nécrotique",
        DUNGEONS_ICONS_PATH .. "NecroticWake",
        DUNGEON_THUMBNAIL_PATH .. "NecroticWake"
    },
    {
        "Malepeste",
        DUNGEONS_ICONS_PATH .. "Plaguefall",
        DUNGEON_THUMBNAIL_PATH .. "Plaguefall"
    },
    {
        "Brumes de Tirna Scrithe",
        DUNGEONS_ICONS_PATH .. "MistsofTirnaScithe",
        DUNGEON_THUMBNAIL_PATH .. "MistsofTirnaScithe"
    },
    {
        "Salles de l'Expiation",
        DUNGEONS_ICONS_PATH .. "HallsofAtonement",
        DUNGEON_THUMBNAIL_PATH .. "HallsofAtonement"
    },
    {
        "Flèches de l'Ascension",
        DUNGEONS_ICONS_PATH .. "SpiresofAscension",
        DUNGEON_THUMBNAIL_PATH .. "SpiresofAscension"
    },
    {
        "Théâtre de la Souffrance",
        DUNGEONS_ICONS_PATH .. "TheaterofPain",
        DUNGEON_THUMBNAIL_PATH .. "TheaterofPain"
    },
    {
        "L'Autre côté",
        DUNGEONS_ICONS_PATH .. "TheOtherSide",
        DUNGEON_THUMBNAIL_PATH .. "TheOtherSide"
    },
    {
        "Profondeurs Sanguines",
        DUNGEONS_ICONS_PATH .. "SanguineDepths",
        DUNGEON_THUMBNAIL_PATH .. "SanguineDepths"
    }
}

local raids = {
    {
        "Château Nathria",
        DUNGEONS_ICONS_PATH .. "CastleNathria",
        DUNGEON_THUMBNAIL_PATH .. "CastleNathria"

    }
}

local classes = {
    {
        "Chaman",
        CLASSES_ICONS_PATH .. "Shaman",
        {
            { SPECS_ICONS_PATH .. "shaman\\elemental", "Élémentaire" },
            { SPECS_ICONS_PATH .. "shaman\\enhancement", "Amélioration" },
            { SPECS_ICONS_PATH .. "shaman\\resto", "Restauration" }
        }
    },
    {
        "Chasseur",
        CLASSES_ICONS_PATH .. "Hunter",
        {
            { SPECS_ICONS_PATH .. "hunter\\mm", "Précision" },
            { SPECS_ICONS_PATH .. "hunter\\bm", "Maîtrise des bêtes" },
            { SPECS_ICONS_PATH .. "hunter\\sv", "Survie" }
        }
    },
    {
        "Chasseur de Démon",
        CLASSES_ICONS_PATH .. "DemonHunter",
        {
            { SPECS_ICONS_PATH .. "demon-hunter\\vengeance", "Vengeance" },
            { SPECS_ICONS_PATH .. "demon-hunter\\havoc", "Dévastation" }
        }
    },
    {
        "Chevalier de la Mort",
        CLASSES_ICONS_PATH .. "DeathKnight",
        {
            { SPECS_ICONS_PATH .. "death-knight\\unholy", "Impie" },
            { SPECS_ICONS_PATH .. "death-knight\\frost", "Givre" },
            { SPECS_ICONS_PATH .. "death-knight\\blood", "Sang" }
        }
    },
    {
        "Démoniste",
        CLASSES_ICONS_PATH .. "Warlock",
        {
            { SPECS_ICONS_PATH .. "warlock\\demonology", "Démonologie" },
            { SPECS_ICONS_PATH .. "warlock\\affli", "Affliction" },
            { SPECS_ICONS_PATH .. "warlock\\destru", "Destruction" }
        }
    },
    {
        "Druide",
        CLASSES_ICONS_PATH .. "Druid",
        {
            { SPECS_ICONS_PATH .. "druid\\feral", "Farouche" },
            { SPECS_ICONS_PATH .. "druid\\balance", "Équilibre" },
            { SPECS_ICONS_PATH .. "druid\\guardian", "Gardien" },
            { SPECS_ICONS_PATH .. "druid\\resto", "Restauration" }
        }
    },
    {
        "Guerrier",
        CLASSES_ICONS_PATH .. "Warrior",
        {
            { SPECS_ICONS_PATH .. "warrior\\arms", "Armes" },
            { SPECS_ICONS_PATH .. "warrior\\fury", "Fureur" },
            { SPECS_ICONS_PATH .. "warrior\\prot", "Protection" }
        }
    },
    {
        "Mage",
        CLASSES_ICONS_PATH .. "Mage",
        {
            { SPECS_ICONS_PATH .. "mage\\arcane", "Arcanes" },
            { SPECS_ICONS_PATH .. "mage\\fire", "Feu" },
            { SPECS_ICONS_PATH .. "mage\\frost", "Givre" }
        }
    },
    {
        "Moine",
        CLASSES_ICONS_PATH .. "Monk",
        {
            { SPECS_ICONS_PATH .. "monk\\brewmaster", "Maître brasseur" },
            { SPECS_ICONS_PATH .. "monk\\ww", "Marche-vent" },
            { SPECS_ICONS_PATH .. "monk\\mw", "Tisse-brume" }
        }
    },
    {
        "Paladin",
        CLASSES_ICONS_PATH .. "Paladin",
        {
            { SPECS_ICONS_PATH .. "paladin\\holy", "Sacré" },
            { SPECS_ICONS_PATH .. "paladin\\prot", "Protection" },
            { SPECS_ICONS_PATH .. "paladin\\ret", "Vindicte" }
        }
    },
    {
        "Prêtre",
        CLASSES_ICONS_PATH .. "Priest",
        {
            { SPECS_ICONS_PATH .. "priest\\disc", "Discipline" },
            { SPECS_ICONS_PATH .. "priest\\shadow", "Ombre" },
            { SPECS_ICONS_PATH .. "priest\\holy", "Sacré" }
        }
    },
    {
        "Voleur",
        CLASSES_ICONS_PATH .. "Rogue",
        {
            { SPECS_ICONS_PATH .. "rogue\\assa", "Assassinat" },
            { SPECS_ICONS_PATH .. "rogue\\outlaw", "Hors-la-loi" },
            { SPECS_ICONS_PATH .. "rogue\\sub", "Finesse" }
        }
    }
}

local isGuideSelected = false
local isGuideTextureCreated = false
local isContextMenuOpen = false
local titleWidth
local textureWidth

-- folders data --
-- this var represents the guides tree structure --
-- d1 = 3 means that the dungeon one is 3 pages long --
-- the boolean right after the comma means if the guide is available or not --
-- DUNGEONS LIST --
-- d1 -> Sillage nécrotique
-- d2 -> Malepeste
-- d3 -> Brumes de Tirna Scrithe
-- d4 -> Salles de l'Expiation
-- d5 -> Flèches de l'Ascension
-- d6 -> Théâtre de la Souffrance
-- d7 -> L'Autre côté
-- d8 -> Profondeurs Sanguines
-- CLASSES LIST --
-- c1 -> chaman
-- c2 -> Chasseur
-- c3 -> Chasseur de Démon
-- c4 -> Chevalier de la Mort
-- c5 -> Démoniste
-- c6 -> Druide
-- c7 -> Guerrier
-- c8 -> Mage
-- c9 -> Moine
-- c10 -> Paladin
-- c11 -> Prêtre
-- c12 -> Voleur
local foldersItemsNb = {
    pveD = {
        {
            d1 = 3,
            isAvailable = false
        },
        {
            d2 = 3,
            isAvailable = false
        },
        {
            d3 = 3,
            isAvailable = false
        },
        {
            d4 = 3,
            isAvailable = false
        },
        {
            d5 = 3,
            isAvailable = false
        },
        {
            d6 = 3,
            isAvailable = false
        },
        {
            d7 = 3,
            isAvailable = false
        },
        {
            d8 = 3,
            isAvailable = false
        }
    },

    pveR = {
        {
            r1 = 3,
            isAvailable = false
        }
    },

    pvp = {
        {
            c1 = 3,
            atleastOneGuideSpecAvailable = false,
            {
                {
                    spec1 = true,
                    pages = 6,
                    "arms",
                    "Armes",
                    {
                        pvePages = 5,
                        pvpPages = 1
                    }
                },
                {
                    spec2 = true,
                    pages = 3,
                    "fury",
                    "Fureur",
                    {
                        pvePages = 1,
                        pvpPages = 2
                    }
                },
                {
                    spec3 = true,
                    pages = 1,
                    "protection",
                    "Protection",
                    {
                        pvePages = 1,
                        pvpPages = 0
                    }
                }
            }
        },
        {
            c2 = 3,
            atleastOneGuideSpecAvailable = false,
            {
                {
                    spec1 = true,
                    pages = 6,
                    "arms",
                    "Armes",
                    {
                        pvePages = 5,
                        pvpPages = 1
                    }
                },
                {
                    spec2 = true,
                    pages = 3,
                    "fury",
                    "Fureur",
                    {
                        pvePages = 1,
                        pvpPages = 2
                    }
                },
                {
                    spec3 = true,
                    pages = 1,
                    "protection",
                    "Protection",
                    {
                        pvePages = 1,
                        pvpPages = 0
                    }
                }
            }
        },
        {
            c3 = 3,
            atleastOneGuideSpecAvailable = false,
            {
                {
                    spec1 = true,
                    pages = 6,
                    "arms",
                    "Armes",
                    {
                        pvePages = 5,
                        pvpPages = 1
                    }
                },
                {
                    spec2 = true,
                    pages = 3,
                    "fury",
                    "Fureur",
                    {
                        pvePages = 1,
                        pvpPages = 2
                    }
                }
            }
        },
        {
            c4 = 3,
            atleastOneGuideSpecAvailable = false,
            {
                {
                    spec1 = true,
                    pages = 6,
                    "arms",
                    "Armes",
                    {
                        pvePages = 5,
                        pvpPages = 1
                    }
                },
                {
                    spec2 = true,
                    pages = 3,
                    "fury",
                    "Fureur",
                    {
                        pvePages = 1,
                        pvpPages = 2
                    }
                },
                {
                    spec3 = true,
                    pages = 1,
                    "protection",
                    "Protection",
                    {
                        pvePages = 1,
                        pvpPages = 0
                    }
                }
            }
        },
        {
            c5 = 3,
            atleastOneGuideSpecAvailable = false,
            {
                {
                    spec1 = true,
                    pages = 6,
                    "arms",
                    "Armes",
                    {
                        pvePages = 5,
                        pvpPages = 1
                    }
                },
                {
                    spec2 = true,
                    pages = 3,
                    "fury",
                    "Fureur",
                    {
                        pvePages = 1,
                        pvpPages = 2
                    }
                },
                {
                    spec3 = true,
                    pages = 1,
                    "protection",
                    "Protection",
                    {
                        pvePages = 1,
                        pvpPages = 0
                    }
                }
            }
        },
        {
            c6 = 3,
            atleastOneGuideSpecAvailable = false,
            {
                {
                    spec1 = true,
                    pages = 6,
                    "arms",
                    "Armes",
                    {
                        pvePages = 5,
                        pvpPages = 1
                    }
                },
                {
                    spec2 = true,
                    pages = 3,
                    "fury",
                    "Fureur",
                    {
                        pvePages = 1,
                        pvpPages = 2
                    }
                },
                {
                    spec3 = true,
                    pages = 1,
                    "protection",
                    "Protection",
                    {
                        pvePages = 1,
                        pvpPages = 0
                    }
                },
                {
                    spec4 = true,
                    pages = 1,
                    "protection",
                    "Protection",
                    {
                        pvePages = 1,
                        pvpPages = 0
                    }
                }
            }
        },
        {
            c7 = 6,
            atleastOneGuideSpecAvailable = true,
            {
                {
                    spec1 = true,
                    pages = 6,
                    "arms",
                    "Armes",
                    {
                        pvePages = 5,
                        pvpPages = 1
                    }
                },
                {
                    spec2 = true,
                    pages = 3,
                    "fury",
                    "Fureur",
                    {
                        pvePages = 1,
                        pvpPages = 2
                    }
                },
                {
                    spec3 = true,
                    pages = 1,
                    "protection",
                    "Protection",
                    {
                        pvePages = 1,
                        pvpPages = 0
                    }
                }
            }
        },
        {
            c8 = 3,
            atleastOneGuideSpecAvailable = false,
            {
                {
                    spec1 = true,
                    pages = 6,
                    "arms",
                    "Armes",
                    {
                        pvePages = 5,
                        pvpPages = 1
                    }
                },
                {
                    spec2 = true,
                    pages = 3,
                    "fury",
                    "Fureur",
                    {
                        pvePages = 1,
                        pvpPages = 2
                    }
                },
                {
                    spec3 = true,
                    pages = 1,
                    "protection",
                    "Protection",
                    {
                        pvePages = 1,
                        pvpPages = 0
                    }
                }
            }
        },
        {
            c9 = 3,
            atleastOneGuideSpecAvailable = false,
            {
                {
                    spec1 = true,
                    pages = 6,
                    "arms",
                    "Armes",
                    {
                        pvePages = 5,
                        pvpPages = 1
                    }
                },
                {
                    spec2 = true,
                    pages = 3,
                    "fury",
                    "Fureur",
                    {
                        pvePages = 1,
                        pvpPages = 2
                    }
                },
                {
                    spec3 = true,
                    pages = 1,
                    "protection",
                    "Protection",
                    {
                        pvePages = 1,
                        pvpPages = 0
                    }
                }
            }
        },
        {
            c10 = 3,
            atleastOneGuideSpecAvailable = false,
            {
                {
                    spec1 = true,
                    pages = 6,
                    "arms",
                    "Armes",
                    {
                        pvePages = 5,
                        pvpPages = 1
                    }
                },
                {
                    spec2 = true,
                    pages = 3,
                    "fury",
                    "Fureur",
                    {
                        pvePages = 1,
                        pvpPages = 2
                    }
                },
                {
                    spec3 = true,
                    pages = 1,
                    "protection",
                    "Protection",
                    {
                        pvePages = 1,
                        pvpPages = 0
                    }
                }
            }
        },
        {
            c11 = 3,
            atleastOneGuideSpecAvailable = false,
            {
                {
                    spec1 = true,
                    pages = 6,
                    "arms",
                    "Armes",
                    {
                        pvePages = 5,
                        pvpPages = 1
                    }
                },
                {
                    spec2 = true,
                    pages = 3,
                    "fury",
                    "Fureur",
                    {
                        pvePages = 1,
                        pvpPages = 2
                    }
                },
                {
                    spec3 = true,
                    pages = 1,
                    "protection",
                    "Protection",
                    {
                        pvePages = 1,
                        pvpPages = 0
                    }
                }
            }
        },
        {
            c12 = 3,
            atleastOneGuideSpecAvailable = false,
            {
                {
                    spec1 = true,
                    pages = 6,
                    "arms",
                    "Armes",
                    {
                        pvePages = 5,
                        pvpPages = 1
                    }
                },
                {
                    spec2 = true,
                    pages = 3,
                    "fury",
                    "Fureur",
                    {
                        pvePages = 1,
                        pvpPages = 2
                    }
                },
                {
                    spec3 = true,
                    pages = 1,
                    "protection",
                    "Protection",
                    {
                        pvePages = 1,
                        pvpPages = 0
                    }
                }
            }
        },
    },
    glossary = 6
}

local LCDW = LibStub("AceAddon-3.0"):NewAddon("LCDW", "AceConsole-3.0")
local icon = LibStub("LibDBIcon-1.0")
local defaults = {
    profile = {
        minimapOption = {
            hide = false
        }
    }
}

-- namespace's functions --
-- HELPERS --
function Helpers:degreesToRadians(angle)
    return angle * 0.0174533
end

function Helpers:hexadecimalToBlizzardColor(hexaNumber)
    return hexaNumber / 255
end

-- UI ELEMENTS --
function UIElements:CreateFontString2(frameName, FrameToAttach, font, fontSize, flags, text, point, relativePoint, ofsx, ofsy, r, g, b, getWidth)
    local alpha = 1
    r = not r and 255 or r
    g = not g and 255 or g
    b = not b and 255 or b

    frameName = FrameToAttach:CreateFontString(nil, "OVERLAY")
    frameName:SetFont(font and font or FRIZQT_FONT, fontSize, flags)
    frameName:SetText(text)
    frameName:SetPoint(point, FrameToAttach, relativePoint, ofsx, ofsy)
    frameName:SetTextColor(Helpers:hexadecimalToBlizzardColor(r), Helpers:hexadecimalToBlizzardColor(g), Helpers:hexadecimalToBlizzardColor(b), alpha)

    if getWidth then
        titleWidth = frameName:GetWidth()
    end
end

function UIElements:CreateTexture(textureName, frameToAttach, width, height, point, relativePoint, ofsx, ofsy, texture, getWidth)
    textureName = frameToAttach:CreateTexture(nil, "ARTWORK")
    textureName:SetSize(width, height)
    textureName:SetPoint(point, frameToAttach, relativePoint, ofsx, ofsy)
    textureName:SetTexture(texture)
    if getWidth then
        textureWidth = textureName:GetWidth()
    end
end

function  UIElements:CreateButton(textureName, frameToAttach, ofsx, link, getWidth)
    textureName = CreateFrame("BUTTON", nil, frameToAttach, BackdropTemplateMixin and "BackdropTemplate")
    textureName:SetSize(17, 17)
    textureName:SetPoint("LEFT", frameToAttach, "LEFT", ofsx, 0)
    textureName:SetBackdrop({
        bgFile = COPY_ICON_PATH
    })
    textureName:SetScript("OnClick", function()
        ChatFrame1EditBox:Show()
        ChatFrame1EditBox:SetFocus()
        ChatFrame1EditBox:SetText(link)
        ChatFrame1EditBox:HighlightText()
    end)
    if getWidth then
        textureWidth = textureName:GetWidth()
    end
end
----------------------------------------------------------
----///////////////////// END VARS /////////////////////--
----------------------------------------------------------

local function initTextureShown()
    for dungeonId, v in ipairs(dungeons) do
        textureShown["isTexture" .. dungeonId .. "Shown"] = false
    end
end

local function onEvent(self, event, arg1, ...)
    if (event == "ADDON_LOADED" and name == arg1) then
        initTextureShown()
        print(BLUE .. customAddonName .. "|r chargé ! Tapez /lcdw ou cliquez sur le bouton de la minimap pour accéder aux guides.")
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", onEvent)

----------------------------------------------------------
----/////////////// MAIN FRAME (Général) ///////////////--
----------------------------------------------------------
local LCDWFrame = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
LCDWFrame:Hide()
LCDWFrame:SetSize(MAIN_FRAME_WITH, MAIN_FRAME_HEIGHT)
LCDWFrame:SetPoint("CENTER", 0, 0)
LCDWFrame:SetMovable(true)
LCDWFrame:SetFrameStrata("DIALOG")
LCDWFrame:SetClampedToScreen(true)
LCDWFrame:SetResizable(true)
LCDWFrame:EnableMouse(true)
LCDWFrame:SetMinResize(MAIN_FRAME_WITH, MAIN_FRAME_HEIGHT)
LCDWFrame:RegisterForDrag("LeftButton")
LCDWFrame:SetScript("OnDragStart", LCDWFrame.StartMoving)
LCDWFrame:SetScript("OnDragStop", LCDWFrame.StopMovingOrSizing)

local function createBorder(frameToAttach, isACorner, borderSide, frameName, point, relativePoint, ofsx, ofsy)

    local width = (isACorner) and 100 or 256
    local height = 7
    local frameToAttach = frameToAttach

    local coord = {
        right = (isACorner) and 0.565 or 1,
        top = (isACorner) and 0.5 or 0.467,
        bottom = (isACorner) and 0.545 or 0.5
    }

    local borderSideTextureAngle = {
        top = Helpers:degreesToRadians(-180),
        left = Helpers:degreesToRadians(-90),
        right = Helpers:degreesToRadians(90),
    }

    frameName = frameToAttach:CreateTexture(nil, "BACKGROUND")
    frameName:SetTexture("Interface\\Calendar\\CALENDARFRAME_TOPANDBOTTOM")
    frameName:SetPoint(point, frameToAttach, relativePoint, ofsx, ofsy)
    frameName:SetSize(width, height)
    frameName:SetTexCoord(0, coord["right"], coord["top"], coord["bottom"])

    if borderSide ~= "bottom" then
        frameName:SetRotation(borderSideTextureAngle[borderSide])
    end
end
--------------------------------
-----//  second main frame //---
--------------------------------
-- background container frame --
LCDWFrame.backgroundContainerFrame = CreateFrame("Frame", nil, LCDWFrame, BackdropTemplateMixin and "BackdropTemplate")
LCDWFrame.backgroundContainerFrame:SetSize(LCDWFrame:GetWidth(), LCDWFrame:GetHeight())
LCDWFrame.backgroundContainerFrame:SetAllPoints()
LCDWFrame.backgroundContainerFrame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border", tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 }
})

-- title container --
--LCDWFrame.backgroundContainerFrame.titleContainerFrame = CreateFrame("Frame", nil, LCDWFrame.backgroundContainerFrame, "GlowBoxTemplate")
LCDWFrame.backgroundContainerFrame.titleContainerFrame = CreateFrame("Frame", nil, LCDWFrame.backgroundContainerFrame, BackdropTemplateMixin and "BackdropTemplate")
LCDWFrame.backgroundContainerFrame.titleContainerFrame:SetPoint("CENTER", LCDWFrame, "TOP", 0, -23)
LCDWFrame.backgroundContainerFrame.titleContainerFrame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Header"
})
-- title --
UIElements:CreateFontString2(LCDWFrame.backgroundContainerFrame.titleContainerFrame.title, LCDWFrame.backgroundContainerFrame.titleContainerFrame, MORPHEUS_FONT, 21, false, "Le codex de Willios", "TOP", "TOP", 0, -30, 255, 255, 255, true)
--LCDWFrame.backgroundContainerFrame.titleContainerFrame:SetSize(titleWidth + 50, FRAME_TITLE_CONTAINER_HEIGHT)
LCDWFrame.backgroundContainerFrame.titleContainerFrame:SetSize(512, 128)
-- scroll frame --
LCDWFrame.backgroundContainerFrame.scrollFrame = CreateFrame("ScrollFrame", nil, LCDWFrame.backgroundContainerFrame, "UIPanelScrollFrameTemplate")
-- scrollable zone size --
LCDWFrame.backgroundContainerFrame.scrollFrame:SetPoint("TOPLEFT", LCDWFrame.backgroundContainerFrame, "TOPLEFT", 4, -105)
LCDWFrame.backgroundContainerFrame.scrollFrame:SetPoint("BOTTOMRIGHT", LCDWFrame.backgroundContainerFrame, "BOTTOMRIGHT", -3, 35)
LCDWFrame.backgroundContainerFrame.scrollFrame:SetClipsChildren(true)
LCDWFrame.backgroundContainerFrame.scrollFrame:Hide()
-- close button --
LCDWFrame.backgroundContainerFrame.CloseButton = CreateFrame("Button", nil, LCDWFrame.backgroundContainerFrame, "UIPanelCloseButton")
LCDWFrame.backgroundContainerFrame.CloseButton:SetPoint("CENTER", LCDWFrame.backgroundContainerFrame, "TOPRIGHT", -20, -20)
LCDWFrame.backgroundContainerFrame.CloseButton:SetScript("OnClick", function(self, Button, Down)
    LCDWFrame:Hide()
end)
--------------------------------
------// third main frame //----
--------------------------------
-- this frame contains all the dungeons and classes thumbnails + the frames titles (guides pve / pvp) --
-- it will be easier to hide all elements when a dungeons is selected --
local allElementsContainerFrame = LCDWFrame.backgroundContainerFrame.allElementsContainerFrame

allElementsContainerFrame = CreateFrame("Frame", nil, LCDWFrame)
allElementsContainerFrame:SetSize(LCDWFrame:GetWidth(), LCDWFrame:GetHeight())
allElementsContainerFrame:SetPoint("CENTER", LCDWFrame, "CENTER")
-- create a section name container --
local function createSectionNameContainer(frameName, frameToAttach, point, relativePoint, ofsx, ofsy, title, icon, iconWidth, iconHeight, iconOfsx, iconOfsy)
    local titleIcon

    if icon == "blank" then
        titleIcon = nil
    elseif icon and icon ~= "blank" then
        titleIcon = icon
    else
        titleIcon = ARROW_TITLE_SECTION
    end
    -- dungeons section name container --
    frameName = CreateFrame("Frame", nil, frameToAttach, BackdropTemplateMixin and "BackdropTemplate")

    frameName:SetPoint(point, frameToAttach, relativePoint, ofsx, ofsy)
    frameName:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
    })
    -- icon on the left of the container --
    frameName.icon = CreateFrame("Frame", nil, frameName, BackdropTemplateMixin and "BackdropTemplate")
    frameName.icon:SetSize(iconWidth and iconWidth or 0, iconHeight and iconHeight or 0)
    frameName.icon:SetPoint("LEFT", frameName, "LEFT", iconOfsx and iconOfsx or 0, iconOfsy and iconOfsy or 0)
    frameName.icon:SetBackdrop({
        bgFile = titleIcon
    })
    -- dungeons section name --
    UIElements:CreateFontString2(frameName.sectionTitle, frameName.icon, nil, 18, nil, title, "LEFT", "RIGHT", 10, 0, nil, nil, nil, true)
    local _val1 = (ofsx ~= 0) and ofsx or 45
    frameName:SetSize(iconWidth + titleWidth + _val1, 44)
end
local buttonTexture = "Interface\\ENCOUNTERJOURNAL\\UI-EncounterJournalTextures"
local guideTypeSectionTitleWidth = 230
local guideTypeSectionTitleHeight = 45

createSectionNameContainer(allElementsContainerFrame.classesSectionNameContainer, allElementsContainerFrame, "CENTER", "CENTER", 0, 170, "Guides des classes", PVP_ICON, 17, 17, 17, 0)
-- glossary frame --
allElementsContainerFrame.glossaryFrame = CreateFrame("BUTTON", nil, allElementsContainerFrame, BackdropTemplateMixin and "BackdropTemplate")
allElementsContainerFrame.glossaryFrame:SetSize(320, 80)
allElementsContainerFrame.glossaryFrame:SetPoint("TOPLEFT", allElementsContainerFrame, "BOTTOMRIGHT", -190, 90)
allElementsContainerFrame.glossaryFrame:SetBackdrop({
    bgFile = "Interface\\ENCOUNTERJOURNAL\\loottab-item-background", insets = { left = 4, right = 40, top = 4, bottom = 4}
})
allElementsContainerFrame.glossaryFrame:SetScript("OnClick", function()
    LCDWFrame.backgroundContainerFrame:showGuide(true, "Glossaire", nil, "glossary", "glossary")
end)

allElementsContainerFrame.glossaryFrame.icon = allElementsContainerFrame.glossaryFrame:CreateTexture(nil, "ARTWORK")
allElementsContainerFrame.glossaryFrame.icon:SetSize(45, 45)
allElementsContainerFrame.glossaryFrame.icon:SetPoint("TOPLEFT", allElementsContainerFrame.glossaryFrame, "TOPLEFT", 13, -8)
allElementsContainerFrame.glossaryFrame.icon:SetTexture(QUESTIONMARK_PATH)
UIElements:CreateFontString2(allElementsContainerFrame.glossaryFrame.title, allElementsContainerFrame.glossaryFrame, nil, 18, nil, "Glossaire", "TOPLEFT", "TOPLEFT", 70, -20)
--------------------------------
--// third main frame prime //--
--------------------------------
local function openContextMenu(pageNumber, parentFrame, hasNestedMenu, id)
    local openContextMenuButton = parentFrame.titleContainer.openContextMenuButton
    openContextMenuButton.dropDown = CreateFrame("Frame", "GlossaryMenu", openContextMenuButton, "UIDropDownMenuTemplate")

    UIDropDownMenu_Initialize(openContextMenuButton.dropDown, function(self, level, menuList)
        local info = UIDropDownMenu_CreateInfo()
        local scrollFrame = LCDWFrame.backgroundContainerFrame.scrollFrame
        local test
        -- first lvl menu --
        if (level or 1) == 1 then
            info.isTitle = 1
            info.text = "Sommaire"
            info.notCheckable = 1
            UIDropDownMenu_AddButton(info, level)

            info.disabled = nil
            info.isTitle = nil

            if not hasNestedMenu then
                for i = 1, pageNumber do
                    info.func = function()
                        scrollFrame:SetVerticalScroll((i - 1) * (GUIDE_HEIGHT + 20))
                        isContextMenuOpen = false
                    end
                    info.text, info.checked = "Page " .. i, false
                    info.hasArrow = false
                    info.notCheckable = 1
                    UIDropDownMenu_AddButton(info, level)
                end
            else
                info.text, info.hasArrow, info.menuList = "Pve", true, "pve"
                UIDropDownMenu_AddButton(info, level)
                info.text, info.hasArrow, info.menuList = "Pvp", true, "pvp"
                UIDropDownMenu_AddButton(info, level)
            end

            -- Close menu item
            info.hasArrow = nil
            info.value = nil
            info.notCheckable = 1
            info.text = CLOSE
            info.func = function()
                CloseDropDownMenus()
                isContextMenuOpen = false
            end
            UIDropDownMenu_AddButton(info, level)
        elseif menuList == "pve" or menuList == "pvp" then
            local mode = menuList == "pve" and "pve" or "pvp"
            -- loop through all the specs --
            for k, v in ipairs(foldersItemsNb["pvp"][id][1]) do
                -- get the specs names --
                info.text, info.hasArrow = foldersItemsNb["pvp"][id][1][k][2], true
                info.notCheckable, info.menuList = 1, foldersItemsNb["pvp"][id][1][k][1] .. mode
                test = foldersItemsNb["pvp"][id][1][k][1]
                UIDropDownMenu_AddButton(info, level)
            end
        -- @todo find a way to refactor this --
        -- first spec --
        elseif menuList == foldersItemsNb["pvp"][id][1][1][1] .. "pve" then
            if foldersItemsNb["pvp"][id][1][1][3]["pvePages"] == 0 then
                info.text, info.notCheckable, info.disabled = "Guide à venir", 1, true
                UIDropDownMenu_AddButton(info, level)
            else
                for i = 1, foldersItemsNb["pvp"][id][1][1][3]["pvePages"] do
                    info.text = "Page " .. i
                    info.func = function()
                        scrollFrame:SetVerticalScroll((i - 1) * (GUIDE_HEIGHT + 20))
                        isContextMenuOpen = false
                    end
                    UIDropDownMenu_AddButton(info, level)
                end
            end
        elseif menuList == foldersItemsNb["pvp"][id][1][1][1] .. "pvp" then
            if foldersItemsNb["pvp"][id][1][1][3]["pvpPages"] == 0 then
                info.text, info.notCheckable, info.disabled = "Guide à venir", 1, true
                UIDropDownMenu_AddButton(info, level)
            else
                for i = 1, foldersItemsNb["pvp"][id][1][1][3]["pvpPages"] do
                    info.text = "Page " .. i
                    UIDropDownMenu_AddButton(info, level)
                end
            end
        -- second spec --
        elseif menuList == foldersItemsNb["pvp"][id][1][2][1] .. "pve" then
            if foldersItemsNb["pvp"][id][1][2][3]["pvePages"] == 0 then
                info.text, info.notCheckable, info.disabled = "Guide à venir", 1, true
                UIDropDownMenu_AddButton(info, level)
            else
                for i = 1, foldersItemsNb["pvp"][id][1][2][3]["pvePages"] do
                    info.text = "Page " .. i
                    UIDropDownMenu_AddButton(info, level)
                end
            end
        elseif menuList == foldersItemsNb["pvp"][id][1][2][1] .. "pvp" then
            if foldersItemsNb["pvp"][id][1][2][3]["pvpPages"] == 0 then
                info.text, info.notCheckable, info.disabled = "Guide à venir", 1, true
                UIDropDownMenu_AddButton(info, level)
            else
                for i = 1, foldersItemsNb["pvp"][id][1][2][3]["pvpPages"] do
                    info.text = "Page " .. i
                    UIDropDownMenu_AddButton(info, level)
                end
            end
        -- third spec --
        elseif menuList == foldersItemsNb["pvp"][id][1][3][1] .. "pve" then
            if foldersItemsNb["pvp"][id][1][3][3]["pvePages"] == 0 then
                info.text, info.notCheckable, info.disabled = "Guide à venir", 1, true
                UIDropDownMenu_AddButton(info, level)
            else
                for i = 1, foldersItemsNb["pvp"][id][1][3][3]["pvePages"] do
                    info.text = "Page " .. i
                    UIDropDownMenu_AddButton(info, level)
                end
            end
        elseif menuList == foldersItemsNb["pvp"][id][1][3][1] .. "pvp" then
            if foldersItemsNb["pvp"][id][1][3][3]["pvpPages"] == 0 then
                info.text, info.notCheckable, info.disabled = "Guide à venir", 1, true
                UIDropDownMenu_AddButton(info, level)
            else
                for i = 1, foldersItemsNb["pvp"][id][1][3][3]["pvpPages"] do
                    info.text = "Page " .. i
                    UIDropDownMenu_AddButton(info, level)
                end
            end
        -- fourth spec --
        elseif menuList == foldersItemsNb["pvp"][id][1][4][1] .. "pve" then
            if foldersItemsNb["pvp"][id][1][4][3]["pvePages"] == 0 then
                info.text, info.notCheckable, info.disabled = "Guide à venir", 1, true
                UIDropDownMenu_AddButton(info, level)
            else
                for i = 1, foldersItemsNb["pvp"][id][1][4][3]["pvePages"] do
                    info.text = "Page " .. i
                    UIDropDownMenu_AddButton(info, level)
                end
            end
        elseif menuList == foldersItemsNb["pvp"][id][1][4][1] .. "pvp" then
            if foldersItemsNb["pvp"][id][1][4][3]["pvpPages"] == 0 then
                info.text, info.notCheckable, info.disabled = "Guide à venir", 1, true
                UIDropDownMenu_AddButton(info, level)
            else
                for i = 1, foldersItemsNb["pvp"][id][1][4][3]["pvpPages"] do
                    info.text = "Page " .. i
                    UIDropDownMenu_AddButton(info, level)
                end
            end
        end
    end, "MENU")
    ToggleDropDownMenu(1, nil, openContextMenuButton.dropDown, openContextMenuButton, 3, 5)
end

-- this function creates the frame displayed when a dungeon is selected
function LCDWFrame.backgroundContainerFrame:showGuide(icon, name, id, thumbnailCategory, guideType)
    local iconWidth = 30
    local iconHeight = 30
    local scrollFrame = LCDWFrame.backgroundContainerFrame.scrollFrame
    local titleAndGuideContainerFrame = LCDWFrame.backgroundContainerFrame.titleAndGuideContainerFrame
    local mainFrameWidth = 1024
    local mainFrameHeight = mainFrameWidth / INITIAL_RATIO

    LCDWFrame:SetSize(mainFrameWidth, mainFrameHeight)
    isGuideSelected = true

    -- everytime a guide is loaded, reset the scroll --
    if scrollFrame:GetVerticalScroll() > 0 then
        scrollFrame:SetVerticalScroll(0)
    end

    -- hide all the homepage elements --
    allElementsContainerFrame:Hide()
    -- show the scroll frame --
    LCDWFrame.backgroundContainerFrame.scrollFrame:Show()
    -- parent frame that appears after selecting a guide, it contains the title and the guide selected --
    titleAndGuideContainerFrame = CreateFrame("Frame", nil, LCDWFrame.backgroundContainerFrame)
    titleAndGuideContainerFrame:SetSize(LCDWFrame:GetWidth(), LCDWFrame:GetHeight())
    titleAndGuideContainerFrame:SetPoint("CENTER", LCDWFrame.backgroundContainerFrame, "CENTER")

    -- reset function which does hide everyframe but the homepage frame --
    function titleAndGuideContainerFrame:resetAll()
        --MAIN_FRAME_WITH = 600
        --MAIN_FRAME_HEIGHT = 500
        LCDWFrame:SetSize(600, 500)
        isContextMenuOpen = false
        -- hide the guide texture
        if isGuideTextureCreated then
            if titleAndGuideContainerFrame.guideParentFrame:IsShown() then
                titleAndGuideContainerFrame.guideParentFrame:Hide()
            end
        end
        -- hide the scroll frame --
        if LCDWFrame.backgroundContainerFrame.scrollFrame:IsShown() then
            LCDWFrame.backgroundContainerFrame.scrollFrame:Hide()
        end
        -- hide guide currently displayed --
        if isGuideSelected then
            if titleAndGuideContainerFrame:IsShown() then
                titleAndGuideContainerFrame:Hide()
                isGuideSelected = false
            end
        end
        -- show the homepage --
        if not allElementsContainerFrame:IsShown() then
            allElementsContainerFrame:Show()
        end
    end
    -- reset button --
    titleAndGuideContainerFrame.resetButton = CreateFrame("Button", nil, titleAndGuideContainerFrame, "UIPanelButtonTemplate")
    titleAndGuideContainerFrame.resetButton:SetSize(110, 35)
    titleAndGuideContainerFrame.resetButton:SetPoint("TOP", titleAndGuideContainerFrame, "TOP", 0, -33)
    titleAndGuideContainerFrame.resetButton:SetText("Accueil")
    titleAndGuideContainerFrame.resetButton:SetScript("OnClick", function()
        titleAndGuideContainerFrame:resetAll()
    end)
    -- title and icon container --
    titleAndGuideContainerFrame.titleContainer = CreateFrame("Frame", nil, titleAndGuideContainerFrame, BackdropTemplateMixin and "BackdropTemplate")
    titleAndGuideContainerFrame.titleContainer:SetPoint("TOPLEFT", titleAndGuideContainerFrame, "TOPLEFT", 80, -15)
    -- icon --
    if icon then
        titleAndGuideContainerFrame.titleContainer.icon = titleAndGuideContainerFrame.titleContainer:CreateTexture(nil, "ARTWORK")
        titleAndGuideContainerFrame.titleContainer.icon:SetPoint("LEFT", titleAndGuideContainerFrame.titleContainer, "LEFT", 10, 0)
        if thumbnailCategory == "glossary" then
            titleAndGuideContainerFrame.titleContainer.icon:SetTexture(QUESTIONMARK_PATH)
        elseif thumbnailCategory == "class" then
            titleAndGuideContainerFrame.titleContainer.icon:SetTexture(classes[id][ICON_COL])
        elseif thumbnailCategory == "raid" then
            titleAndGuideContainerFrame.titleContainer.icon:SetTexture(raids[id][ICON_COL])
        else
            titleAndGuideContainerFrame.titleContainer.icon:SetTexture(dungeons[id][DUNGEON_THUMBNAIL_COL])
        end
        titleAndGuideContainerFrame.titleContainer.icon:SetSize(iconWidth, 30)
    end
    -- title --
    UIElements:CreateFontString2(titleAndGuideContainerFrame.titleContainer.title, titleAndGuideContainerFrame.titleContainer, nil, 21, nil, name, "LEFT", "LEFT", iconWidth + 20, 0, nil, nil, nil, true)
    -- open context menu icon --
    titleAndGuideContainerFrame.titleContainer.openContextMenuButton = CreateFrame("Button", nil, titleAndGuideContainerFrame.titleContainer, BackdropTemplateMixin and "BackdropTemplate")
    titleAndGuideContainerFrame.titleContainer.openContextMenuButton:SetSize(35, 35)
    titleAndGuideContainerFrame.titleContainer.openContextMenuButton:SetPoint("LEFT", titleAndGuideContainerFrame.titleContainer, "LEFT", titleWidth + iconWidth + 20, -1)
    titleAndGuideContainerFrame.titleContainer.openContextMenuButton:SetBackdrop({
        bgFile = "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up",
        insets = { left = 4, right = 4, top = 4, bottom = 4 }
    })
    -- open context menu icon hover --
    titleAndGuideContainerFrame.titleContainer.openContextMenuButton.Hover = titleAndGuideContainerFrame.titleContainer.openContextMenuButton:CreateTexture(nil, "BACKGROUND")
    titleAndGuideContainerFrame.titleContainer.openContextMenuButton.Hover:SetTexture("Interface\\Buttons\\CheckButtonGlow")
    titleAndGuideContainerFrame.titleContainer.openContextMenuButton.Hover:SetAllPoints(titleAndGuideContainerFrame.titleContainer.openContextMenuButton)
    titleAndGuideContainerFrame.titleContainer.openContextMenuButton.Hover:SetAlpha(0)
    titleAndGuideContainerFrame.titleContainer.openContextMenuButton:SetScript("OnEnter", function()
        titleAndGuideContainerFrame.titleContainer.openContextMenuButton.Hover:SetAlpha(1)
    end);
    titleAndGuideContainerFrame.titleContainer.openContextMenuButton:SetScript("OnLeave", function()
        titleAndGuideContainerFrame.titleContainer.openContextMenuButton.Hover:SetAlpha(0)
    end);
    -- click handler --
    titleAndGuideContainerFrame.titleContainer.openContextMenuButton:SetScript("OnClick", function()
        if isContextMenuOpen then
            titleAndGuideContainerFrame.titleContainer.openContextMenuButton.dropDown:Hide()
            isContextMenuOpen = false
        else
            isContextMenuOpen = true
            if guideType == "pveD" then
                openContextMenu(foldersItemsNb[guideType][id]["d" .. id], titleAndGuideContainerFrame, false, id)
            elseif guideType == "pveR" then
                openContextMenu(foldersItemsNb[guideType][id]["r" .. id], titleAndGuideContainerFrame, false, id)
            elseif guideType == "pvp" then
                openContextMenu(foldersItemsNb[guideType][id]["c" .. id], titleAndGuideContainerFrame, true, id)
            else
                openContextMenu(foldersItemsNb[guideType], titleAndGuideContainerFrame, false, id)
            end
        end
    end)

    local arrowIconWidth = titleAndGuideContainerFrame.titleContainer.openContextMenuButton:GetWidth()
    -- title container size --
    titleAndGuideContainerFrame.titleContainer:SetSize(titleWidth + iconWidth + 25 + arrowIconWidth, 50)
    -- classes specs parent frame --
    if guideType == "pvp" then
        local buttonTexture = "Interface\\ENCOUNTERJOURNAL\\UI-EncounterJournalTextures"
        local scrollFrame = LCDWFrame.backgroundContainerFrame.scrollFrame

        titleAndGuideContainerFrame.specsParentFrame = CreateFrame("Frame", nil, titleAndGuideContainerFrame, BackdropTemplateMixin and "BackdropTemplate")
        titleAndGuideContainerFrame.specsParentFrame:SetSize(320, 70)
        titleAndGuideContainerFrame.specsParentFrame:SetPoint("TOPRIGHT", titleAndGuideContainerFrame, "TOPRIGHT", -50, 0)
        --titleAndGuideContainerFrame.specsParentFrame:SetBackdrop({
        --    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark"
        --})
    end
    -- guide frame --
    titleAndGuideContainerFrame.guideParentFrame = CreateFrame("Frame", nil, LCDWFrame.backgroundContainerFrame.scrollFrame)
    titleAndGuideContainerFrame.guideParentFrame:SetSize(LCDWFrame:GetWidth(), LCDWFrame:GetHeight() - 100)
    titleAndGuideContainerFrame.guideParentFrame:SetPoint("BOTTOM", titleAndGuideContainerFrame, "BOTTOM")
    -- core image --
    LCDWFrame.backgroundContainerFrame:generateGuides(guideType, id, titleAndGuideContainerFrame)

    isGuideTextureCreated = true
    -- set the scroll child to be able to scroll --
    LCDWFrame.backgroundContainerFrame.scrollFrame:SetScrollChild(titleAndGuideContainerFrame.guideParentFrame)
    LCDWFrame.backgroundContainerFrame.scrollFrame.ScrollBar:ClearAllPoints()
    -- scrollbar element size --
    LCDWFrame.backgroundContainerFrame.scrollFrame.ScrollBar:SetPoint("TOPLEFT", LCDWFrame.backgroundContainerFrame.scrollFrame, "TOPRIGHT", -12, -15)
    LCDWFrame.backgroundContainerFrame.scrollFrame.ScrollBar:SetPoint("BOTTOMRIGHT", LCDWFrame.backgroundContainerFrame.scrollFrame, "BOTTOMRIGHT", -7, 18)
end

function LCDWFrame.backgroundContainerFrame:generateGuides(guideType, id, frame)
    if guideType == "pveD" then
        for i = 1, foldersItemsNb[guideType][id]["d" .. id] do
            pveDGuidesTextures["pveTexture" .. i] = frame.guideParentFrame:CreateTexture(nil, "ARTWORK")
            if i == 1 then
                pveDGuidesTextures["pveTexture" .. i]:SetPoint("TOP", frame.guideParentFrame, "TOP")
            else
                pveDGuidesTextures["pveTexture" .. i]:SetPoint("TOP", pveDGuidesTextures["pveTexture" .. i - 1], "BOTTOM", 0, -20)
            end
            pveDGuidesTextures["pveTexture" .. i]:SetSize(GUIDE_WIDTH, GUIDE_HEIGHT)
            pveDGuidesTextures["pveTexture" .. i]:SetTexture(DUNGEONS_FOLDER_PATH .. "d" .. id .. "\\" .. i)
        end
    elseif guideType == "pveR" then
        for i = 1, foldersItemsNb[guideType][id]["r" .. id] do
            pveRGuidesTextures["pvpTexture" .. i] = frame.guideParentFrame:CreateTexture(nil, "ARTWORK")
            -- first texture at the top of the guide parent frame --
            if i == 1 then
                pveRGuidesTextures["pvpTexture" .. i]:SetPoint("TOP", frame.guideParentFrame, "TOP")
                -- and the rest under 20 px from one another --
            else
                pveRGuidesTextures["pvpTexture" .. i]:SetPoint("TOP", pveRGuidesTextures["pvpTexture" .. i - 1], "BOTTOM", 0, -20)
            end
            pveRGuidesTextures["pvpTexture" .. i]:SetSize(GUIDE_WIDTH, GUIDE_HEIGHT)
            pveRGuidesTextures["pvpTexture" .. i]:SetTexture(RAIDS_FOLDER_PATH .. "r" .. id .. "\\" .. i)
        end
    elseif guideType == "pvp" then
        local iterator
        local lastIterator
        local nbSpecs
        -- from 1 to the number of specs
        for k, v in ipairs(foldersItemsNb[guideType][id][1]) do
            nbSpecs = foldersItemsNb[guideType][id][1]

            if nbSpecs == 2 then
                if k == 2 then
                    iterator = foldersItemsNb[guideType][id][1][k - 1]["pages"]
                else
                    iterator = 0
                end
            elseif nbSpecs == 3 then
                if k == 2 then
                    iterator = foldersItemsNb[guideType][id][1][k - 1]["pages"]
                    lastIterator = iterator
                elseif k == 3 then
                    iterator = foldersItemsNb[guideType][id][1][k - 1]["pages"] + lastIterator
                else
                    iterator = 0
                end
            else
                if k == 2 then
                    iterator = foldersItemsNb[guideType][id][1][k - 1]["pages"]
                    lastIterator = iterator
                elseif k == 3 then
                    iterator = foldersItemsNb[guideType][id][1][k - 1]["pages"] + lastIterator
                    lastIterator = iterator
                elseif k == 4 then
                    iterator = foldersItemsNb[guideType][id][1][k - 1]["pages"] + lastIterator
                else
                    iterator = 0
                end
            end
            -- form 1 to the number of guide pages for each spec
            for i = 1, foldersItemsNb[guideType][id][1][k]["pages"] do
                pvpGuidesTextures["pvpTexture" .. i + iterator] = frame.guideParentFrame:CreateTexture(nil, "ARTWORK")
                if k == 1 then
                    if i == 1 then
                        pvpGuidesTextures["pvpTexture" .. i]:SetPoint("TOP", frame.guideParentFrame, "TOP")
                    else
                        pvpGuidesTextures["pvpTexture" .. i ]:SetPoint("TOP", pvpGuidesTextures["pvpTexture" .. i - 1], "BOTTOM", 0, -20)
                    end
                else
                    pvpGuidesTextures["pvpTexture" .. i + iterator]:SetPoint("TOP", pvpGuidesTextures["pvpTexture" .. i  + iterator - 1], "BOTTOM", 0, -20)
                end
                pvpGuidesTextures["pvpTexture" .. i + iterator]:SetSize(GUIDE_WIDTH, GUIDE_HEIGHT)
                pvpGuidesTextures["pvpTexture" .. i + iterator]:SetTexture(PVP_FOLDER_PATH .. "c" .. id .. "\\".. foldersItemsNb["pvp"][id][1][k][1] .."\\" .. i)
            end
        end
    else
        for i = 1, foldersItemsNb[guideType] do
            glossaryTextures["glossaryTexture" .. i] = frame.guideParentFrame:CreateTexture(nil, "ARTWORK")
            if i == 1 then
                glossaryTextures["glossaryTexture" .. i]:SetPoint("TOP", frame.guideParentFrame, "TOP")
            else
                glossaryTextures["glossaryTexture" .. i]:SetPoint("TOP", glossaryTextures["glossaryTexture" .. i - 1], "BOTTOM", 0, -20)
            end
            glossaryTextures["glossaryTexture" .. i]:SetSize(GUIDE_WIDTH, GUIDE_HEIGHT)
            glossaryTextures["glossaryTexture" .. i]:SetTexture(GLOSSARY_FOLDER_PATH .. "glossary" .. i)
        end
    end
end

-- display all the classes frames --
local function generateClassesFrames()

    local FRAME_WIDTH = 54
    local FRAME_HEIGHT = 54
    local SPACE_BETWEEN_ITEMS = 60
    local ROW_MAX_CLASSES_ITEMS = 4
    local FIRST_ROW_OFSY = 70
    local SECOND_ROW_OFSY = FIRST_ROW_OFSY - 90
    local THIRD_ROW_OFSY = SECOND_ROW_OFSY - 90
    local FIRST_LEFT_SPACE = 100

    local buttonTexture = "Interface\\ENCOUNTERJOURNAL\\UI-EncounterJournalTextures"

    for classesK, classesV in ipairs(classes) do

        classesFrames["classeFrame" .. classesK] = CreateFrame("Button", nil, allElementsContainerFrame, BackdropTemplateMixin and "BackdropTemplate")
        classesFrames["classeFrame" .. classesK]:SetSize(FRAME_WIDTH, FRAME_HEIGHT)

        -- not available frame --
        allElementsContainerFrame.notAvailableFrame = CreateFrame("Frame", nil, classesFrames["classeFrame" .. classesK], BackdropTemplateMixin and "BackdropTemplate")
        allElementsContainerFrame.notAvailableFrame:SetSize(FRAME_WIDTH + 3, FRAME_HEIGHT + 4)
        allElementsContainerFrame.notAvailableFrame:SetBackdrop({
            bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark"
        })

        -- dungeons thumbnails borders --
        classesFrames["classeFrame" .. classesK].border = CreateFrame("Button", nil, classesFrames["classeFrame" .. classesK])

        -- If 4 dungeons frame are displayed then ddd a new line --
        -- third second and first line --
        if classesK > ROW_MAX_CLASSES_ITEMS * 2 then
            classesFrames["classeFrame" .. classesK]:SetPoint("LEFT", allElementsContainerFrame, "LEFT", FIRST_LEFT_SPACE + ((FRAME_WIDTH * (classesK - 9)) + (SPACE_BETWEEN_ITEMS * (classesK - 9))), THIRD_ROW_OFSY)
            if not foldersItemsNb["pvp"][classesK]["atleastOneGuideSpecAvailable"] then
                allElementsContainerFrame.notAvailableFrame:SetPoint("LEFT", allElementsContainerFrame, "LEFT", FIRST_LEFT_SPACE + ((FRAME_WIDTH * (classesK - 9)) + (SPACE_BETWEEN_ITEMS * (classesK - 9))) - 2, THIRD_ROW_OFSY + 1)
            end
        elseif classesK > ROW_MAX_CLASSES_ITEMS then
            classesFrames["classeFrame" .. classesK]:SetPoint("LEFT", allElementsContainerFrame, "LEFT", FIRST_LEFT_SPACE + ((FRAME_WIDTH * (classesK - 5)) + (SPACE_BETWEEN_ITEMS * (classesK - 5))), SECOND_ROW_OFSY)
            if not foldersItemsNb["pvp"][classesK]["atleastOneGuideSpecAvailable"] then
                allElementsContainerFrame.notAvailableFrame:SetPoint("LEFT", allElementsContainerFrame, "LEFT", FIRST_LEFT_SPACE + ((FRAME_WIDTH * (classesK - 5)) + (SPACE_BETWEEN_ITEMS * (classesK - 5))) - 2, SECOND_ROW_OFSY + 1)
            end
        else
            classesFrames["classeFrame" .. classesK]:SetPoint("LEFT", allElementsContainerFrame, "LEFT", FIRST_LEFT_SPACE + ((FRAME_WIDTH * (classesK - 1)) + (SPACE_BETWEEN_ITEMS * (classesK - 1))), FIRST_ROW_OFSY)
            if not foldersItemsNb["pvp"][classesK]["atleastOneGuideSpecAvailable"] then
            allElementsContainerFrame.notAvailableFrame:SetPoint("LEFT", allElementsContainerFrame, "LEFT", FIRST_LEFT_SPACE + ((FRAME_WIDTH * (classesK - 1)) + (SPACE_BETWEEN_ITEMS * (classesK - 1))) - 2, FIRST_ROW_OFSY + 1)
            end
        end

        classesFrames["classeFrame" .. classesK]:SetBackdrop({
            bgFile = classes[classesK][ICON_COL],
        })

        -- to not be able to click on the not available frame --
        allElementsContainerFrame.notAvailableFrame:SetScript("OnEnter", function()
            return
        end)

        classesFrames["classeFrame" .. classesK].border:SetPoint("TOPLEFT", classesFrames["classeFrame" .. classesK], "TOPLEFT", -2, 2.5)
        classesFrames["classeFrame" .. classesK].border:SetSize(FRAME_WIDTH + 1.5, FRAME_HEIGHT + 3)
        classesFrames["classeFrame" .. classesK].border:SetNormalTexture(buttonTexture)
        classesFrames["classeFrame" .. classesK].border:SetHighlightTexture(buttonTexture)
        classesFrames["classeFrame" .. classesK].border:SetPushedTexture(buttonTexture)
        classesFrames["classeFrame" .. classesK].border:GetNormalTexture():SetTexCoord(0, 0.34, 0.428, 0.522)
        classesFrames["classeFrame" .. classesK].border:GetHighlightTexture():SetTexCoord(0.345, 0.68, 0.333, 0.425)
        classesFrames["classeFrame" .. classesK].border:GetPushedTexture():SetTexCoord(0, 0.34, 0.332, 0.425)
        classesFrames["classeFrame" .. classesK].border:SetScript("OnClick", function(self, button)
            LCDWFrame.backgroundContainerFrame:showGuide(true, classes[classesK][NAME_COL], classesK, "class", "pvp")
        end)

    end
end

generateClassesFrames()
----------------------------------------------------------
----///////////// END MAIN FRAME (Général) /////////////--
----------------------------------------------------------

----------------------------------------------------------
---------///////////// MINIMAP ICON /////////////---------
----------------------------------------------------------
local LCDWLDB = LibStub("LibDataBroker-1.1"):NewDataObject("LCDWIcon", {
    type = "global",
    icon = MINIMAP_ICON_PATH,
    OnClick = function(clickedframe, button)
        if button == "RightButton" then

        elseif button == "LeftButton" then
            if LCDWFrame:IsShown() then
                LCDWFrame:Hide()
            else
                LCDWFrame:Show()
            end
        end
    end,
    OnTooltipShow = function(tooltip)
        if tooltip and tooltip.AddLine then
            tooltip:AddLine(BLUE .. customAddonName .. " - " .. addonVersion)
            tooltip:AddLine(YELLOW .. "Click gauche" .. " " .. WHITE
                    .. "pour ouvrir/fermer la fenêtre de guides")
            tooltip:AddLine(YELLOW .. "Click droit" .. " " .. WHITE
                    .. "pour ouvrir/fermer la configuration")
        end
    end
})

function LCDW:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("LCDWDB", defaults)
    icon:Register("LCDWIcon", LCDWLDB, self.db.profile.minimapOption)
end
----------------------------------------------------------
-------///////////// END MINIMAP ICON /////////////-------
----------------------------------------------------------

----------------------------------------------------------
-------///////////// SLASH COMMANDS /////////////---------
----------------------------------------------------------
SLASH_LECODEXDEWILLIOS1 = '/lcdw'
SlashCmdList["LECODEXDEWILLIOS"] = function()
    LCDWFrame:Show()
end

SLASH_RELOADUI1 = "/rl"
SlashCmdList.RELOADUI = ReloadUI