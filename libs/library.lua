-- CATACLYSM LIBRARY

bbLib = {}
--TODO: Alpha, Beta, and Raid Ready Alert

function bbLib.bossMods()
	-- Darkmoon Faerie Cannon
	--if select(7, UnitBuffID("player", 102116)) 
	  --and select(7, UnitBuffID("player", 102116)) - GetTime() < 1.07 then 
		--CancelUnitBuff("player", "Magic Wings") 
	--end
	
	-- Raid Boss Checks
	if UnitExists("boss1") then
		for i = 1,4 do
			local bossCheck = "boss"..i
			if UnitExists(bossCheck) then
				local npcID = tonumber(UnitGUID(bossCheck):sub(6, 10), 16)
				--local bossCasting,_,_,_,_,castEnd = UnitCastingInfo(bossCheck)
				if npcID == 71515 then  -- SoO: General Nazgrim
					--if UnitBuffID("target", 71) then
						--SpellStopCasting()
						--return true
					--end
				end
			end
		end
	end
	return false
end

function bbLib.stackCheck(spell, otherTank, stacks)
	local debuffName, _, _, debuffCount = UnitDebuff(otherTank, spell)
	if debuffName and debuffCount >= stacks and not UnitDebuff("player", spell) then
		return true
	end 
	return false
end

function bbLib.bossTaunt()
	-- TODO: May be double taunting if we dont get a stack before taunt comes back up.
	-- Thanks to Rubim for the idea!
	-- Make sure we're a tank first and we're in a raid
	if UnitGroupRolesAssigned("player") == "TANK" and IsInRaid() then
		local otherTank
		for i = 1, GetNumGroupMembers() do
			local other = "raid" .. i
			if not otherTank and not UnitIsUnit("player", other) and UnitGroupRolesAssigned(other) == "TANK" then
				otherTank = other
			end
		end
		if otherTank and not UnitIsDeadOrGhost(otherTank) then
			for j = 1, 4 do
				local bossID = "boss" .. j
				local boss = UnitID(bossID) -- /script print(UnitID("target"))
				
				-- START Siege of Orgrimmar
				if     boss == 71543 then -- Immersus
					if bbLib.stackCheck("Corrosive Blast", otherTank, 1) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end 
				elseif boss == 72276 then -- Norushen
					if bbLib.stackCheck("Self Doubt", otherTank, 3) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end 
				elseif boss == 71734 then -- Sha of Pride
					if bbLib.stackCheck("Wounded Pride", otherTank, 1) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 72249 then -- Galakras
					if bbLib.stackCheck("Flames of Galakrond", otherTank, 3) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end  
				elseif boss == 71466 then -- Iron Juggernaut
					if bbLib.stackCheck("Ignite Armor", otherTank, 2) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end  
				elseif boss == 71859 then -- Kor'kron Dark Shaman -- Earthbreaker Haromm
					if bbLib.stackCheck("Froststorm Strike", otherTank, 5) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end   
				elseif boss == 71515 then -- General Nazgrim
					if bbLib.stackCheck("Sundering Blow", otherTank, 3) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71454 then -- Malkorok
					if bbLib.stackCheck("Fatal Strike", otherTank, 12) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71529 then -- Thok the Bloodsthirsty
					if bbLib.stackCheck("Panic", otherTank, 3)
					  or bbLib.stackCheck("Acid Breath", otherTank, 3) 
					  or bbLib.stackCheck("Freezing Breath", otherTank, 3)
					  or bbLib.stackCheck("Scorching Breath", otherTank, 3) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71504 then -- Siegecrafter Blackfuse
					if bbLib.stackCheck("Electrostatic Charge", otherTank, 4) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 71865 then -- Garrosh Hellscream
					if bbLib.stackCheck("Gripping Despair", otherTank, 3)
					  or bbLib.stackCheck("Empowered Gripping Despair", otherTank, 3) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				end
				-- END Siege of Orgrimmar
				
				-- START Throne of Thunder
				if boss == 69465 then -- Jin’rokh the Breaker
					local debuffName, _, _, debuffCount = UnitDebuff(otherTank, "Static Wound")
					local debuffName2, _, _, debuffCount2 = UnitDebuff("player", "Static Wound")
					if debuffName 
					  and ( not debuffName2 or debuffCount > debuffCount2) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68476 then -- Horridon
					if bbLib.stackCheck("Triple Puncture", otherTank, 9) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 69131 then -- Council of Elders - Frost King Malakk
					if bbLib.stackCheck("Frigid Assault", otherTank, 13) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end				
				elseif boss == 69712 then -- Ji-Kun
					if bbLib.stackCheck("Talon Rake", otherTank, 2) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68036 then -- Durumu the Forgotten
					if bbLib.stackCheck("Hard Stare", otherTank, 5) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 69017 then -- Primordius
					if bbLib.stackCheck("Malformed Blood", otherTank, 8) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 69699 then -- Dark Animus - Massive Anima Golem -- TODO: May not show up in boss frames.
					if bbLib.stackCheck("Explosive Slam", otherTank, 5) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68078 then -- Iron Qon -- TODO: check if boss id stays same during encounter
					if bbLib.stackCheck("Impale", otherTank, 4) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68905 then -- Twin Consorts - Lu’lin
					if bbLib.stackCheck("Beast of Nightmare", otherTank, 1) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68904 then -- Twin Consorts - Suen
					if bbLib.stackCheck("Fan of Flames", otherTank, 3) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end
				elseif boss == 68397 then -- Lei Shen
					if bbLib.stackCheck("Decapitate", otherTank, 1) 
					  or bbLib.stackCheck("Fusion Slash", otherTank, 1) 
					  or bbLib.stackCheck("Overwhelming Power", otherTank, 12) then
						ProbablyEngine.dsl.parsedTarget = bossID
						return true
					end 
				end
				-- END Throne of Thunder
			end
		end
	end
	return false
end

function bbLib.useAgiPot()
	-- 58145 = Potion of the Tol'vir
	if GetItemCount(58145) > 1 
	  and GetItemCooldown(58145) == 0 
	  and ProbablyEngine.condition["player.hashero"] then 
		return true
	end
	return false
end

function bbLib.useIntPot()
	-- 114757 = Potion of the Jade Serpent
	if GetItemCount(114757) > 1 
	  and GetItemCooldown(114757) == 0 then 
		return true
	end
	return false
end

function bbLib.useManaGem()
	-- 36799 = Mana Gem
	if GetItemCount(36799) > 0 
	  and GetItemCooldown(36799) == 0 then 
		return true
	end
	return false
end

function bbLib.isMounted()
	if IsMounted() then
		return true
	end
	return false
end

function bbLib.conjureManaGem()
	-- 36799 = Mana Gem
	if GetItemCount(36799) < 1 then -- TODO: make to work with charges
		return true
	end
	return false
end

bbLib.badMisdirectTargets = { "Kor'kron Warshaman" }
function bbLib.canMisdirect(target)
	local targetName = UnitName(target)
	for _,v in pairs(bbLib.badMisdirectTargets) do
		if v == targetName then
			return false
		end
	end
	return true
end

-- Thanks to PCMD
bbLib.darkSimSpells = { "Froststorm Bolt", "Arcane Shock", "Rage of the Empress", "Chain Lightning", "Hex", "Mind Control", "Cyclone", "Polymorph", "Pyroblast", "Tranquility", "Divine Hymn", "Hymn of Hope", "Ring of Frost", "Entangling Roots" }
function bbLib.canDarkSimulacrum(unit)
	for _,v in pairs(bbLib.darkSimSpells) do
		if ProbablyEngine.condition["casting"](unit, v) then 
			return true
		end
	end
	return false
end

function bbLib.isTargetingMe(target)
	if UnitExists(target) then
		return UnitGUID(target.."target") == UnitGUID("player")
	end
	return false
end

function bbLib.highThreatOnPlayerTarget(target)
	if UnitExists(target) and UnitExists("target") then
		local threat = UnitThreatSituation(target,"target")
		if threat and threat > 0 then --not tanking, higher threat than tank.
			return true
		end
	end
	return false
end

function bbLib.useHealthPot()
	-- 76098 = Master Health Potion
	if GetItemCount(76097) > 1 
	 and GetItemCooldown(76097) == 0 then 
		return true
	end
	return false
end

function bbLib.BGFlag()
	if GetBattlefieldStatus(1)=='active' 
	  or GetBattlefieldStatus(2)=='active' then
		InteractUnit('Horde flag')
		InteractUnit('Alliance flag')
	end
	return false
end

function bbLib.inRangeOf(spell)
  return IsSpellInRange(spell, "target") == 1
end

function bbLib.unitIsPlayer(target)
  return UnitIsUnit(target, "player") == 1
end

ProbablyEngine.library.register("bbLib", bbLib)
