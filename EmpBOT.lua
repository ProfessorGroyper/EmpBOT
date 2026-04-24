--[[
▄███▄   █▀▄▀█ █ ▄▄  ███   ████▄    ▄▄▄▄▀ 
█▀   ▀  █ █ █ █   █ █  █  █   █ ▀▀▀ █    
██▄▄    █ ▄ █ █▀▀▀  █ ▀ ▄ █   █     █    
█▄   ▄▀ █   █ █     █  ▄▀ ▀████    █     
▀███▀      █   █    ███           ▀      
          ▀     ▀                        
                                                 
        Made by Emporia                                                                                                                                                                                                              
--]]

/*
	I don’t claim this to be the best hack in the world, I made this with my dad around the year of 2016 (and it's my first real cheat). being a relatively new gLua coder I accept that all my coding
	is insanely shit. As I have progressed with this cheat I have realized that I could have done things differently with much more efficient code etc. but I haven’t been bothered to fix it.

	Fyi, the reason there is 2 B-hop scripts is because an old version doesnt work, so I decided to just make an updated one. I was too lazy to remove the old one because I have a fear of breaking shit and then not being able to fix it.
	So don't expect the checkboxes to work in the B-hop tab in the EmpBOT_Menu.



	Keybinds:
	Bind "key" "EmpBOT_Menu"
	Bind "key" "lua_openscript_cl EmpBOT.lua"

*/


//Variables
local EmpBOT = {}
EmpBOT.FriendsList = {}
EmpBOT.TextEntries = {}
EmpBOT.Hooks = {}
EmpBOT.EntityESP = {}
EmpBOT.BoneOrder = {}
EmpBOT.Traitors = {}
EmpBOT.Murderers = {}

EmpBOT.Options = {}

EmpBOT.Options["Aimbot_Toggle"] = false
EmpBOT.Options["Aimbot_LOSCheck"] = false
EmpBOT.Options["Aimbot_AutoWall"] = true
EmpBOT.Options["Aimbot_AimOnKey"] = false
EmpBOT.Options["Aimbot_AimOnKey_Key"] = 0
EmpBOT.Options["Aimbot_SmoothAim"] = false
EmpBOT.Options["Aimbot_SmoothAim_Value"] = 600
EmpBOT.Options["Aimbot_AimPriority"] = "Distance"
EmpBOT.Options["Aimbot_FOV"] = false
if LocalPlayer():GetFOV() != nil then EmpBOT.Options["Aimbot_FOV_Value"] = LocalPlayer():GetFOV() else EmpBOT.Options["Aimbot_FOV_Value"] = 75 end
EmpBOT.Options["Aimbot_StickToTarget"] = false
EmpBOT.Options["Aimbot_BoneAim"] = false
EmpBOT.Options["Aimbot_AutoShoot"] = false

EmpBOT.Options["Aimbot_AimTeam"] = false
EmpBOT.Options["Aimbot_AimOpponents"] = true
EmpBOT.Options["Aimbot_AimFriends"] = false
EmpBOT.Options["Aimbot_AimEnemies"] = false
EmpBOT.Options["Aimbot_AimNPCs"] = false
EmpBOT.Options["Aimbot_AimSpectators"] = false
EmpBOT.Options["Aimbot_AimTeamV"] = "Aim"
EmpBOT.Options["Aimbot_AimOpponentsV"] = "Aim"
EmpBOT.Options["Aimbot_AimFriendsV"] = "Aim"
EmpBOT.Options["Aimbot_AimEnemiesV"] = "Aim"
EmpBOT.Options["Aimbot_AimNPCsV"] = "Aim"
EmpBOT.Options["Aimbot_AimSpectatorsV"] = "Aim"

EmpBOT.Options["Aimbot_OffsetX"] = 0
EmpBOT.Options["Aimbot_OffsetY"] = 0

EmpBOT.Options["ESP_Toggle"] = false
EmpBOT.Options["ESP_ShowTeam"] = true
EmpBOT.Options["ESP_ShowOpponents"] = true
EmpBOT.Options["ESP_ShowFriends"] = false
EmpBOT.Options["ESP_ShowEnemies"] = false
EmpBOT.Options["ESP_ShowNPCs"] = false
EmpBOT.Options["ESP_ShowSpectators"] = false

EmpBOT.Options["ESP_ShowTeamV"] = "Show"
EmpBOT.Options["ESP_ShowOpponentsV"] = "Show"
EmpBOT.Options["ESP_ShowFriendsV"] = "Show"
EmpBOT.Options["ESP_ShowEnemiesV"] = "Show"
EmpBOT.Options["ESP_ShowNPCsV"] = "Show"
EmpBOT.Options["ESP_ShowSpectatorsV"] = "Show"

EmpBOT.Options["ESP_Entity_Toggle"] = false
EmpBOT.Options["ESP_Entities_NameTags"] = false
EmpBOT.Options["ESP_Entities_BoundaryBoxes"] = false
EmpBOT.Options["ESP_Entities_BoundaryBoxes_Mode"] = "2D"

EmpBOT.Options["ESP_BoundaryBoxes"] = false
EmpBOT.Options["ESP_BoundaryBoxes_Mode"] = "2D"
EmpBOT.Options["ESP_NameTags"] = false
EmpBOT.Options["ESP_Weapon"] = false
EmpBOT.Options["ESP_Distance"] = false
EmpBOT.Options["ESP_Health"] = false
EmpBOT.Options["ESP_Skeleton"] = false
EmpBOT.Options["ESP_Crosshair"] = false
EmpBOT.Options["ESP_Crosshair_Size"] = 50
EmpBOT.Options["ESP_Crosshair_Mode"] = "Team"
EmpBOT.Options["ESP_Crosshair_Color_R"] = 0
EmpBOT.Options["ESP_Crosshair_Color_G"] = 0
EmpBOT.Options["ESP_Crosshair_Color_B"] = 255
EmpBOT.Options["ESP_Crosshair_Color_A"] = 255

EmpBOT.Options["Misc_Clock"] = false
EmpBOT.Options["Misc_Clock_Mode"] = "Fast"
if GetConVarNumber("host_timescale") != nil then EmpBOT.Options["Misc_Clock_Speed"] = GetConVarNumber("host_timescale") else EmpBOT.Options["Misc_Clock_Speed"] = 1 end
EmpBOT.Options["Misc_AdminBox"] = false
EmpBOT.Options["Misc_AdminBox_Mode"] = "Auto"
EmpBOT.Options["Misc_AdminBox_PosX"] = 0
EmpBOT.Options["Misc_AdminBox_PosY"] = 0
EmpBOT.Options["Misc_SpectatorsBox"] = false
EmpBOT.Options["Misc_SpectatorsBox_Mode"] = "Auto"
EmpBOT.Options["Misc_SpectatorsBox_PosX"] = 150
EmpBOT.Options["Misc_SpectatorsBox_PosY"] = 0
EmpBOT.Options["Misc_AutoButton"] = false

EmpBOT.Options["Friends_FriendIsEnemy"] = false
EmpBOT.Options["Friends_SteamFriends"] = false
EmpBOT.Options["Friends_SteamEnemies"] = false

EmpBOT.Options["Cams_Toggle"] = false
EmpBOT.Options["Cams_CSNoclip"] = false
EmpBOT.Options["Cams_CSNoclip_Speed"] = 10
EmpBOT.Options["Cams_ThirdPerson"] = false
EmpBOT.Options["Cams_ThirdPerson_Zoom"] = 30

EmpBOT.Options["Bhop_Toggle"] = false
EmpBOT.Options["Bhop_FastWalk"] = false
EmpBOT.Options["Bhop_AutoHop"] = false
EmpBOT.Options["Bhop_AutoStrafe"] = false
EmpBOT.Options["Bhop_EdgeJump"] = false
EmpBOT.Options["Bhop_EdgeJump_Distance"] = 40
EmpBOT.Options["Bhop_Sideways"] = false
EmpBOT.Options["Bhop_WOnly"] = false

EmpBOT.Options["Spam_Toggle"] = false
EmpBOT.Options["Spam_Delay"] = false
EmpBOT.Options["Spam_Delay_Value"] = 10
EmpBOT.Options["Spam_AntiAntiSpam"] = false
EmpBOT.Options["Spam_Message_1"] = false
EmpBOT.Options["Spam_Message_2"] = false
EmpBOT.Options["Spam_Message_3"] = false
EmpBOT.Options["Spam_Message_4"] = false
EmpBOT.Options["Spam_Message_5"] = false


local function RandomString() return tostring(math.random(-9999999999, 9999999999)) end
local function RandomShortString() return tostring(math.random(0, 100)) end
local MenuOpen = false
local UpdateBoneThink = false
local UpdateBoneThinkNum = 0
local NormSvCheats, NormHostTimeScale, TimeScaleChange = 0, 1, false
local FPSValue = 0
local DisplayBoxWidths = 0
local AdminsListBool = false
local SpecsListBool = false
local AdminBoxTall, AdminBoxWide, SpecBoxTall, SpecBoxWide = 0, 0, 0, 0
local GMode
local MDone = false
if string.find(string.lower(GAMEMODE.Name), "terror") != nil then
	GMode = 1
elseif string.find(string.lower(GAMEMODE.Name), "murder") != nil then
	GMode = 2
else
	GMode = 3
end

//Fonts
surface.CreateFont("Menu_Title",{font = "coolvetica", size = 25})
surface.CreateFont("ESP_Font_Main",{font = "coolvetica", size = 20})
surface.CreateFont("ESP_Font_Entity",{font = "coolvetica", size = 17})
surface.CreateFont("ESP_Font_Health",{font = "coolvetica", size = 12})
surface.CreateFont("Cams",{font = "Arial", size = 25})

//Hack Management
function AddHook( NormID, Event, ID, Function )
	table.insert( EmpBOT.Hooks, NormID.."|"..Event.."|"..ID )
	hook.Add( Event, ID, Function )
end

function RemoveHook( NormID )
	for k, v in pairs( EmpBOT.Hooks ) do
		local SubTable = string.Explode( "|", v )
		if SubTable[1] == NormID then
			hook.Remove( SubTable[2], SubTable[3] )
			table.remove( EmpBOT.Hooks, k )
		end
	end
end

function GetTeam( Ply )
	local Team = Ply:Team()
	local t, c
	if GMode == 1 then
		if Team == TEAM_SPECTATOR then
			t = Team
			c = team.GetColor(Team)
		else
			if table.HasValue(EmpBOT.Traitors, Ply:SteamID()) then
				t = 1
				c = Color(255,0,0)
			elseif Ply:GetRole() == 2 then
				t = 0
				c = Color(0,0,255)
			else
				t = 0
				c = Color(0,255,0)
			end
		end
	elseif GMode == 2 then
		if Team == TEAM_SPECTATOR then
			t = Team
			c = team.GetColor(Team)
		else
			if table.HasValue(EmpBOT.Murderers, Ply:SteamID()) then
				t = 2
				c = Color(255,0,0)
			else
				t = 1
				local Moo = false
				for k, v in pairs(Ply:GetWeapons()) do
					if v:GetClass() == "weapon_mu_magnum" then
						Moo = true
						break
					end
				end
				if Moo == true then
					c = Color(0,0,255)
				else
					c = Color(0,255,0)
				end
			end
		end
	else
		t = Team
		c = team.GetColor(Team)
	end
	return t, c
end

function UnloadEmpBOT( Display )
	//Menu
	concommand.Remove("EmpBOT_Menu")

	//Hooks
	EmpBOT.Options["Misc_AdminBox"] = false
	EmpBOT.Options["Misc_SpectatorsBox"] = false //These remove the admin/spectator boxes

	timer.Simple( 0.5, function() 
		for k, v in pairs( EmpBOT.Hooks ) do
			local SubTable = string.Explode( "|", v )
			hook.Remove( SubTable[2], SubTable[3] )
		end
		table.Empty( EmpBOT.Hooks )

		//Clock Speed Manipulator
		if GetConVarNumber("sv_cheats") != NormSvCheats then LocalPlayer():ConCommand("incrementvar sv_cheats "..NormSvCheats.." "..NormSvCheats.." "..NormSvCheats) end
		if GetConVarNumber("host_timescale") != NormHostTimeScale then LocalPlayer():ConCommand("incrementvar host_timescale "..NormHostTimeScale.." "..NormHostTimeScale.." "..NormHostTimeScale) end
		if Display then
			AddHook( "Unloaded", "HUDPaint", RandomString(), function()
				draw.SimpleTextOutlined( "EmpBOT Unloaded Successfully!", "Menu_Title", ScrW()/2, 50, Color(0,150,150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0) )
				timer.Simple( 3, function()
					RemoveHook("Unloaded")
				end)
			end)
		end
	end)
end

function ReloadEmpBOT( Display )
	local Admin = EmpBOT.Options["Misc_AdminBox"]
	local Spec = EmpBOT.Options["Misc_SpectatorsBox"]
	UnloadEmpBOT()
	timer.Simple( 0.5, function()
		LoadEmpBOT()
		if Admin then
			EmpBOT.Options["Misc_AdminBox"] = true
			AddDisplayBox( "Admins", 1 )
		end
		if Spec then
			EmpBOT.Options["Misc_SpectatorsBox"] = true
			AddDisplayBox( "Spectators", 2 )
		end
		LocalPlayer():ConCommand("EmpBOT_Menu")
		if Display then
			AddHook( "Reloaded", "HUDPaint", RandomString(), function()
				draw.SimpleTextOutlined( "EmpBOT Reloaded Successfully!", "Menu_Title", ScrW()/2, 50, Color(0,150,150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0) )
				timer.Simple( 3, function()
					RemoveHook("Reloaded")
				end)
			end)
		end
	end)
end

function LoadEmpBOT( Display )
	//Commands
	CreateClientConVar("EmpBOT_Panic", 0, false, false)
	concommand.Add("EmpBOT_Menu", EmpBOTMenu)

	local EntTable = ents.GetAll()
	local FastWalk = false
	local MenuDelay, FPSDelay = false, false
	local ForwardMove = 0
	local SideMove = 0
	local TapS = false
	local WLeft, WRight, WForward, WBack, WActive = false, false, true, false, false
	local NoclipPos, NoclipAngles, NoclipOn, NoclipX, NoclipY, NoclipDuck, NoclipJump = LocalPlayer():EyePos(), LocalPlayer():GetAngles(), false, 0, 0, false, false
	local ScaleActive, ScaleNum = false, 1
	local SpamWait, Spam1, Spam2, Spam3, Spam4, Spam5 = false, false, false, false, false, false
	
	//Hooks
	AddHook( "Menu", "Think", RandomString(), function()
		if input.IsKeyDown(KEY_INSERT) && !MenuDelay then
			MenuDelay = true
			EmpBOTMenu()
			timer.Simple( 0.5, function() MenuDelay = false end )
		end

		//For FPS
		if FPSDelay == false then
			FPSDelay = true
			timer.Simple( 0.5, function() FPSValue = math.Round(1/RealFrameTime()) FPSDelay = false end )
		end

		//For Time Scale
		if EmpBOT.Options["Misc_Clock"] && GetConVarNumber("EmpBOT_Panic") == 0 then
			if GetConVarNumber("sv_cheats") != 1 then LocalPlayer():ConCommand("incrementvar sv_cheats 1 1 1") end
			if EmpBOT.Options["Misc_Clock_Speed"] != ScaleNum || !ScaleActive || TimeScaleChange then
				local k
				if EmpBOT.Options["Misc_Clock_Mode"] == "Slow" then k = 1-(EmpBOT.Options["Misc_Clock_Speed"]/10) else k = EmpBOT.Options["Misc_Clock_Speed"] end
				LocalPlayer():ConCommand("incrementvar host_timescale "..k.." "..k.." "..k) //Sozz, but I had to add kkk in somewhere :P
				ScaleNum = k
				if !ScaleActive then ScaleActive = true end
			end
		elseif EmpBOT.Options["Misc_Clock"] && GetConVarNumber("EmpBOT_Panic") == 1 then
			if ScaleActive then
				LocalPlayer():ConCommand("incrementvar sv_cheats "..NormSvCheats.." "..NormSvCheats.." "..NormSvCheats)
				LocalPlayer():ConCommand("incrementvar host_timescale "..NormHostTimeScale.." "..NormHostTimeScale.." "..NormHostTimeScale)
				ScaleActive = false
			end
		end
		//Reset T Round
		if GMode == 1 then
			if GetRoundState() != 3 then
				table.Empty(EmpBOT.Traitors)
			else
				for k, v in pairs(player.GetAll()) do
					local Ply = v
					local Team = Ply:GetRole()
					if Team == 2 then return end
					if LocalPlayer():GetRole() != 1 then
						for k, v in pairs(Ply:GetWeapons()) do
							if table.HasValue(v.CanBuy, 1) && !table.HasValue(EmpBOT.Traitors, Ply:SteamID()) then
								table.insert(EmpBOT.Traitors, Ply:SteamID())
							end
						end
					else
						if Team == 1 && !table.HasValue(EmpBOT.Traitors, Ply:SteamID()) then
							table.insert(EmpBOT.Traitors, Ply:SteamID())
						end
					end
				end
			end
		elseif GMode == 2 then
			if !MDone then
				for k, v in pairs(ents.GetAll()) do
					if v:GetClass() == "weapon_mu_knife" then
						table.insert(EmpBOT.Murderers, v:GetOwner():SteamID())
					end
				end
				MDone = true
			else
				for k, v in pairs(ents.GetAll()) do
					if v:GetClass() == "weapon_mu_knife" then
						if !table.HasValue(EmpBOT.Murderers, v:GetOwner():SteamID()) then
							table.Empty(EmpBOT.Murderers)
							MDone = false
						end
					end
				end
			end
		end
	end)

	AddHook( "Aimbot", "Think", RandomString(), function()
		if GetConVarNumber("EmpBOT_Panic") == 0 && EmpBOT.Options["Aimbot_Toggle"] && !MenuOpen && !(EmpBOT.Options["Cams_Toggle"] && EmpBOT.Options["Cams_CSNoclip"]) then
			if !EmpBOT.Options["Aimbot_AimOnKey"] || ( ( ( EmpBOT.Options["Aimbot_AimOnKey_Key"] >= 107 && EmpBOT.Options["Aimbot_AimOnKey_Key"] <= 113 ) && input.IsMouseDown(EmpBOT.Options["Aimbot_AimOnKey_Key"]) ) || input.IsKeyDown(EmpBOT.Options["Aimbot_AimOnKey_Key"]) ) then
				local FinAngleP
				local AimSpotT = {}
				local PlayerDistance, NewPlayerDistance, MousePos, NewMousePos = math.huge, math.huge, math.huge, math.huge
				if !EmpBOT.Options["Aimbot_StickToTarget"] then EntTable = ents.GetAll() end
				for k, v in pairs(EntTable) do
					if v != LocalPlayer() && v:IsValid() && v:Health() > 0 && ( v:IsNPC() || v:IsPlayer() ) then
						local Ent = v
						local AimTeam, AimOpponents, AimFriends, AimEnemies, AimSpectators, AimNPCs = false, false, false, false, false, false
						local AimTeamV, AimOpponentsV, AimFriendsV, AimEnemiesV, AimSpectatorsV, AimNPCsV = true, true, true, true, true, true
						if !Ent:IsNPC() then
							local Team, _ = GetTeam(Ent)
							if Ent:Team() != TEAM_SPECTATOR && EmpBOT.Options["Aimbot_AimTeam"] && Team == GetTeam(LocalPlayer()) then
								if EmpBOT.Options["Aimbot_AimTeamV"] == "Aim" then
									AimTeam = true
								else
									AimTeamV = false
								end
							end
							if Ent:Team() != TEAM_SPECTATOR && EmpBOT.Options["Aimbot_AimOpponents"] && Team != GetTeam(LocalPlayer()) then
								if EmpBOT.Options["Aimbot_AimOpponentsV"] == "Aim" then
									AimOpponents = true
								else
									AimOpponentsV = false
								end
							end
							if Ent:Team() != TEAM_SPECTATOR && EmpBOT.Options["Aimbot_AimFriends"] && ( (!EmpBOT.Options["Friends_FriendIsEnemy"] && table.HasValue( EmpBOT.FriendsList, Ent:SteamID() ) ) || (EmpBOT.Options["Friends_FriendIsEnemy"] && !table.HasValue( EmpBOT.FriendsList, Ent:SteamID() ) ) ) then
								if EmpBOT.Options["Aimbot_AimFriendsV"] == "Aim" then
									AimFriends = true
								else
									AimFriendsV = false
								end
							end
							if Ent:Team() != TEAM_SPECTATOR && EmpBOT.Options["Aimbot_AimEnemies"] && ( (!EmpBOT.Options["Friends_FriendIsEnemy"] && !table.HasValue( EmpBOT.FriendsList, Ent:SteamID() ) ) || (EmpBOT.Options["Friends_FriendIsEnemy"] && table.HasValue( EmpBOT.FriendsList, Ent:SteamID() ) ) ) then
								if EmpBOT.Options["Aimbot_AimEnemiesV"] == "Aim" then
									AimEnemies = true
								else
									AimEnemiesV = false
								end
							end
							if EmpBOT.Options["Aimbot_AimSpectators"] && Ent:Team() == TEAM_SPECTATOR then
								if EmpBOT.Options["AimSpectatorsV"] == "Aim" then
									AimSpectators = true
								else
									AimSpectatorsV = false
								end
							end
						else
							if EmpBOT.Options["Aimbot_AimNPCs"] && EmpBOT.Options["Aimbot_AimNPCsV"] == "Aim" then
								if EmpBOT.Options["Aimbot_AimNPCsV"] == "Aim" then
									AimNPCs = true
								else
									AimNPCsV = false
								end
							end
						end
						if (AimTeam || AimOpponents || AimFriends || AimEnemies || AimSpectators || AimNPCs) && (AimTeamV && AimOpponentsV && AimFriendsV && AimEnemiesV && AimSpectatorsV && AimNPCsV) then
							local LOS, AimP, AimF = false, false, false
							local AimSpot

							if EmpBOT.Options["Aimbot_BoneAim"] && EmpBOT.BoneOrder[1] != nil then
								table.Empty( AimSpotT )
								for k, v in pairs(EmpBOT.BoneOrder) do
									if Ent:GetBonePosition(Ent:LookupBone(v)) != nil && AimSpot == nil then
										AimSpot = Ent:GetBonePosition(Ent:LookupBone(v))
									end
									if Ent:GetBonePosition(Ent:LookupBone(v)) != nil then
										local BonePos = Ent:GetBonePosition(Ent:LookupBone(v))
										if v == "ValveBiped.Bip01_Head1" then BonePos = BonePos+Vector(0,0,1) end
										table.insert( AimSpotT, BonePos )
									end
								end
								if AimSpot == nil then AimSpot = Ent:LocalToWorld(Ent:OBBCenter()) end
								if AimSpotT == nil then AimSpotT = {Ent:LocalToWorld(Ent:OBBCenter())} end
							else
								AimSpot = Ent:LocalToWorld(Ent:OBBCenter())
								AimSpotT = {Ent:LocalToWorld(Ent:OBBCenter())}
							end

							local CurAngle = LocalPlayer():EyeAngles()
							local CurPos = LocalPlayer():GetShootPos()

							AimSpot = AimSpot+(CurAngle:Right()*EmpBOT.Options["Aimbot_OffsetX"]) //This is screw up when close to your target
							AimSpot.z = AimSpot.z + EmpBOT.Options["Aimbot_OffsetY"]

							local FinAngle = ( AimSpot - CurPos ):Angle()
							if FinAngle.y > 180 then
								FinAngle.y = FinAngle.y-360
							end

							if EmpBOT.Options["Aimbot_AimPriority"] == "Distance" then
								if LocalPlayer():GetShootPos():Distance(AimSpot) < PlayerDistance then NewPlayerDistance = LocalPlayer():GetShootPos():Distance(AimSpot) AimP = true end
							elseif EmpBOT.Options["Aimbot_AimPriority"] == "Crosshair" then
								local FirstCalc = math.Distance( CurAngle.x, CurAngle.y, FinAngle.x, FinAngle.y )
								local Calc
								if FirstCalc > 180 && ( ( CurAngle.y >= 0 && FinAngle.y < 0 ) || ( CurAngle.y < 0 && FinAngle.y >= 0 ) ) then
									Calc = 360 - math.Distance( CurAngle.x, CurAngle.y, FinAngle.x, FinAngle.y )
								else
									Calc = math.Distance( CurAngle.x, CurAngle.y, FinAngle.x, FinAngle.y )
								end
								if Calc < MousePos then NewMousePos = Calc AimP = true end
							end

							if EmpBOT.Options["Aimbot_FOV"] then
								local CalcX = FinAngle.y - CurAngle.y
								local CalcY = FinAngle.x - CurAngle.x
								if CalcY < 0 then CalcY = CalcY * -1 end
								if CalcX < 0 then CalcX = CalcX * -1 end
								if CalcY > 180 then CalcY = 360 - CalcY end
								if CalcX > 180 then CalcX = 360 - CalcX end
								if CalcX <= EmpBOT.Options["Aimbot_FOV_Value"]/2 && CalcY <= EmpBOT.Options["Aimbot_FOV_Value"]*0.4 then AimF = true end
							else
								AimF = true
							end

							if EmpBOT.Options["Aimbot_LOSCheck"] || EmpBOT.Options["Aimbot_AutoWall"] then
								for k, v in pairs(AimSpotT) do
									local TrLOS = {}
									TrLOS.start = LocalPlayer():GetShootPos()
									TrLOS.endpos = v
									TrLOS.filter = {}
									if EmpBOT.Options["Aimbot_StickToTarget"] then
										for k, v in pairs(ents.GetAll()) do
											if v:IsValid() && ( v:IsPlayer() || v:IsNPC() ) then
												table.insert( TrLOS.filter, v )
											end
										end
									else TrLOS.filter = {LocalPlayer(), Ent} end
									if EmpBOT.Options["Aimbot_AutoWall"] then TrLOS.mask = MASK_SHOT else TrLOS.mask = MASK_VISIBLE_AND_NPCS end
									if util.TraceLine(TrLOS).Fraction == 1 then
										LOS = true
										AimSpot = v
										break
									end
								end
							else
								LOS = true
							end
							if LOS && AimP && AimF then
								EntTable = {Ent}
								FinAngleP = FinAngle
								PlayerDistance = NewPlayerDistance
								MousePos = NewMousePos
							elseif EmpBOT.Options["Aimbot_StickToTarget"] && EntTable[2] != nil then
								EntTable = ents.GetAll()
							end
						end
					end
				end
				if EntTable != nil && FinAngleP != nil then
					if EmpBOT.Options["Aimbot_SmoothAim"] then
						SmoothAngles( FinAngleP, EmpBOT.Options["Aimbot_SmoothAim_Value"] )
					else
						if EmpBOT.Options["Aimbot_AutoShoot"] then
							LocalPlayer():SetEyeAngles(FinAngleP)
							LocalPlayer():ConCommand("+attack")
							timer.Simple( 0.1, function() LocalPlayer():ConCommand("-attack") end )
						else
							LocalPlayer():SetEyeAngles(FinAngleP)
						end
					end
				elseif EntTable[2] == nil then
					EntTable = ents.GetAll()
				end
			else
				if EntTable[2] == nil then
					EntTable = ents.GetAll()
				end
			end
		end
	end)
	AddHook( "ChatSpam", "Think", RandomString(), function()
		if GetConVarNumber("EmpBOT_Panic") == 0 then
			if !SpamWait then
				if EmpBOT.Options["Spam_Toggle"] then
					if EmpBOT.Options["Spam_Delay"] then
						SpamWait = true
						Spam1, Spam2, Spam3, Spam4, Spam5 = false, false, false, false, false
						local Timer = EmpBOT.Options["Spam_Delay_Value"]
						if EmpBOT.Options["Spam_Message_1"] && EmpBOT.TextEntries["Spam1"] != nil then
							local String = EmpBOT.TextEntries["Spam1"]
							if EmpBOT.Options["Spam_AntiAntiSpam"] then String = String.." ("..RandomShortString()..")" end
							timer.Simple( Timer, function()
								LocalPlayer():ConCommand("say "..String)
								Spam1 = true
							end)
							Timer = Timer + EmpBOT.Options["Spam_Delay_Value"]
						else Spam1 = true end

						if EmpBOT.Options["Spam_Message_2"] && EmpBOT.TextEntries["Spam2"] != nil then
							local String = EmpBOT.TextEntries["Spam2"]
							if EmpBOT.Options["Spam_AntiAntiSpam"] then String = String.." ("..RandomShortString()..")" end
							timer.Simple( Timer, function()
								LocalPlayer():ConCommand("say "..String)
								Spam2 = true
							end)
							Timer = Timer + EmpBOT.Options["Spam_Delay_Value"]
						else Spam2 = true end

						if EmpBOT.Options["Spam_Message_3"] && EmpBOT.TextEntries["Spam3"] != nil then
							local String = EmpBOT.TextEntries["Spam3"]
							if EmpBOT.Options["Spam_AntiAntiSpam"] then String = String.." ("..RandomShortString()..")" end
							timer.Simple( Timer, function()
								LocalPlayer():ConCommand("say "..String)
								Spam3 = true
							end)
							Timer = Timer + EmpBOT.Options["Spam_Delay_Value"]
						else Spam3 = true end

						if EmpBOT.Options["Spam_Message_4"] && EmpBOT.TextEntries["Spam4"] != nil then
							local String = EmpBOT.TextEntries["Spam4"]
							if EmpBOT.Options["Spam_AntiAntiSpam"] then String = String.." ("..RandomShortString()..")" end
							timer.Simple( Timer, function()
								LocalPlayer():ConCommand("say "..String)
								Spam4 = true
							end)
							Timer = Timer + EmpBOT.Options["Spam_Delay_Value"]
						else Spam4 = true end

						if EmpBOT.Options["Spam_Message_5"] && EmpBOT.TextEntries["Spam5"] != nil then
							local String = EmpBOT.TextEntries["Spam5"]
							if EmpBOT.Options["Spam_AntiAntiSpam"] then String = String.." ("..RandomShortString()..")" end
							timer.Simple( Timer, function()
								LocalPlayer():ConCommand("say "..String)
								Spam5 = true
							end)
							Timer = Timer + EmpBOT.Options["Spam_Delay_Value"]
						else Spam5 = true end
					else
						if EmpBOT.Options["Spam_Message_1"] && EmpBOT.TextEntries["Spam1"] != nil then
							local String = EmpBOT.TextEntries["Spam1"]
							if EmpBOT.Options["Spam_AntiAntiSpam"] then String = String.." ("..RandomShortString()..")" end
							LocalPlayer():ConCommand("say "..String)
						end
						if EmpBOT.Options["Spam_Message_1"] && EmpBOT.TextEntries["Spam2"] != nil then
							local String = EmpBOT.TextEntries["Spam2"]
							if EmpBOT.Options["Spam_AntiAntiSpam"] then String = String.." ("..RandomShortString()..")" end
							LocalPlayer():ConCommand("say "..String)
						end
						if EmpBOT.Options["Spam_Message_1"] && EmpBOT.TextEntries["Spam3"] != nil then
							local String = EmpBOT.TextEntries["Spam3"]
							if EmpBOT.Options["Spam_AntiAntiSpam"] then String = String.." ("..RandomShortString()..")" end
							LocalPlayer():ConCommand("say "..String)
						end
						if EmpBOT.Options["Spam_Message_1"] && EmpBOT.TextEntries["Spam4"] != nil then
							local String = EmpBOT.TextEntries["Spam4"]
							if EmpBOT.Options["Spam_AntiAntiSpam"] then String = String.." ("..RandomShortString()..")" end
							LocalPlayer():ConCommand("say "..String)
						end
						if EmpBOT.Options["Spam_Message_1"] && EmpBOT.TextEntries["Spam5"] != nil then
							local String = EmpBOT.TextEntries["Spam5"]
							if EmpBOT.Options["Spam_AntiAntiSpam"] then String = String.." ("..RandomShortString()..")" end
							LocalPlayer():ConCommand("say "..String)
						end
					end
				end
			else
				if Spam1 && Spam2 && Spam3 && Spam4 && Spam5 then SpamWait = false end
			end
		end
	end)
	AddHook( "ESP", "HUDPaint", RandomString(), function()
		if GetConVarNumber("EmpBOT_Panic") == 0 then
			if EmpBOT.Options["Cams_Toggle"] && EmpBOT.Options["Cams_CSNoclip"] then
				local MaxX, MaxY, MinX, MinY = ESPGetPos( LocalPlayer() )
				local Dist = math.floor(LocalPlayer():GetPos():Distance(NoclipPos)/40)
				draw.SimpleTextOutlined( "You are here ".."["..Dist.."]", "Cams", ((MaxX-MinX)/2)+MinX, MinY-5, Color(0,150,250), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0,0,0) )
				surface.SetDrawColor( Color(0,0,255) )
				surface.DrawLine( MaxX, MaxY, MinX, MaxY )
				surface.DrawLine( MaxX, MaxY, MaxX, MinY )
				surface.DrawLine( MinX, MinY, MaxX, MinY )
				surface.DrawLine( MinX, MinY, MinX, MaxY )
			end
			if EmpBOT.Options["ESP_Toggle"] || EmpBOT.Options["ESP_Entity_Toggle"] then
				for k, v in pairs( ents.GetAll() ) do
					if v:IsValid() && v != LocalPlayer() && !v:IsDormant() then
						local Ent = v
						if EmpBOT.Options["ESP_Entity_Toggle"] then
							for k, v in pairs( EmpBOT.EntityESP ) do
								if v == Ent:GetClass() && Ent:GetOwner() != LocalPlayer()  then
									local MaxX, MaxY, MinX, MinY, V1, V2, V3, V4, V5, V6, V7, V8 = ESPGetPos( Ent )
									if EmpBOT.Options["ESP_Entities_NameTags"] == true then
										local Name = Ent:GetClass()
										local Dist = math.floor(Ent:GetPos():Distance(LocalPlayer():GetShootPos())/40)
										draw.SimpleTextOutlined( Name.." ["..Dist.."]", "ESP_Font_Entity", ((MaxX-MinX)/2)+MinX, MinY-5, Color(0,160,240), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 1, Color(0,0,0) )
									end
									if EmpBOT.Options["ESP_Entities_BoundaryBoxes"] == true then
										surface.SetDrawColor( Color(0,160,240) )
										if EmpBOT.Options["ESP_Entities_BoundaryBoxes_Mode"] == "2D" then
											surface.DrawLine( MaxX, MaxY, MinX, MaxY )
											surface.DrawLine( MaxX, MaxY, MaxX, MinY )
											surface.DrawLine( MinX, MinY, MaxX, MinY )
											surface.DrawLine( MinX, MinY, MinX, MaxY )
										else
											//Top Box
											surface.DrawLine( V4.x, V4.y, V6.x, V6.y )
											surface.DrawLine( V1.x, V1.y, V8.x, V8.y )
											surface.DrawLine( V6.x, V6.y, V8.x, V8.y )
											surface.DrawLine( V4.x, V4.y, V1.x, V1.y )

											//Bottom Box
											surface.DrawLine( V3.x, V3.y, V5.x, V5.y )
											surface.DrawLine( V2.x, V2.y, V7.x, V7.y )
											surface.DrawLine( V3.x, V3.y, V2.x, V2.y )
											surface.DrawLine( V5.x, V5.y, V7.x, V7.y )

											//Verticals
											surface.DrawLine( V3.x, V3.y, V4.x, V4.y )
											surface.DrawLine( V2.x, V2.y, V1.x, V1.y )
											surface.DrawLine( V7.x, V7.y, V8.x, V8.y )
											surface.DrawLine( V5.x, V5.y, V6.x, V6.y )
										end
									end
								end
							end
						end
						if EmpBOT.Options["ESP_Toggle"] then
							if EmpBOT.Options["ESP_Crosshair"] == true then
								local _, TeamColor = GetTeam(LocalPlayer())
								if EmpBOT.Options["ESP_Crosshair_Mode"] == "Team" && Color(EmpBOT.Options["ESP_Crosshair_Color_R"], EmpBOT.Options["ESP_Crosshair_Color_G"], EmpBOT.Options["ESP_Crosshair_Color_B"]) != TeamColor then
									EmpBOT.Options["ESP_Crosshair_Color_R"] = TeamColor.r
									EmpBOT.Options["ESP_Crosshair_Color_G"] = TeamColor.g
									EmpBOT.Options["ESP_Crosshair_Color_B"] = TeamColor.b
								end
								surface.SetDrawColor(Color(EmpBOT.Options["ESP_Crosshair_Color_R"], EmpBOT.Options["ESP_Crosshair_Color_G"], EmpBOT.Options["ESP_Crosshair_Color_B"], EmpBOT.Options["ESP_Crosshair_Color_A"]))
								surface.DrawLine((ScrW()/2)-EmpBOT.Options["ESP_Crosshair_Size"], ScrH()/2, (ScrW()/2)+EmpBOT.Options["ESP_Crosshair_Size"], ScrH()/2)
								surface.DrawLine(ScrW()/2, (ScrH()/2)-EmpBOT.Options["ESP_Crosshair_Size"], ScrW()/2, (ScrH()/2)+EmpBOT.Options["ESP_Crosshair_Size"])
							end
							if Ent:IsNPC() || Ent:IsPlayer() then
								local Name
								local ShowTeam, ShowOpponents, ShowFriends, ShowEnemies, ShowNPCs, ShowSpectators = false, false, false, false, false, false
								local ShowTeamV, ShowOpponentsV, ShowFriendsV, ShowEnemiesV, ShowNPCsV, ShowSpectatorsV = true, true, true, true, true, true

								if !Ent:IsNPC() && Ent:Health() > 0 then
									local Team, _ = GetTeam(Ent)
									if Ent:Team() != TEAM_SPECTATOR && EmpBOT.Options["ESP_ShowTeam"] && Team == GetTeam(LocalPlayer()) then
										if EmpBOT.Options["ESP_ShowTeamV"] == "Show" then
											ShowTeam = true
										else
											ShowTeamV = false
										end
									end
									if Ent:Team() != TEAM_SPECTATOR && EmpBOT.Options["ESP_ShowOpponents"] && Team != GetTeam(LocalPlayer()) then
										if EmpBOT.Options["ESP_ShowOpponentsV"] == "Show" then
											ShowOpponents = true
										else
											ShowOpponentsV = false
										end
									end
									if Ent:Team() != TEAM_SPECTATOR && EmpBOT.Options["ESP_ShowFriends"] && ( (!EmpBOT.Options["Friends_FriendIsEnemy"] && table.HasValue( EmpBOT.FriendsList, Ent:SteamID() ) ) || (EmpBOT.Options["Friends_FriendIsEnemy"] && !table.HasValue( EmpBOT.FriendsList, Ent:SteamID() ) ) ) then
										if EmpBOT.Options["ESP_ShowFriendsV"] == "Show" then
											ShowFriends = true
										else
											ShowFriendsV = false
										end
									end
									if Ent:Team() != TEAM_SPECTATOR && EmpBOT.Options["ESP_ShowEnemies"] && ( (!EmpBOT.Options["Friends_FriendIsEnemy"] && !table.HasValue( EmpBOT.FriendsList, Ent:SteamID() ) ) || (EmpBOT.Options["Friends_FriendIsEnemy"] && table.HasValue( EmpBOT.FriendsList, Ent:SteamID() ) ) ) then
										if EmpBOT.Options["ESP_ShowEnemiesV"] =="Show" then
											ShowEnemies = true
										else
											ShowEnemiesV = false
										end
									end
									if EmpBOT.Options["ESP_ShowSpectators"] && Ent:Team() == TEAM_SPECTATOR then
										if EmpBOT.Options["ESP_ShowSpectatorsV"] == "Show" then
											ShowSpectators = true
										else
											ShowSpectatorsV = false
										end
									end
									Name = Ent:Nick()
								else
									if EmpBOT.Options["ESP_ShowNPCs"] && Ent:IsNPC() then
										if EmpBOT.Options["ESP_ShowNPCsV"] == "Show" then
											ShowNPCs = true
										else
											ShowNPCsV = false
										end
									end
									Name = Ent:GetClass()
								end
								if (ShowTeam || ShowOpponents || ShowFriends || ShowEnemies || ShowNPCs || ShowSpectators) && (ShowTeamV && ShowOpponentsV && ShowFriendsV && ShowEnemiesV && ShowNPCsV && ShowSpectatorsV) then
									local MaxX, MaxY, MinX, MinY, V1, V2, V3, V4, V5, V6, V7, V8 = ESPGetPos( Ent )
									local DrawColor
									local ESPPos = MinY
									if Ent:IsNPC() then	DrawColor = Color(170,220,120) else _, DrawColor = GetTeam(Ent) end
									if EmpBOT.Options["ESP_BoundaryBoxes"] then
										surface.SetDrawColor( DrawColor )
										if EmpBOT.Options["ESP_BoundaryBoxes_Mode"] == "2D" then
											surface.DrawLine( MaxX, MaxY, MinX, MaxY )
											surface.DrawLine( MaxX, MaxY, MaxX, MinY )
											surface.DrawLine( MinX, MinY, MaxX, MinY )
											surface.DrawLine( MinX, MinY, MinX, MaxY )
										else
											//Top Box
											surface.DrawLine( V4.x, V4.y, V6.x, V6.y )
											surface.DrawLine( V1.x, V1.y, V8.x, V8.y )
											surface.DrawLine( V6.x, V6.y, V8.x, V8.y )
											surface.DrawLine( V4.x, V4.y, V1.x, V1.y )

											//Bottom Box
											surface.DrawLine( V3.x, V3.y, V5.x, V5.y )
											surface.DrawLine( V2.x, V2.y, V7.x, V7.y )
											surface.DrawLine( V3.x, V3.y, V2.x, V2.y )
											surface.DrawLine( V5.x, V5.y, V7.x, V7.y )

											//Verticals
											surface.DrawLine( V3.x, V3.y, V4.x, V4.y )
											surface.DrawLine( V2.x, V2.y, V1.x, V1.y )
											surface.DrawLine( V7.x, V7.y, V8.x, V8.y )
											surface.DrawLine( V5.x, V5.y, V6.x, V6.y )
										end
									end
									if EmpBOT.Options["ESP_Health"] then					
										local HealthColor = Color( (1-(Ent:Health()/Ent:GetMaxHealth()))*255, (Ent:Health()/Ent:GetMaxHealth())*255, 0 )
										local HealthString = tostring(Ent:Health())

										if MaxY-MinY <= 45 then
											local TopHealthFar = ((1-(Ent:Health()/Ent:GetMaxHealth()))*43)+MinY+1
											local BottomHealthFar = 43-((1-(Ent:Health()/Ent:GetMaxHealth()))*43)
											draw.RoundedBox( 0, MinX-15, MinY, 10, 45, Color(0,0,0) )
											draw.RoundedBox( 0, MinX-14, TopHealthFar, 8, BottomHealthFar, HealthColor )
											draw.SimpleTextOutlined( HealthString.."%", "ESP_Font_Entity", MinX-17, MinY+22.5, HealthColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, Color(0,0,0) )
										else
											local TopHealthClose = (MinY+((1-(Ent:Health()/Ent:GetMaxHealth()))*(MaxY-MinY)))+1
											local BottomHealthClose = ((Ent:Health()/Ent:GetMaxHealth())*(MaxY-MinY))-2
											draw.RoundedBox( 0, MinX-15, MinY, 10, MaxY-MinY, Color(0,0,0) )
											draw.RoundedBox( 0, MinX-14, TopHealthClose, 8, BottomHealthClose, HealthColor )
											draw.SimpleTextOutlined( HealthString.."%", "ESP_Font_Entity", MinX-17, ((MinY-MaxY)/2)+MaxY, HealthColor, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, 1, Color(0,0,0) )
										end

									end
									if EmpBOT.Options["ESP_NameTags"] then
										if GMode == 2 && Ent:GetBystanderName() != nil then

											draw.SimpleTextOutlined( "N: "..Name.." ("..Ent:GetBystanderName()..")", "ESP_Font_Main", MaxX+5, ESPPos, DrawColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color(0,0,0) )
										else
											draw.SimpleTextOutlined( "N: "..Name, "ESP_Font_Main", MaxX+5, ESPPos, DrawColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color(0,0,0) )
										end
										ESPPos = ESPPos + 15
									end
									if EmpBOT.Options["ESP_Weapon"] then
										if Ent:GetActiveWeapon():IsValid() then
											local WName = Ent:GetActiveWeapon():GetPrintName()
											draw.SimpleTextOutlined( "W: "..WName, "ESP_Font_Main", MaxX+5, ESPPos, DrawColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color(0,0,0) )
											ESPPos = ESPPos + 15
										end
									end
									if EmpBOT.Options["ESP_Distance"] then
										local Dist = math.floor(Ent:GetPos():Distance(LocalPlayer():GetShootPos())/40)
										draw.SimpleTextOutlined( "D: "..Dist, "ESP_Font_Main", MaxX+5, ESPPos, DrawColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, Color(0,217,255) )
										ESPPos = ESPPos + 15
									end
									if EmpBOT.Options["ESP_Skeleton"] then
										local Bones = {}
										local Success = true
										for k, v in pairs(EmpBOT.Bones) do
											if Ent:LookupBone(v) != nil && Ent:GetBonePosition(Ent:LookupBone(v)) != nil then
												table.insert( Bones, Ent:GetBonePosition(Ent:LookupBone(v)):ToScreen() )
											else
												Success = false //Just incase entities have some bones but not others (I have no idea if that happens, but I figgured better safe then sorry)
												return
											end
										end
										if Success then
											surface.SetDrawColor( DrawColor )
											//Spine
											surface.DrawLine( Bones[1].x, Bones[1].y, Bones[2].x, Bones[2].y )
											surface.DrawLine( Bones[2].x, Bones[2].y, Bones[3].x, Bones[3].y )
											surface.DrawLine( Bones[3].x, Bones[3].y, Bones[4].x, Bones[4].y )
											surface.DrawLine( Bones[4].x, Bones[4].y, Bones[5].x, Bones[5].y )
											surface.DrawLine( Bones[5].x, Bones[5].y, Bones[6].x, Bones[6].y )
											surface.DrawLine( Bones[6].x, Bones[6].y, Bones[7].x, Bones[7].y )

											//Legs
											surface.DrawLine( Bones[7].x, Bones[7].y, Bones[14].x, Bones[14].y )
											surface.DrawLine( Bones[14].x, Bones[14].y, Bones[15].x, Bones[15].y )
											surface.DrawLine( Bones[15].x, Bones[15].y, Bones[16].x, Bones[16].y )
											surface.DrawLine( Bones[16].x, Bones[16].y, Bones[17].x, Bones[17].y )

											surface.DrawLine( Bones[7].x, Bones[7].y, Bones[18].x, Bones[18].y )
											surface.DrawLine( Bones[18].x, Bones[18].y, Bones[19].x, Bones[19].y )
											surface.DrawLine( Bones[19].x, Bones[19].y, Bones[20].x, Bones[20].y )
											surface.DrawLine( Bones[20].x, Bones[20].y, Bones[21].x, Bones[21].y )

											//Arms
											surface.DrawLine( Bones[3].x, Bones[3].y, Bones[8].x, Bones[8].y )
											surface.DrawLine( Bones[8].x, Bones[8].y, Bones[9].x, Bones[9].y )
											surface.DrawLine( Bones[9].x, Bones[9].y, Bones[10].x, Bones[10].y )

											surface.DrawLine( Bones[3].x, Bones[3].y, Bones[11].x, Bones[11].y )
											surface.DrawLine( Bones[11].x, Bones[11].y, Bones[12].x, Bones[12].y )
											surface.DrawLine( Bones[12].x, Bones[12].y, Bones[13].x, Bones[13].y )

										end
									end
								end
							end
						end
					end
				end
			end
		end
	end)

	AddHook( "Cams", "CalcView", RandomString(), function( ply, Pos, Ang, FOV )
		if EmpBOT.Options["Cams_Toggle"] && GetConVarNumber("EmpBOT_Panic") == 0 then
			local CamData = {}
			if EmpBOT.Options["Cams_CSNoclip"] then
				local Speed = EmpBOT.Options["Cams_CSNoclip_Speed"]/5
				local MouseAngs = Angle( NoclipY, NoclipX, 0 )
				if LocalPlayer():KeyDown(IN_SPEED) then
					Speed = Speed * 5
				end
				if LocalPlayer():KeyDown(IN_FORWARD) then
					NoclipPos = NoclipPos+(MouseAngs:Forward()*Speed)
				end
				if LocalPlayer():KeyDown(IN_BACK) then
					NoclipPos = NoclipPos-(MouseAngs:Forward()*Speed)
				end
				if LocalPlayer():KeyDown(IN_MOVELEFT) then
					NoclipPos = NoclipPos-(MouseAngs:Right()*Speed)
				end
				if LocalPlayer():KeyDown(IN_MOVERIGHT) then
					NoclipPos = NoclipPos+(MouseAngs:Right()*Speed)
				end
				if NoclipJump then
					NoclipPos = NoclipPos+Vector(0,0,Speed)
				end
				if NoclipDuck then
					NoclipPos = NoclipPos-Vector(0,0,Speed)
				end
				CamData.origin = NoclipPos
				CamData.angles = MouseAngs
				CamData.fov = FOV
				CamData.drawviewer = true
			elseif EmpBOT.Options["Cams_ThirdPerson"] then
				CamData.origin = Pos-(Ang:Forward()*(EmpBOT.Options["Cams_ThirdPerson_Zoom"]*10))
				CamData.angles = Ang
				CamData.fov = FOV
				CamData.drawviewer = true
			end
			return CamData
		end
	end)
	AddHook( "Bhop", "CreateMove", RandomString(), function(ucmd)
		if EmpBOT.Options["Cams_Toggle"] && EmpBOT.Options["Cams_CSNoclip"] && GetConVarNumber("EmpBOT_Panic") == 0 then
			if NoclipOn == false then
				NoclipPos, NoclipAngles = LocalPlayer():EyePos(), ucmd:GetViewAngles()
				NoclipY, NoclipX = ucmd:GetViewAngles().x, ucmd:GetViewAngles().y
				NoclipOn = true
			end
			ucmd:ClearMovement()
			if ucmd:KeyDown(IN_JUMP) then
				ucmd:RemoveKey(IN_JUMP)
				NoclipJump = true
			elseif NoclipJump then
				NoclipJump = false
			end
			if ucmd:KeyDown(IN_DUCK) then
				ucmd:RemoveKey(IN_DUCK)
				NoclipDuck = true
			elseif NoclipDuck then
				NoclipDuck = false
			end
			NoclipX = NoclipX-(ucmd:GetMouseX()/50)
			if NoclipY+(ucmd:GetMouseY()/50) > 89 then NoclipY = 89 elseif NoclipY+(ucmd:GetMouseY()/50) < -89 then NoclipY = -89 else NoclipY = NoclipY+(ucmd:GetMouseY()/50) end
			ucmd:SetViewAngles(NoclipAngles)
		elseif NoclipOn == true then
			NoclipOn = false
		end
	end)
	if Display then
		AddHook( "Loaded", "HUDPaint", RandomString(), function()
			draw.SimpleTextOutlined( "EmpBOT Loaded Successfully!", "Menu_Title", ScrW()/2, 50, Color(0,150,150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,0,0) )
			timer.Simple( 3, function()
				RemoveHook("Loaded")
			end)
		end)
	end
end

//Bones
EmpBOT.Bones = {
"ValveBiped.Bip01_Head1",
"ValveBiped.Bip01_Neck1",
"ValveBiped.Bip01_Spine4",
"ValveBiped.Bip01_Spine2",
"ValveBiped.Bip01_Spine1",
"ValveBiped.Bip01_Spine",
"ValveBiped.Bip01_Pelvis",
"ValveBiped.Bip01_R_UpperArm",
"ValveBiped.Bip01_R_Forearm",
"ValveBiped.Bip01_R_Hand",
"ValveBiped.Bip01_L_UpperArm",
"ValveBiped.Bip01_L_Forearm",
"ValveBiped.Bip01_L_Hand",
"ValveBiped.Bip01_R_Thigh",
"ValveBiped.Bip01_R_Calf",
"ValveBiped.Bip01_R_Foot",
"ValveBiped.Bip01_R_Toe0",
"ValveBiped.Bip01_L_Thigh",
"ValveBiped.Bip01_L_Calf",
"ValveBiped.Bip01_L_Foot",
"ValveBiped.Bip01_L_Toe0"
}

//Key Binds
EmpBOT.KeyBinds = {
[0] = "NONE",
[1] = "0",
[2] = "1",
[3] = "2",
[4] = "3",
[5] = "4",
[6] = "5",
[7] = "6",
[8] = "7",
[9] = "8",
[10] = "9",
[11] = "A",
[12] = "B",
[13] = "C",
[14] = "D",
[15] = "E",
[16] = "F",
[17] = "G",
[18] = "H",
[19] = "I",
[20] = "J",
[21] = "K",
[22] = "L",
[23] = "M",
[24] = "N",
[25] = "O",
[26] = "P",
[27] = "Q",
[28] = "R",
[29] = "S",
[30] = "T",
[31] = "U",
[32] = "V",
[33] = "W",
[34] = "X",
[35] = "Y",
[36] = "Z",
[37] = "PAD_0",
[38] = "PAD_1",
[39] = "PAD_2",
[40] = "PAD_3",
[41] = "PAD_4",
[42] = "PAD_5",
[43] = "PAD_6",
[44] = "PAD_7",
[45] = "PAD_8",
[46] = "PAD_9",
[47] = "PAD_DIVIDE",
[48] = "PAD_MULTIPLY",
[49] = "PAD_MINUS",
[50] = "PAD_PLUS",
[51] = "PAD_ENTER",
[52] = "PAD_DECIMAL",
[53] = "LBRACKET",
[54] = "RBRACKET",
[55] = "SEMICOLON",
[56] = "APOSTROPHE",
[57] = "BACKQUOTE",
[58] = "COMMA",
[59] = "PERIOD",
[60] = "SLASH",
[61] = "BACKSLASH",
[62] = "MINUS",
[63] = "EQUAL",
[64] = "ENTER",
[65] = "SPACE",
[66] = "BACKSPACE",
[67] = "TAB",
[68] = "CAPSLOCK",
[69] = "NUMLOCK",
[70] = "ESCAPE",
[71] = "SCROLLLOCK",
[72] = "INSERT",
[73] = "DELETE",
[74] = "HOME",
[75] = "END",
[76] = "PAGEUP",
[77] = "PAGEDOWN",
[78] = "BREAK",
[79] = "LSHIFT",
[80] = "RSHIFT",
[81] = "LALT",
[82] = "RALT",
[83] = "LCONTROL",
[84] = "RCONTROL",
[85] = "LWIN",
[86] = "RWIN",
[87] = "APP",
[88] = "UP",
[89] = "LEFT",
[90] = "DOWN",
[91] = "RIGHT",
[92] = "F1",
[93] = "F2",
[94] = "F3",
[95] = "F4",
[96] = "F5",
[97] = "F6",
[98] = "F7",
[99] = "F8",
[100] = "F9",
[101] = "F10",
[102] = "F11",
[103] = "F12",
//[104] = "CAPSLOCKTOGGLE",   These three screw up the binding process, probably wont bother working out how to fix it
//[105] = "NUMLOCKTOGGLE",
//[106] = "SCROLLLOCKTOGGLE",

//Xbox Controller Binds - These are untested as I don't own an xbox controller, so they might not work
[114] = "XBUTTON_A",
[115] = "XBUTTON_B",
[116] = "XBUTTON_X",
[117] = "XBUTTON_Y",
[118] = "XBUTTON_LEFT_SHOULDER",
[119] = "XBUTTON_RIGHT_SHOULDER",
[120] = "XBUTTON_BACK",
[121] = "XBUTTON_START",
[122] = "XBUTTON_STICK1",
[123] = "XBUTTON_STICK2",
[146] = "XBUTTON_UP",
[147] = "XBUTTON_RIGHT",
[148] = "XBUTTON_DOWN",
[149] = "XBUTTON_LEFT",
[150] = "XSTICK1_RIGHT",
[151] = "XSTICK1_LEFT",
[152] = "XSTICK1_DOWN",
[153] = "XSTICK1_UP",
[154] = "XBUTTON_LTRIGGER",
[155] = "XBUTTON_RTRIGGER",
[156] = "XSTICK2_RIGHT",
[157] = "XSTICK2_LEFT",
[158] = "XSTICK2_DOWN",
[159] = "XSTICK2_UP"
}

//Mouse Binds (Needs to be separate otherwise it doesn't work)
EmpBOT.MouseBinds = {
[107] = "MOUSE_LEFT",
[108] = "MOUSE_RIGHT",
[109] = "MOUSE_MIDDLE",
[110] = "MOUSE_4",
[111] = "MOUSE_5",
[112] = "MOUSE_WHEEL_UP",
[113] = "MOUSE_WHEEL_DOWN"
}

//Aimbot
function Aimbot( FinAngle )
	if EmpBOT.Options["Aimbot_SmoothAim"] then
		SmoothAngles( FinAngle, EmpBOT.Options["Aimbot_SmoothAim_Value"] )
	else
		LocalPlayer():SetEyeAngles(FinAngle)
	end
end

function SmoothAngles( FinAngle, SmoothValue )
	local SmoothValue = 10-(10*(SmoothValue/1000))
	local CloseToAngle = false
	local SmoothDirectionX = 1
	local SmoothDirectionY = 1
	local CurAngle = LocalPlayer():EyeAngles()
	if FinAngle.x > 89 then FinAngle.x = FinAngle.x - 360 end
	if CurAngle == FinAngle then
		SmoothDirectionX = 1
	elseif CurAngle.y < 0 && FinAngle.y < 0 then
		CloseToAngle = true
		if CurAngle.y > FinAngle.y then
			SmoothDirectionX = 2
		elseif CurAngle.y < FinAngle.y then
			SmoothDirectionX = 3
		end
	elseif CurAngle.y >= 0 && FinAngle.y >= 0 then
		CloseToAngle = true
		if CurAngle.y > FinAngle.y then
			SmoothDirectionX = 2
		elseif CurAngle.y < FinAngle.y then
			SmoothDirectionX = 3
		end
	elseif CurAngle.y >= 0 && FinAngle.y < 0 then
		local FlipAngle = CurAngle-(Angle(0,180,0))
		if FlipAngle.y > FinAngle.y then
			SmoothDirectionX = 3
		elseif FlipAngle.y < FinAngle.y then
			SmoothDirectionX = 2
		end
	elseif CurAngle.y < 0 && FinAngle.y >= 0 then
		local FlipAngle = CurAngle+(Angle(0,180,0))
		if FlipAngle.y < FinAngle.y then
			SmoothDirectionX = 2	
		elseif FlipAngle.y > FinAngle.y then
			SmoothDirectionX = 3
		end
	end
	if FinAngle.x < CurAngle.x then
		SmoothDirectionY = 2
	elseif FinAngle.x > CurAngle.x then
		SmoothDirectionY = 3
	end
	local X, Y = false, false
	if SmoothDirectionX == 2 then
		if CurAngle.y-SmoothValue < FinAngle.y && CloseToAngle then
			LocalPlayer():SetEyeAngles(Angle(CurAngle.x,FinAngle.y,CurAngle.z))
			Y = true
		else
			LocalPlayer():SetEyeAngles(Angle(CurAngle.x,CurAngle.y-SmoothValue,CurAngle.z))
		end
	elseif SmoothDirectionX == 3 then
		if CurAngle.y+SmoothValue > FinAngle.y && CloseToAngle then
			LocalPlayer():SetEyeAngles(Angle(CurAngle.x,FinAngle.y,CurAngle.z))
			Y = true
		else
			LocalPlayer():SetEyeAngles(Angle(CurAngle.x,CurAngle.y+SmoothValue,CurAngle.z))
		end
	end
	if SmoothDirectionY == 2 then
		//up
		if CurAngle.x-SmoothValue < FinAngle.x then
			LocalPlayer():SetEyeAngles(Angle(FinAngle.x,LocalPlayer():EyeAngles().y,LocalPlayer():EyeAngles().z))
			X = true
		else
			LocalPlayer():SetEyeAngles(Angle(CurAngle.x-SmoothValue,LocalPlayer():EyeAngles().y,LocalPlayer():EyeAngles().z))
		end
	elseif SmoothDirectionY == 3 then
		//down
		if CurAngle.x+SmoothValue > FinAngle.x then
			LocalPlayer():SetEyeAngles(Angle(FinAngle.x,LocalPlayer():EyeAngles().y,LocalPlayer():EyeAngles().z))
			X = true
		else
			LocalPlayer():SetEyeAngles(Angle(CurAngle.x+SmoothValue,LocalPlayer():EyeAngles().y,LocalPlayer():EyeAngles().z))
		end
	end
	if EmpBOT.Options["Aimbot_AutoShoot"] && X && Y then
		LocalPlayer():ConCommand("+attack")
		timer.Simple( 0.1, function() LocalPlayer():ConCommand("-attack") end )
	end
end

//ESP Functions
function ESPGetPos( Ent )
	if Ent:IsValid() then
		local Points = {
			Vector( Ent:OBBMaxs().x, Ent:OBBMaxs().y, Ent:OBBMaxs().z ),
			Vector( Ent:OBBMaxs().x, Ent:OBBMaxs().y, Ent:OBBMins().z ),
			Vector( Ent:OBBMaxs().x, Ent:OBBMins().y, Ent:OBBMins().z ),
			Vector( Ent:OBBMaxs().x, Ent:OBBMins().y, Ent:OBBMaxs().z ),
			Vector( Ent:OBBMins().x, Ent:OBBMins().y, Ent:OBBMins().z ),
			Vector( Ent:OBBMins().x, Ent:OBBMins().y, Ent:OBBMaxs().z ),
			Vector( Ent:OBBMins().x, Ent:OBBMaxs().y, Ent:OBBMins().z ),
			Vector( Ent:OBBMins().x, Ent:OBBMaxs().y, Ent:OBBMaxs().z )
		}
		local MaxX, MaxY, MinX, MinY
		local V1, V2, V3, V4, V5, V6, V7, V8
		for k, v in pairs( Points ) do
			local ScreenPos = Ent:LocalToWorld( v ):ToScreen()
			if MaxX != nil then
				MaxX, MaxY, MinX, MinY = math.max( MaxX, ScreenPos.x ), math.max( MaxY, ScreenPos.y), math.min( MinX, ScreenPos.x ), math.min( MinY, ScreenPos.y)
			else
				MaxX, MaxY, MinX, MinY = ScreenPos.x, ScreenPos.y, ScreenPos.x, ScreenPos.y
			end

			if V1 == nil then
				V1 = ScreenPos
			elseif V2 == nil then
				V2 = ScreenPos
			elseif V3 == nil then
				V3 = ScreenPos
			elseif V4 == nil then
				V4 = ScreenPos
			elseif V5 == nil then
				V5 = ScreenPos
			elseif V6 == nil then
				V6 = ScreenPos
			elseif V7 == nil then
				V7 = ScreenPos
			elseif V8 == nil then
				V8 = ScreenPos
			end
		end
		return MaxX, MaxY, MinX, MinY, V1, V2, V3, V4, V5, V6, V7, V8
	end
end

//Menu Items
function AddMenuTab( Parent, Text, Tab, PosX, PosY, TabID )
	local AddMenuTab = vgui.Create( "DButton", Parent )
	AddMenuTab:SetText( Text )
	AddMenuTab:SetTextColor( Color(255,255,255) )
	AddMenuTab:SetPos( PosX, PosY )
	function AddMenuTab:Paint() end
	AddMenuTab.DoClick = function()
		ChangeTab( Tab, TabID )
	end
	if TabID == 12 then
		AddMenuTab:SetSize( 48, 30 )
	else
		AddMenuTab:SetSize( 49, 30 )
	end
end

function AddLabel( Parent, Text, PosX, PosY, CloseOn )
	local AddLabel = vgui.Create("DLabel", Parent)
	AddLabel:SetText( Text )
	AddLabel:SetPos( PosX, PosY )
	AddLabel:SetColor(Color(255,255,255,255))
	AddLabel:SizeToContents()
	if CloseOn != nil then
		AddLabel.Think = function()
			if CloseOn == "Admins" then
				if AdminsListBool then
					AddLabel:Remove()
				end
			elseif CloseOn == "Spectators" then
				if SpecsListBool then
					AddLabel:Remove()
				end
			end
		end
	end
	return AddLabel:GetSize()
end

function AddMainMenuButton( Parent, Text, PosX, PosY, DoClick )
	local AddMainMenuButton = vgui.Create( "DButton", Parent )
	AddMainMenuButton:SetText( Text )
	AddMainMenuButton:SetTextColor( Color(255,255,255) )
	AddMainMenuButton:SetSize( 100, 30 )
	AddMainMenuButton:SetPos( PosX, PosY )
	function AddMainMenuButton:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(150,150,150,255) )
		
		surface.SetDrawColor( Color(0,0,0,255) )
		surface.DrawOutlinedRect( 0, 0, w, h )
	end
	AddMainMenuButton.DoClick = DoClick
end

function AddGenericButton( Parent, Text, SizeX, SizeY, PosX, PosY, DoClick )
	local AddGenericButton = vgui.Create( "DButton", Parent )
	AddGenericButton:SetText( Text )
	AddGenericButton:SetTextColor( Color(255,255,255) )
	AddGenericButton:SetSize( SizeX, SizeY )
	AddGenericButton:SetPos( PosX, PosY )
	function AddGenericButton:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(150,150,150,255) )
		
		surface.SetDrawColor( Color(0,0,0,255) )
		surface.DrawOutlinedRect( 0, 0, w, h )
	end
	AddGenericButton.DoClick = DoClick
end

function AddKeyBind( Parent, PosX, PosY, Var )
	local KeyBind = vgui.Create( "DButton", Parent )
	if EmpBOT.Options["Aimbot_AimOnKey_Key"] >= 107 && EmpBOT.Options["Aimbot_AimOnKey_Key"] <= 113 then
		KeyBind:SetText( EmpBOT.MouseBinds[EmpBOT.Options["Aimbot_AimOnKey_Key"]])
	else
		KeyBind:SetText( EmpBOT.KeyBinds[EmpBOT.Options["Aimbot_AimOnKey_Key"]])
	end
	KeyBind:SetTextColor( Color(255,255,255,255) )
	KeyBind:SetSize( 100, 15 )
	KeyBind:SetPos( PosX, PosY )
	KeyBind:SetTooltip( "Click button then press any key to change bind" )
	KeyBind.Paint = function()
		draw.RoundedBox( 0, 1, 1, 99, 14, Color(150,150,150,255) )
		surface.SetDrawColor( Color(0,0,0) )
		surface.DrawOutlinedRect( 0, 0, 100, 15 )
	end
	KeyBind.DoClick = function()
		KeyBind:SetText("...")
		local NoClickMenu = vgui.Create( "DFrame" )
		NoClickMenu:SetTitle("")
		NoClickMenu:ShowCloseButton(false)
		NoClickMenu:SetDraggable(false)
		NoClickMenu:SetSize(ScrW(), ScrH())
		NoClickMenu:Center()
		NoClickMenu:MakePopup()
		function NoClickMenu:Paint( w, h )
			draw.RoundedBox( 0, 0, 0, w, h, Color(0,0,0,150) )
			draw.SimpleTextOutlined( "Press Any Key", "Menu_Title", w/2, h/2, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0))
			draw.SimpleTextOutlined( "Press ESC to cancel", "Menu_Title", w/2, h/2+30, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0))
			draw.SimpleTextOutlined( "Hold ESC to clear bind", "Menu_Title", w/2, h/2+60, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER,1,Color(0,0,0))
		end
		local ESCStuff, ESCNum = false, 0
		KeyBind.Think = function()
			if !ESCStuff then
				for i = 107, 113 do
					if input.IsMouseDown(i) then
						EmpBOT.Options[Var] = i
						KeyBind:SetText(EmpBOT.MouseBinds[i])
						NoClickMenu:Close()
						KeyBind.Think = nil
					end
				end
				for i = 0, 159 do
					if input.IsKeyDown(i) then
						if i == 70 then
							LocalPlayer():ConCommand("cancelselect")
							ESCStuff = true
						else
							EmpBOT.Options[Var] = i
							KeyBind:SetText(EmpBOT.KeyBinds[i])
							NoClickMenu:Close()
							KeyBind.Think = nil
						end
					end
				end
			else
				if input.IsKeyDown(70) then
					if ESCNum >= 200 then
						EmpBOT.Options[Var] = 0
						KeyBind:SetText(EmpBOT.KeyBinds[0])
						NoClickMenu:Close()
						KeyBind.Think = nil
					else ESCNum = ESCNum + 1 end
				else
					KeyBind:SetText(EmpBOT.KeyBinds[EmpBOT.Options[Var]])
					NoClickMenu:Close()
					KeyBind.Think = nil
				end
			end
		end
	end
end

function AddCheckBox( Parent, Text, PosX, PosY, ToolTip, Var, ExtraFunc )
	local AddCheckBox = vgui.Create( "DCheckBoxLabel", Parent )
	AddCheckBox:SetText( Text )
	AddCheckBox:SetPos( PosX, PosY )
	AddCheckBox:SetTooltip( ToolTip )
	AddCheckBox:SetTextColor( Color(255,255,255,255) )
	AddCheckBox:SizeToContents()
	AddCheckBox:SetChecked( EmpBOT.Options[Var] )
	AddCheckBox.OnChange = function()
		EmpBOT.Options[Var] = AddCheckBox:GetChecked()
		if ExtraFunc != nil then
			local IsChecked = AddCheckBox:GetChecked()
			ExtraFunc()
		end
	end
end

function AddBoneButton( Parent, PosX, PosY, Bone )
	local AddBoneButton = vgui.Create( "DButton", Parent )
	if table.HasValue( EmpBOT.BoneOrder, Bone ) then
		for k, v in pairs(EmpBOT.BoneOrder) do
			if v == Bone then
				AddBoneButton:SetText(tostring(k))
			end
		end
	else
		AddBoneButton:SetText("-")
	end
	AddBoneButton:SetTextColor( Color(255,255,255,255) )
	AddBoneButton:SetSize( 16, 16 )
	AddBoneButton:SetPos( PosX-8, PosY-8 )
	AddBoneButton:SetTooltip( "Select bones in the order you want to aim at them" )
	function AddBoneButton:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(150,150,150,255) )
		
		surface.SetDrawColor( Color(0,0,0,255) )
		surface.DrawOutlinedRect( 0, 0, w, h )
	end
	AddBoneButton.DoRightClick = function()
		local BoneNum
		if table.HasValue( EmpBOT.BoneOrder, Bone ) then
			for k, v in pairs( EmpBOT.BoneOrder ) do
				if v == Bone then BoneNum = k end
			end
		else BoneNum = 0 end

		if BoneNum == 0 then
			table.insert( EmpBOT.BoneOrder, Bone )
		elseif BoneNum == 1 then
			table.remove( EmpBOT.BoneOrder, BoneNum )
		else
			table.remove( EmpBOT.BoneOrder, BoneNum )
			table.insert( EmpBOT.BoneOrder, BoneNum-1, Bone )
		end
		UpdateBoneThink = true
	end
	AddBoneButton.DoClick = function()
		local BoneNum
		if table.HasValue( EmpBOT.BoneOrder, Bone ) then
			for k, v in pairs( EmpBOT.BoneOrder ) do
				if v == Bone then BoneNum = k end
			end
		else BoneNum = 0 end

		if BoneNum == 0 then
			table.insert( EmpBOT.BoneOrder, 1, Bone )
		elseif BoneNum == 21 then
			table.remove( EmpBOT.BoneOrder, BoneNum )
		else
			if BoneNum != table.Count( EmpBOT.BoneOrder ) then
				table.remove( EmpBOT.BoneOrder, BoneNum )
				table.insert( EmpBOT.BoneOrder, BoneNum+1, Bone )
			else
				table.remove( EmpBOT.BoneOrder, BoneNum )
			end
		end
		UpdateBoneThink = true
	end
	AddBoneButton.Think = function()
		if UpdateBoneThink then
			if UpdateBoneThinkNum != 21 then
				local BoneNum
				if table.HasValue( EmpBOT.BoneOrder, Bone ) then
					for k, v in pairs( EmpBOT.BoneOrder ) do
						if v == Bone then BoneNum = k end
					end
				else BoneNum = 0 end
				if BoneNum != 0 then
					AddBoneButton:SetText(tostring(BoneNum))
				else
					AddBoneButton:SetText("-")
				end
				UpdateBoneThinkNum = UpdateBoneThinkNum+1
			end
			if UpdateBoneThinkNum == 21 then
				UpdateBoneThinkNum = 0
				UpdateBoneThink = false
			end
		end
	end
end

function AddComboBox( Parent, PosX, PosY, SizeX, SizeY, Var, ChoiceTable, ExtraFunc )
	local AddComboBox = vgui.Create( "DComboBox", Parent )
	AddComboBox:SetPos( PosX, PosY )
	AddComboBox:SetSize( SizeX, SizeY )
	AddComboBox:SetValue(EmpBOT.Options[Var])
	for k, v in pairs( ChoiceTable ) do
		AddComboBox:AddChoice(v)
	end
	AddComboBox.OnSelect = function(Selected)
		EmpBOT.Options[Var] = Selected:GetValue()
		if ExtraFunc != nil then
			ExtraFunc()
		end
	end
end

function AddSlider( Parent, Var, PosX, PosY, Min, Max, Decimals )
	local AddSlider = vgui.Create( "Slider", Parent )
	AddSlider:SetSize( 150, 15 )
	AddSlider:SetPos( PosX, PosY )
	AddSlider:SetMin( Min )
	AddSlider:SetMax( Max )
	AddSlider:SetDecimals( Decimals )
	AddSlider:SetValue( EmpBOT.Options[Var] )
	AddSlider.OnValueChanged = function( Panel, Value )
		EmpBOT.Options[Var] = math.Round( Value, Decimals )
	end
	AddSlider.Paint = function()
		draw.RoundedBox( 0, 0, 0, 135, 15, Color(255,255,255,255) )
		surface.SetDrawColor(Color(0,0,0,255))
		surface.DrawOutlinedRect( 0, 0, 135, 15 )
		surface.DrawLine( 105, 0, 105, 15 )
	end
end

function AddTextEntry( Parent, Width, PosX, PosY, DefaultText, Var, Save )
	local AddTextEntry = vgui.Create("DTextEntry", Parent)
	AddTextEntry:SetWide(Width)
	AddTextEntry:SetPos(PosX,PosY)
	if Save != nil && EmpBOT.TextEntries[Var] != nil then
		AddTextEntry:SetText(EmpBOT.TextEntries[Var])
	else
		AddTextEntry:SetText(DefaultText)
	end
	AddTextEntry.OnGetFocus = function()
		if AddTextEntry:GetText() == DefaultText then
			AddTextEntry:SetText("")
		end
	end
	AddTextEntry.OnLoseFocus = function()
		if AddTextEntry:GetText() == "" then
			AddTextEntry:SetText(DefaultText)
			EmpBOT.TextEntries[Var] = nil
		else
			EmpBOT.TextEntries[Var] = AddTextEntry:GetText()
		end
	end
end

function AddDisplayBox( Title, Mode )
	local DisplayBox = vgui.Create( "DFrame" )
	DisplayBox:SetTitle("")
	DisplayBox:ShowCloseButton(false)
	DisplayBox:SetDraggable(true)
	DisplayBox:SetSize( 150, 50 )
	function DisplayBox:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, 24, Color(0,0,0,255) )
		draw.RoundedBox( 0, 0, 0, w, h, Color(0,10,20,245) )
		draw.SimpleText( Title, "Menu_Title", w/2, 13, Color(255,0,166), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	if Mode == 1 then
		DisplayBox:SetPos( EmpBOT.Options["Misc_AdminBox_PosX"], EmpBOT.Options["Misc_AdminBox_PosY"] )
		local AdminTable = {"Moo"}
		local Wait = false
		AddHook( "AdminDisplayBox", "Think", RandomString(), function()
			if !EmpBOT.Options["Misc_AdminBox"] then
				DisplayBox:Close()
				RemoveHook("AdminDisplayBox")
			end
			local PoX, PoY = DisplayBox:GetPos()
			if  EmpBOT.Options["Misc_AdminBox_PosX"] != PoX ||  EmpBOT.Options["Misc_AdminBox_PosY"] != PoY then
				EmpBOT.Options["Misc_AdminBox_PosX"], EmpBOT.Options["Misc_AdminBox_PosY"] = PoX, PoY
			end
			local TempAdminTable = {}
			for k, v in pairs(player.GetAll()) do
				if v:IsAdmin() || v:IsSuperAdmin() then
					table.insert( TempAdminTable, v:Nick() )
				end
			end
			if table.concat(TempAdminTable) != table.concat(AdminTable) then
				if !AdminsListBool && !Wait then
					AdminsListBool = true
					timer.Simple( 0.1, function() AdminsListBool = false Wait = true end )
				elseif Wait then
					AdminTable = table.Copy(TempAdminTable)
					local TextWidth, Tall = 140, 30
					local OldWidth, OldTall = DisplayBox:GetSize()
					if AdminTable[1] != nil then
						for k, v in pairs(AdminTable) do
							local TempTextWidth = AddLabel( DisplayBox, v, 5, Tall, "Admins" )
							if TempTextWidth > TextWidth then TextWidth = TempTextWidth end
							Tall = Tall + 15
						end
						DisplayBox:SetSize( TextWidth + 10, Tall+5 )
					else
						AddLabel( DisplayBox, "No Admins Online", 5, Tall, "Admins" )
						DisplayBox:SetSize( 150, 50 )
					end
					local DifferenceX, DifferenceY = OldWidth - TextWidth+10, OldTall - Tall+5
					local Var = "AdminBox" //This used to be a function but it screwed up, so I just added it to the hook and I couldn't be bothered making it look normal incase you are wondering what the point of this is
					if DifferenceX < 0 then
						DifferenceX = DifferenceX * -1
						RightPos = EmpBOT.Options["Misc_"..Var.."_PosX"] - DifferenceX
					else
						RightPos = EmpBOT.Options["Misc_"..Var.."_PosX"] + DifferenceX
					end
					if DifferenceY < 0 then
						DifferenceY = DifferenceY * -1
						BottomPos = EmpBOT.Options["Misc_"..Var.."_PosY"] - DifferenceY
					else
						BottomPos = EmpBOT.Options["Misc_"..Var.."_PosY"] + DifferenceY
					end

					if EmpBOT.Options["Misc_"..Var.."_Mode"] == "Auto" then
						local PosX, PosY
						if EmpBOT.Options["Misc_"..Var.."_PosX"] > ScrW()/2 then PosX = RightPos else PosX = EmpBOT.Options["Misc_"..Var.."_PosX"] end
						if EmpBOT.Options["Misc_"..Var.."_PosY"] > ScrH()/2 then PosY = BottomPos else PosY = EmpBOT.Options["Misc_"..Var.."_PosY"] end
						DisplayBox:SetPos( PosX, PosY )
					elseif EmpBOT.Options["Misc_"..Var.."_Mode"] == "Top Right" then
						DisplayBox:SetPos( RightPos, EmpBOT.Options["Misc_"..Var.."_PosY"] )
					elseif EmpBOT.Options["Misc_"..Var.."_Mode"] == "Bottom Left" then
						DisplayBox:SetPos( EmpBOT.Options["Misc_"..Var.."_PosX"], BottomPos )
					elseif EmpBOT.Options["Misc_"..Var.."_Mode"] == "Bottom Right" then
						DisplayBox:SetPos( RightPos, BottomPos )
					end
					Wait = false
				end
			end
		end)
	elseif Mode == 2 then
		DisplayBox:SetPos( EmpBOT.Options["Misc_SpectatorsBox_PosX"], EmpBOT.Options["Misc_SpectatorsBox_PosY"] )
		local SpecsTable = {"Moo"}
		local Wait = false
		AddHook( "SpecDisplayBox", "Think", RandomString(), function()
			if !EmpBOT.Options["Misc_SpectatorsBox"] then
				DisplayBox:Close()
				RemoveHook("SpecDisplayBox")
			end
			local PoX, PoY = DisplayBox:GetPos()
			if  EmpBOT.Options["Misc_SpectatorsBox_PosX"] != PoX ||  EmpBOT.Options["Misc_SpectatorsBox_PosY"] != PoY then
				EmpBOT.Options["Misc_SpectatorsBox_PosX"], EmpBOT.Options["Misc_SpectatorsBox_PosY"] = PoX, PoY
			end
			local TempSpecsTable = {}
			for k, v in pairs(player.GetAll()) do
				if v:GetObserverTarget() == LocalPlayer() then
					table.insert( TempSpecsTable, v:Nick() )
				end
			end
			if table.concat(TempSpecsTable) != table.concat(SpecsTable) then
				if !SpecsListBool && !Wait then
					SpecsListBool = true
					timer.Simple( 0.1, function() SpecsListBool = false Wait = true end )
				elseif Wait then
					SpecsTable = table.Copy(TempSpecsTable)
					local TextWidth, Tall = 140, 30
					local OldWidth, OldTall = DisplayBox:GetSize()
					if SpecsTable[1] != nil then
						for k, v in pairs(SpecsTable) do
							local TempTextWidth = AddLabel( DisplayBox, v, 5, Tall, "Spectators" )
							if TempTextWidth > TextWidth then TextWidth = TempTextWidth end
							Tall = Tall + 15
						end
						DisplayBox:SetSize( TextWidth + 10, Tall+5 )
					else
						AddLabel( DisplayBox, "No Spectators", 5, Tall, "Spectators" )
						DisplayBox:SetSize( 150, 50 )
					end
					local DifferenceX, DifferenceY = OldWidth - TextWidth+10, OldTall - Tall+5
					local Var = "SpectatorsBox"
					if DifferenceX < 0 then
						DifferenceX = DifferenceX * -1
						RightPos = EmpBOT.Options["Misc_"..Var.."_PosX"] - DifferenceX
					else
						RightPos = EmpBOT.Options["Misc_"..Var.."_PosX"] + DifferenceX
					end
					if DifferenceY < 0 then
						DifferenceY = DifferenceY * -1
						BottomPos = EmpBOT.Options["Misc_"..Var.."_PosY"] - DifferenceY
					else
						BottomPos = EmpBOT.Options["Misc_"..Var.."_PosY"] + DifferenceY
					end

					if EmpBOT.Options["Misc_"..Var.."_Mode"] == "Auto" then
						local PosX, PosY
						if EmpBOT.Options["Misc_"..Var.."_PosX"] > ScrW()/2 then PosX = RightPos else PosX = EmpBOT.Options["Misc_"..Var.."_PosX"] end
						if EmpBOT.Options["Misc_"..Var.."_PosY"] > ScrH()/2 then PosY = BottomPos else PosY = EmpBOT.Options["Misc_"..Var.."_PosY"] end
						DisplayBox:SetPos( PosX, PosY )
					elseif EmpBOT.Options["Misc_"..Var.."_Mode"] == "Top Right" then
						DisplayBox:SetPos( RightPos, EmpBOT.Options["Misc_"..Var.."_PosY"] )
					elseif EmpBOT.Options["Misc_"..Var.."_Mode"] == "Bottom Left" then
						DisplayBox:SetPos( EmpBOT.Options["Misc_"..Var.."_PosX"], BottomPos )
					elseif EmpBOT.Options["Misc_"..Var.."_Mode"] == "Bottom Right" then
						DisplayBox:SetPos( RightPos, BottomPos )
					end
					Wait = false
				end
			end
		end)
	end
end

function AddSavePage( Parent, Mode )
	local ManageSaves = vgui.Create("DListView", Parent)
	ManageSaves:SetPos( 25, 55 )
	ManageSaves:SetSize( 550, 200 )
	ManageSaves:SetMultiSelect(false)
	ManageSaves:AddColumn("Title")
	ManageSaves:AddColumn("Date Created")
	function RefreshSaveList(Location, Parent)
		Parent:Clear()
		if !file.Exists( "sh/"..Location, "DATA" ) then file.CreateDir( "sh/"..Location ) end
		if file.Exists( "sh/"..Location, "DATA" ) then
			local Files, Dirs = file.Find( "sh/"..Location.."/*", "DATA" )
			for k, v in pairs( Files ) do
				local Title = string.StripExtension(v)
				local SaveTable = string.Explode( "|", file.Read( "sh/"..Location.."/"..v, "DATA" ) )
				local Date = SaveTable[1]
				local Time = SaveTable[2]
				if Time != nil && Date != nil then
					Parent:AddLine(Title, Date.."|"..Time)
				else
					Parent:AddLine(Title, "This save has been corrupted")
				end
			end
		end
	end
	RefreshSaveList(Mode, ManageSaves)
	
	AddTextEntry( Parent, 275, 25, 275, "Input Save Title", Mode )
	AddGenericButton( Parent, "Refresh Listings", 100, 20, 475, 275, function () RefreshSaveList(Mode, ManageSaves) end )
	AddGenericButton( Parent, "Delete", 51, 20, 419, 275, function()
		if ManageSaves:GetSelectedLine() != nil then
			local SaveTitle = ManageSaves:GetLine(ManageSaves:GetSelectedLine()):GetValue(1)
			if file.Exists( "sh/"..Mode.."/"..SaveTitle..".txt", "DATA" ) then file.Delete( "sh/"..Mode.."/"..SaveTitle..".txt" ) end
			RefreshSaveList(Mode, ManageSaves)
		end
	end)
	AddGenericButton( Parent, "Load", 52, 20, 362, 275, function()
		if ManageSaves:GetSelectedLine() != nil then
			local SaveTitle = ManageSaves:GetLine(ManageSaves:GetSelectedLine()):GetValue(1)
			if file.Exists( "sh/"..Mode.."/"..SaveTitle..".txt", "DATA" ) then
				local SaveFile = file.Read( "sh/"..Mode.."/"..SaveTitle..".txt" )
				local SaveFileTable = string.Explode( "|", SaveFile )
				for k, v in pairs( SaveFileTable ) do
					if k != 1 && k != 2 then
						if ManageSaves:GetLine(ManageSaves:GetSelectedLine()):GetValue(2) != "This save has been corrupted" then
							if Mode == "Friends" then
								table.insert( EmpBOT.FriendsList, v )
							elseif Mode == "Configs" then
								if string.Left( v, 1 ) == "{" then
									EmpBOT.BoneOrder = util.JSONToTable( v )
								else
									local CommandTable = string.Explode( " ", v )
									if CommandTable[3] == "true" || CommandTable[3] == "false" then
										EmpBOT.Options[CommandTable[1]] = tobool(CommandTable[3])
									elseif isnumber(tonumber(CommandTable[3])) then
										EmpBOT.Options[CommandTable[1]] = tonumber(CommandTable[3])
									else
										EmpBOT.Options[CommandTable[1]] = tostring(CommandTable[3])
									end
								end
							elseif Mode == "Entities" then
								table.insert( EmpBOT.EntityESP, v )
							end
						end
					end
				end
				if ManageSaves:GetLine(ManageSaves:GetSelectedLine()):GetValue(2) != "This save has been corrupted" then
					if Mode == "Friends" then
						RefreshFriendsList()
					elseif Mode == "Configs" then
						//RefreshSaveList( Mode, ManageSaves )
						CloseMenu()
						ReloadEmpBOT(false)
					elseif Mode == "Entities" then
						RefreshEntsList()
					end
				end
			end
		end
	end)
	AddGenericButton( Parent, "Save", 52, 20, 305, 275, function()
		if EmpBOT.TextEntries[Mode] != nil then
			local Files, Dirs = file.Find( "sh/"..Mode.."/*", "DATA" )
			for k, v in pairs( Files ) do
				local Title = string.StripExtension(v)
				if Title == EmpBOT.TextEntries[Mode] then return end
			end
			if !file.Exists( "sh/"..Mode, "DATA" ) then file.CreateDir( "sh/"..Mode ) end
			if file.Exists( "sh/"..Mode, "DATA" ) then
				if tonumber( os.date("%H"), 10 ) < 12 then
					local SaveText = os.date("%d/%m/%y | %I:%M AM")
					if Mode == "Friends" then
						for k, v in pairs( EmpBOT.FriendsList ) do
							SaveText = SaveText.."|"..v
						end
						file.Write( "sh/"..Mode.."/"..EmpBOT.TextEntries[Mode]..".txt", SaveText)
					elseif Mode == "Configs" then
						for k, v in pairs( EmpBOT.Options ) do
							SaveText = SaveText.."|"..k.." = "..tostring(v)
						end
						SaveText = SaveText.."|"..util.TableToJSON( EmpBOT.BoneOrder )
						file.Write( "sh/"..Mode.."/"..EmpBOT.TextEntries[Mode]..".txt", SaveText)
					elseif Mode == "Entities" then
						for k, v in pairs( EmpBOT.EntityESP ) do
							SaveText = SaveText.."|"..v
						end
						file.Write( "sh/"..Mode.."/"..EmpBOT.TextEntries[Mode]..".txt", SaveText)
					end
				else
					local SaveText = os.date("%d/%m/%y | %I:%M PM")
					if Mode == "Friends" then
						for k, v in pairs( EmpBOT.FriendsList ) do
							SaveText = SaveText.."|"..v
						end
						file.Write( "sh/"..Mode.."/"..EmpBOT.TextEntries[Mode]..".txt", SaveText)
					elseif Mode == "Configs" then
						for k, v in pairs( EmpBOT.Options ) do
							SaveText = SaveText.."|"..k.." = "..tostring(v)
						end
						SaveText = SaveText.."|"..util.TableToJSON( EmpBOT.BoneOrder )
						file.Write( "sh/"..Mode.."/"..EmpBOT.TextEntries[Mode]..".txt", SaveText)
					elseif Mode == "Entities" then
						for k, v in pairs( EmpBOT.EntityESP ) do
							SaveText = SaveText.."|"..v
						end
						file.Write( "sh/"..Mode.."/"..EmpBOT.TextEntries[Mode]..".txt", SaveText)
					end
				end
			end
			RefreshSaveList(Mode, ManageSaves)
		end
	end)
	AddGenericButton( Parent, "Rename", 52, 20, 305, 300, function()
		if ManageSaves:GetSelectedLine() != nil && EmpBOT.TextEntries[Mode] != nil then
			local SaveTitle = ManageSaves:GetLine(ManageSaves:GetSelectedLine()):GetValue(1)
			if file.Exists( "sh/"..Mode.."/"..SaveTitle..".txt", "DATA" ) then
				local Files, Dirs = file.Find( "sh/"..Mode.."/*", "DATA" )
				for k, v in pairs( Files ) do
					local Title = string.StripExtension(v)
					if Title == EmpBOT.TextEntries[Mode] then return end
				end
				local SaveFileText = file.Read( "sh/"..Mode.."/"..SaveTitle..".txt", "DATA" )
				file.Delete( "sh/"..Mode.."/"..SaveTitle..".txt" )
				file.Write( "sh/"..Mode.."/"..EmpBOT.TextEntries[Mode]..".txt", SaveFileText )
				RefreshSaveList(Mode, ManageSaves)
			end
		end
	end)
end

function EmpBOTMenu()
	if MenuOpen then
		CloseMenu()
		return
	end
	MenuOpen = true
	//Menu Frame
	local Menu = vgui.Create("DFrame")
	Menu:SetTitle("")
	Menu:ShowCloseButton(false)
	Menu:SetDraggable(true)
	Menu:SetSize(600, 400)
	Menu:Center()
	Menu:MakePopup()
	function Menu:Paint( w, h )
		//Title Bar
		draw.RoundedBox( 0, 0, 0, w, 24, Color(0,0,0,255) )
		draw.RoundedBox( 0, 0, 0, w, h, Color(0,10,20,245) )
		
		draw.SimpleText( "EmpBOT", "Menu_Title", w/2, 11, Color(0,100,200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
		draw.SimpleText( "FPS: "..FPSValue, "ESP_Font_Main", 5, 2, Color(0,255,0),TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
		draw.SimpleText( "Ping: "..LocalPlayer():Ping(), "ESP_Font_Main", 65, 2, Color(0,255,0), TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM )
		
		//Menu Tabs
		draw.RoundedBox( 0, 0, 25, w, 30, Color(128,128,128,255) )
		surface.SetDrawColor( Color(0,0,0) )
		surface.DrawLine( 0, 24, w, 24 )
		surface.DrawLine( 0, 55, w, 55 )
		surface.DrawLine( 0, 24, 0, 55 )
		surface.DrawLine( 50, 24, 50, 55 )
		surface.DrawLine( 100, 24, 100, 55 )
		surface.DrawLine( 150, 24, 150, 55 )
		surface.DrawLine( 200, 24, 200, 55 )
		surface.DrawLine( 250, 24, 250, 55 )
		surface.DrawLine( 300, 24, 300, 55 )
		surface.DrawLine( 350, 24, 350, 55 )
		surface.DrawLine( 400, 24, 400, 55 )
		surface.DrawLine( 450, 24, 450, 55 )
		surface.DrawLine( 500, 24, 500, 55 )
		surface.DrawLine( 550, 24, 550, 55 )
		surface.DrawLine( 599, 24, 599, 55 )
    end
	
	//Tab Frames
	local Main = vgui.Create("DPanel", Menu)
	Main:SetPos( 0 , 25 )
	Main:SetSize( Menu:GetWide(), Menu:GetTall()-25 )
	Main:SetVisible( false )
	function Main:Paint()
		draw.RoundedBox( 0, 1, 0, 49, 30, Color(0,0,255,255) )
	end
	
	local Aimbot = vgui.Create("DPanel", Menu)
	Aimbot:SetPos( 0 , 25 )
	Aimbot:SetSize( Menu:GetWide(), Menu:GetTall()-25 )
	Aimbot:SetVisible( false )
	function Aimbot:Paint()
		draw.RoundedBox( 0, 51, 0, 49, 30, Color(0,0,255,255) )

		surface.SetDrawColor( Color(255,255,255,255) )

		//Head
		surface.DrawCircle( 490, 75, 30, {255,255,255,255} )

		//Spine
		surface.DrawLine( 490, 105, 490, 255 )

		//Arms
		surface.DrawLine( 490, 180, 440, 130 )
		surface.DrawLine( 490, 180, 540, 130 )
		//Hands
		surface.DrawLine( 440, 130, 420, 130 )
		surface.DrawLine( 540, 130, 560, 130 )

		//Legs
		surface.DrawLine( 490, 255, 440, 305 )
		surface.DrawLine( 490, 255, 540, 305 )
		//Feet
		surface.DrawLine( 440, 305, 400, 305 )
		surface.DrawLine( 540, 305, 580, 305 )
	end
	
	local ESP = vgui.Create("DPanel", Menu)
	ESP:SetPos( 0 , 25 )
	ESP:SetSize( Menu:GetWide(), Menu:GetTall()-25 )
	ESP:SetVisible( false )
	function ESP:Paint()
		draw.RoundedBox( 0, 101, 0, 49, 30, Color(0,0,255,255) )
	end
	
	local Ents = vgui.Create("DPanel", Menu)
	Ents:SetPos( 0 , 25 )
	Ents:SetSize( Menu:GetWide(), Menu:GetTall()-25 )
	Ents:SetVisible( false )
	function Ents:Paint()
		draw.RoundedBox( 0, 151, 0, 49, 30, Color(0,0,255,255) )
	end
	
	local Misc = vgui.Create("DPanel", Menu)
	Misc:SetPos( 0 , 25 )
	Misc:SetSize( Menu:GetWide(), Menu:GetTall()-25 )
	Misc:SetVisible( false )
	function Misc:Paint()
		draw.RoundedBox( 0, 201, 0, 49, 30, Color(0,0,255,255) )
	end
	
	local Friends = vgui.Create("DPanel", Menu)
	Friends:SetPos( 0 , 25 )
	Friends:SetSize( Menu:GetWide(), Menu:GetTall()-25 )
	Friends:SetVisible( false )
	function Friends:Paint()
		draw.RoundedBox( 0, 251, 0, 49, 30, Color(0,0,255,255) )
		draw.SimpleText( "Friends                                                       Enemies", "ESP_Font_Main", 300, 43, Color(0,255,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	
	local Cams = vgui.Create("DPanel", Menu)
	Cams:SetPos( 0 , 25 )
	Cams:SetSize( Menu:GetWide(), Menu:GetTall()-25 )
	Cams:SetVisible( false )
	function Cams:Paint()
		draw.RoundedBox( 0, 301, 0, 49, 30, Color(0,0,255,255) )
	end

	local Bhop = vgui.Create("DPanel", Menu)
	Bhop:SetPos( 0 , 25 )
	Bhop:SetSize( Menu:GetWide(), Menu:GetTall()-25 )
	Bhop:SetVisible( false )
	function Bhop:Paint()
		draw.RoundedBox( 0, 351, 0, 49, 30, Color(0,0,255,255) )
	end

	local Spam = vgui.Create("DPanel", Menu)
	Spam:SetPos( 0 , 25 )
	Spam:SetSize( Menu:GetWide(), Menu:GetTall()-25 )
	Spam:SetVisible( false )
	function Spam:Paint()
		draw.RoundedBox( 0, 401, 0, 49, 30, Color(0,0,255,255) )
	end
	
	local Test10 = vgui.Create("DPanel", Menu)
	Test10:SetPos( 0 , 25 )
	Test10:SetSize( Menu:GetWide(), Menu:GetTall()-25 )
	Test10:SetVisible( false )
	function Test10:Paint()
		draw.RoundedBox( 0, 451, 0, 49, 30, Color(0,0,255,255) )
	end
	
	local Test11 = vgui.Create("DPanel", Menu)
	Test11:SetPos( 0 , 25 )
	Test11:SetSize( Menu:GetWide(), Menu:GetTall()-25 )
	Test11:SetVisible( false )
	function Test11:Paint()
		draw.RoundedBox( 0, 501, 0, 49, 30, Color(0,0,255,255) )
	end
	
	local Config = vgui.Create("DPanel", Menu)
	Config:SetPos( 0 , 25 )
	Config:SetSize( Menu:GetWide(), Menu:GetTall()-25 )
	Config:SetVisible( false )
	function Config:Paint()
		draw.RoundedBox( 0, 551, 0, 48, 30, Color(0,0,255,255) )
		draw.SimpleText( "Configuration save manager", "ESP_Font_Main", 300, 43, Color(0,255,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	
	local FriendSaves = vgui.Create("DPanel", Menu)
	FriendSaves:SetPos( 0 , 25 )
	FriendSaves:SetSize( Menu:GetWide(), Menu:GetTall()-25 )
	FriendSaves:SetVisible( false )
	function FriendSaves:Paint()
		draw.RoundedBox( 0, 251, 0, 49, 30, Color(0,0,255,255) )
		draw.SimpleText( "Friends list save manager", "ESP_Font_Main", 300, 43, Color(0,255,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	
	local EntitySaves = vgui.Create("DPanel", Menu)
	EntitySaves:SetPos( 0 , 25 )
	EntitySaves:SetSize( Menu:GetWide(), Menu:GetTall()-25 )
	EntitySaves:SetVisible( false )
	function EntitySaves:Paint()
		draw.RoundedBox( 0, 151, 0, 49, 30, Color(0,0,255,255) )
		draw.SimpleText( "Entity ESP save manager", "ESP_Font_Main", 300, 43, Color(0,255,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end

	local CustomCrosshair = vgui.Create("DPanel", Menu)
	CustomCrosshair:SetPos( 0 , 25 )
	CustomCrosshair:SetSize( Menu:GetWide(), Menu:GetTall()-25 )
	CustomCrosshair:SetVisible( false )
	function CustomCrosshair:Paint()
		draw.RoundedBox( 0, 101, 0, 49, 30, Color(0,0,255,255) )
		draw.SimpleText( "Custom Crosshair", "ESP_Font_Main", 300, 43, Color(0,255,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	end
	
	//Close Button		
	local CloseButton = vgui.Create("DButton", Menu)
	CloseButton:SetSize(24, 24)
	CloseButton:SetPos(Menu:GetWide()-24, 0)
	CloseButton:SetText("X")
	CloseButton:SetColor(Color(255,255,255))
	function CloseButton:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(0,30,100,200) )
	end
	CloseButton.DoClick = function() CloseMenu() end
	
	//Panic Button
	local PanicButton = vgui.Create("DButton", Menu)
	PanicButton:SetSize(40, 24)
	PanicButton:SetPos(Menu:GetWide()-64, 0)
	if GetConVarNumber("EmpBOT_Panic") == 1 then
		PanicButton:SetText("Enable")
		PanicButton:SetColor(Color(50,200,0,255))
	else
		PanicButton:SetText("Disable")
		PanicButton:SetColor(Color(255,0,0,255))
	end
	function PanicButton:Paint( w, h )
		draw.RoundedBox( 0, 0, 0, w, h, Color(150,150,150,255) )
	end
	PanicButton.DoClick = function()
		if GetConVarNumber("EmpBOT_Panic") == 1 then
			RunConsoleCommand("EmpBOT_Panic", 0)
			PanicButton:SetText("Disable")
			PanicButton:SetColor(Color(255,0,0,255))
		else
			RunConsoleCommand("EmpBOT_Panic", 1)
			PanicButton:SetText("Enable")
			PanicButton:SetColor(Color(50,200,0,255))
		end
	end
		
	//Menu Tabs
	AddMenuTab( Menu, "Main", Main, 1, 25, 1 )
	AddMenuTab( Menu, "Aimbot", Aimbot, 51, 25, 2 )
	AddMenuTab( Menu, "ESP", ESP, 101, 25, 3 )
	AddMenuTab( Menu, "Ents", Ents, 151, 25, 4 )
	AddMenuTab( Menu, "Misc", Misc, 201, 25, 5 )
	AddMenuTab( Menu, "Friends", Friends, 251, 25, 6 )
	AddMenuTab( Menu, "Cams", Cams, 301, 25, 7 )
	AddMenuTab( Menu, "Bhop", Bhop, 351, 25, 8 )
	AddMenuTab( Menu, "Spam", Spam, 401, 25, 9 )
	AddMenuTab( Menu, "Test10", Test10, 451, 25, 10 )
	AddMenuTab( Menu, "Test11", Test11, 501, 25, 11 )
	AddMenuTab( Menu, "Config", Config, 551, 25, 12 )
	
	function ChangeTab ( Tab, TabID )
		Main:SetVisible(false)
		Aimbot:SetVisible(false)
		ESP:SetVisible(false)
		Ents:SetVisible(false)
		Misc:SetVisible(false)
		Friends:SetVisible(false)
		Cams:SetVisible(false)
		Bhop:SetVisible(false)
		Spam:SetVisible(false)
		Test10:SetVisible(false)
		Test11:SetVisible(false)
		Config:SetVisible(false)
		FriendSaves:SetVisible(false)
		EntitySaves:SetVisible(false)
		CustomCrosshair:SetVisible(false)
		
		Tab:SetVisible(true)
		EmpBOT.ActiveTab = TabID
	end
	
	//Main Tab
	AddMainMenuButton( Main, "Unload Hack", 100, 60, function()
		CloseMenu()
		UnloadEmpBOT(true)
	end)
	AddMainMenuButton( Main, "Reload Hack", 250, 60, function()
		CloseMenu()
		ReloadEmpBOT(true)
	end)
	AddMainMenuButton( Main, "Clear Saved Files", 400, 60, function()
		if file.Exists( "sh", "DATA" ) then
			local Files, Dirs = file.Find( "sh/*", "DATA" )
			for k, v in pairs( Files ) do
				file.Delete( "sh/"..v )
			end
			for k, v in pairs( Dirs ) do
				local Files, Dirs = file.Find( "sh/"..v.."/*", "DATA" )
				local Dir = v
				for k, v in pairs( Files ) do
					file.Delete( "sh/"..Dir.."/"..v )
				end
			end
		end
	end)
	
	//Aimbot Tab
	AddCheckBox( Aimbot, "Aimbot", 15, 45, "Enables/Disables Aimbot", "Aimbot_Toggle" )
	AddCheckBox( Aimbot, "LOS Check", 15, 65, "Only aims at visible players (players within your line of sight)", "Aimbot_LOSCheck" )
	AddCheckBox( Aimbot, "Auto Wall", 15, 85, "Aim at people behind walls that can be shot through", "Aimbot_AutoWall")
	AddCheckBox( Aimbot, "Auto Shoot", 100, 85, "Automatically shoot when the aimbot is locked onto someone", "Aimbot_AutoShoot")

	AddCheckBox( Aimbot, "Aim On Key", 15, 105, "Aimbot only active when selected key is held down", "Aimbot_AimOnKey" )
	AddKeyBind( Aimbot, 100, 105, "Aimbot_AimOnKey_Key" )
	AddLabel( Aimbot, "Aim Priority:", 40, 125 )
	AddComboBox( Aimbot, 100, 125, 100, 15, "Aimbot_AimPriority", {"Distance", "Crosshair"} )
	AddCheckBox( Aimbot, "Smooth Aim", 15, 145, "Aims at other players slowly (looks more legit)", "Aimbot_SmoothAim")
	AddSlider( Aimbot, "Aimbot_SmoothAim_Value", 100, 145, 0, 1000, 0 )
	AddCheckBox( Aimbot, "FOV", 15, 165, "Only aim at players within the selected field of view", "Aimbot_FOV")
	AddSlider( Aimbot, "Aimbot_FOV_Value", 100, 165, 0, 360, 0 )
	AddCheckBox( Aimbot, "Stick To Target", 15, 185, "Will stay aiming at the one target as long as they fall within the selected criteria above", "Aimbot_StickToTarget" )
	AddCheckBox( Aimbot, "Bone Aim", 15, 205, "Aims only at selected bone", "Aimbot_BoneAim" )

	AddCheckBox( Aimbot, "Team", 15, 245, "Aim at/ignore players on your team", "Aimbot_AimTeam" )
	AddCheckBox( Aimbot, "Opponents", 15, 265, "Aim at/ignore players on the other team", "Aimbot_AimOpponents" )
	AddCheckBox( Aimbot, "Friends", 15, 285, "Aim at/ignore players on your friends list", "Aimbot_AimFriends" )
	AddCheckBox( Aimbot, "Enemies", 15, 305, "Aim at/ignore players on your enemies list", "Aimbot_AimEnemies" )
	AddCheckBox( Aimbot, "NPCs", 15, 325, "Aim at/ignore NPCs", "Aimbot_AimNPCs" )
	AddCheckBox( Aimbot, "Spectators", 15, 345, "Aim at/ignore players who are in spectator mode", "Aimbot_AimSpectators" )

	AddComboBox( Aimbot, 100, 245, 70, 15, "Aimbot_AimTeamV", {"Aim", "Ignore"} )
	AddComboBox( Aimbot, 100, 265, 70, 15, "Aimbot_AimOpponentsV", {"Aim", "Ignore"} )
	AddComboBox( Aimbot, 100, 285, 70, 15, "Aimbot_AimFriendsV", {"Aim", "Ignore"} )
	AddComboBox( Aimbot, 100, 305, 70, 15, "Aimbot_AimEnemiesV", {"Aim", "Ignore"} )
	AddComboBox( Aimbot, 100, 325, 70, 15, "Aimbot_AimNPCsV", {"Aim", "Ignore"} )
	AddComboBox( Aimbot, 100, 345, 70, 15, "Aimbot_AimSpectatorsV", {"Aim", "Ignore"} )

	//AddLabel( Parent, Text, PosX, PosY, CloseOn )
	AddLabel( Aimbot, "Offset X:", 200, 325 )
	AddLabel( Aimbot, "Offset Y:", 200, 345 )
	AddSlider( Aimbot, "Aimbot_OffsetX", 250, 320, -100, 100, 0 )
	AddSlider( Aimbot, "Aimbot_OffsetY", 250, 340, -100, 100, 0 )
	
	AddBoneButton( Aimbot, 490, 75, "ValveBiped.Bip01_Head1" )
	AddBoneButton( Aimbot, 490, 120, "ValveBiped.Bip01_Neck1" )
	AddBoneButton( Aimbot, 490, 150, "ValveBiped.Bip01_Spine4" )
	AddBoneButton( Aimbot, 490, 175, "ValveBiped.Bip01_Spine2" )
	AddBoneButton( Aimbot, 490, 200, "ValveBiped.Bip01_Spine1" )
	AddBoneButton( Aimbot, 490, 225, "ValveBiped.Bip01_Spine" )
	AddBoneButton( Aimbot, 490, 255, "ValveBiped.Bip01_Pelvis" )
	AddBoneButton( Aimbot, 470, 160, "ValveBiped.Bip01_R_UpperArm" )
	AddBoneButton( Aimbot, 450, 140, "ValveBiped.Bip01_R_Forearm" )
	AddBoneButton( Aimbot, 430, 130, "ValveBiped.Bip01_R_Hand" )
	AddBoneButton( Aimbot, 510, 165, "ValveBiped.Bip01_L_UpperArm" )
	AddBoneButton( Aimbot, 530, 140, "ValveBiped.Bip01_L_Forearm" )
	AddBoneButton( Aimbot, 550, 130, "ValveBiped.Bip01_L_Hand" )
	AddBoneButton( Aimbot, 470, 275, "ValveBiped.Bip01_R_Thigh" )
	AddBoneButton( Aimbot, 450, 295, "ValveBiped.Bip01_R_Calf" )
	AddBoneButton( Aimbot, 430, 305, "ValveBiped.Bip01_R_Foot" )
	AddBoneButton( Aimbot, 410, 305, "ValveBiped.Bip01_R_Toe0" )
	AddBoneButton( Aimbot, 510, 275, "ValveBiped.Bip01_L_Thigh" )
	AddBoneButton( Aimbot, 530, 295, "ValveBiped.Bip01_L_Calf" )
	AddBoneButton( Aimbot, 550, 305, "ValveBiped.Bip01_L_Foot" )
	AddBoneButton( Aimbot, 570, 305, "ValveBiped.Bip01_L_Toe0" )

	AddGenericButton( Aimbot, "Fill", 85, 30, 400, 325, function()
		for k, v in pairs(EmpBOT.Bones) do
			if !table.HasValue( EmpBOT.BoneOrder, v ) then
				table.insert( EmpBOT.BoneOrder, v )
			end
		end
		UpdateBoneThink = true
	end)
	AddGenericButton( Aimbot, "Clear", 85, 30, 495, 325, function()
		table.Empty( EmpBOT.BoneOrder )
		UpdateBoneThink = true
	end)
	

	//ESP Tab
	AddCheckBox( ESP, "ESP", 15, 45, "Enables/Disables ESP", "ESP_Toggle" )
	AddCheckBox( ESP, "Team", 15, 65, "Draw/Ignore ESP for players on your team", "ESP_ShowTeam" )
	AddCheckBox( ESP, "Opponents", 15, 85, "Draw/Ignore ESP for players not on your team", "ESP_ShowOpponents" )
	AddCheckBox( ESP, "Friends", 15, 105, "Draw/Ignore ESP for players on your friends list", "ESP_ShowFriends" )
	AddCheckBox( ESP, "Enemies", 15, 125, "Draw/Ignore ESP for players on your enemies list", "ESP_ShowEnemies" )
	AddCheckBox( ESP, "NPCs", 15, 145, "Draw/Ignore ESP for NPCs", "ESP_ShowNPCs" )
	AddCheckBox( ESP, "Spectators", 15, 165, "Draw/Ignore ESP for spectators", "ESP_ShowSpectators" )

	AddComboBox( ESP, 100, 65, 70, 15, "ESP_ShowTeamV", {"Show", "Ignore"} )
	AddComboBox( ESP, 100, 85, 70, 15, "ESP_ShowOpponentsV", {"Show", "Ignore"} )
	AddComboBox( ESP, 100, 105, 70, 15, "ESP_ShowFriendsV", {"Show", "Ignore"} )
	AddComboBox( ESP, 100, 125, 70, 15, "ESP_ShowEnemiesV", {"Show", "Ignore"} )
	AddComboBox( ESP, 100, 145, 70, 15, "ESP_ShowNPCsV", {"Show", "Ignore"} )
	AddComboBox( ESP, 100, 165, 70, 15, "ESP_ShowSpectatorsV", {"Show", "Ignore"} )

	AddCheckBox( ESP, "Boundary Boxes", 15, 190, "Display a box around players", "ESP_BoundaryBoxes" )
	AddComboBox( ESP, 120, 190, 35, 15, "ESP_BoundaryBoxes_Mode", { "2D", "3D" } )
	AddCheckBox( ESP, "Name Tags", 15, 210, "Display player names", "ESP_NameTags" )
	AddCheckBox( ESP, "Weapon", 15, 230, "Display equipped weapon of players", "ESP_Weapon" )
	AddCheckBox( ESP, "Distance", 15, 250, "Display distance between you and other players", "ESP_Distance" )
	AddCheckBox( ESP, "Health", 15, 270, "Display health of players", "ESP_Health" )
	AddCheckBox( ESP, "Skeleton", 15, 290, "Draws the skeleton of players", "ESP_Skeleton" )
	AddCheckBox( ESP, "Crosshair", 15, 310, "Draws crosshair on screen", "ESP_Crosshair" )
	AddGenericButton( ESP, "Customize", 80, 15, 90, 310, function() ChangeTab(CustomCrosshair,15) end )

	AddCheckBox( ESP, "Entity ESP", 185, 65, "Draw ESP for selected entities", "ESP_Entity_Toggle" )
	AddCheckBox( ESP, "Name Tags", 185, 85, "Draw ESP for selected entities", "ESP_Entities_NameTags" )
	AddCheckBox( ESP, "Boundary Boxes", 185, 105, "Draw ESP for selected entities", "ESP_Entities_BoundaryBoxes" )
	AddComboBox( ESP, 290, 105, 40, 15, "ESP_Entities_BoundaryBoxes_Mode", { "2D", "3D" } )

	//Crosshair Custimization
	AddGenericButton( CustomCrosshair, "<-- Finished   ", 100, 20, 25, 335, function () ChangeTab( ESP, 3 ) end )
	AddLabel( CustomCrosshair, "Size:", 15, 60 )
	AddLabel( CustomCrosshair, "Mode:", 15, 80)
	AddSlider( CustomCrosshair, "ESP_Crosshair_Size", 50, 60, 1, ScrW()/2, 0 )
	AddComboBox( CustomCrosshair, 50, 80, 105, 15, "ESP_Crosshair_Mode", { "Team", "Custom" } )

	local Mixer = vgui.Create( "DColorMixer", CustomCrosshair )
	Mixer:SetSize( 250, 160 )
	Mixer:SetPos( 335, 60 )
	Mixer:SetPalette( false )
	Mixer:SetAlphaBar( true )
	Mixer:SetWangs( true )
	if EmpBOT.Options["ESP_Crosshair_Mode"] == "Team" then
		Mixer:SetColor( team.GetColor(LocalPlayer():Team()) )
	else
		Mixer:SetColor( Color(EmpBOT.Options["ESP_Crosshair_Color_R"], EmpBOT.Options["ESP_Crosshair_Color_G"], EmpBOT.Options["ESP_Crosshair_Color_B"], EmpBOT.Options["ESP_Crosshair_Color_A"]) )
	end
	Mixer.Think = function()
		if EmpBOT.Options["ESP_Crosshair_Mode"] == "Custom" then
			EmpBOT.Options["ESP_Crosshair_Color_R"] = Mixer:GetColor().r
			EmpBOT.Options["ESP_Crosshair_Color_G"] = Mixer:GetColor().g
			EmpBOT.Options["ESP_Crosshair_Color_B"] = Mixer:GetColor().b
		end
		EmpBOT.Options["ESP_Crosshair_Color_A"] = Mixer:GetColor().a
	end

	//Ents Tab
	local ESPOffEntsList = vgui.Create("DListView", Ents)
	ESPOffEntsList:SetPos( 25, 55 )
	ESPOffEntsList:SetSize( 225, 295 )
	ESPOffEntsList:SetMultiSelect(false)
	ESPOffEntsList:AddColumn("Off ESP")
	
	local ESPOnEntsList = vgui.Create("DListView", Ents)
	ESPOnEntsList:SetPos( 350, 55 )
	ESPOnEntsList:SetSize( 225, 295 )
	ESPOnEntsList:SetMultiSelect(false)
	ESPOnEntsList:AddColumn("On ESP")
	
	function RefreshEntsList()
		ESPOnEntsList:Clear()
		ESPOffEntsList:Clear()
		for k, v in pairs( EmpBOT.EntityESP ) do
			ESPOnEntsList:AddLine(v)
		end
		for k, v in pairs( ents.GetAll() ) do
			local Name = v:GetClass()
			local Copy = false
			if Name != "player" then
				if !table.HasValue( EmpBOT.EntityESP, Name ) then
					for k, v in pairs (ESPOffEntsList:GetLines() ) do
						if v:GetValue(1) == Name then Copy = true end
					end
					if Copy == false then ESPOffEntsList:AddLine(Name) end
				end
			end
		end
	end
	RefreshEntsList()
	
	AddGenericButton( Ents, "Refresh", 80, 30, 260, 55, function() RefreshEntsList() end )
	AddGenericButton( Ents, "------->", 80, 30, 260, 167.5, function()
		if ESPOffEntsList:GetSelectedLine() != nil then
			table.insert( EmpBOT.EntityESP, ESPOffEntsList:GetLine(ESPOffEntsList:GetSelectedLine()):GetValue(1) )
		end
		RefreshEntsList()
	end)
	AddGenericButton( Ents, "<-------", 80, 30, 260, 207.5, function()
		if ESPOnEntsList:GetSelectedLine() != nil then
			for k, v in pairs( EmpBOT.EntityESP ) do
				if v == ESPOnEntsList:GetLine(ESPOnEntsList:GetSelectedLine()):GetValue(1) then
					table.remove( EmpBOT.EntityESP, k )
				end
			end
		end
		RefreshEntsList()
	end)
	AddGenericButton( Ents, "Add All", 80, 30, 260, 95, function()
		for k, v in pairs( ESPOffEntsList:GetLines() ) do
			table.insert( EmpBOT.EntityESP, v:GetValue(1) )
		end
		RefreshEntsList() 
	end)
	AddGenericButton( Ents, "Clear Ents", 80, 30, 260, 280, function() table.Empty( EmpBOT.EntityESP ) RefreshEntsList() end )
	AddGenericButton( Ents, "Manage Saves", 80, 30, 260, 320, function() ChangeTab(EntitySaves, 14) end )
	
	//Entity Saves Manager
	AddSavePage( EntitySaves, "Entities" )
	AddGenericButton( EntitySaves, "<-- Finished   ", 100, 20, 25, 335, function () ChangeTab( Ents, 4 ) end )

	//Misc Tab
	AddCheckBox( Misc, "Clock Speed Manipulator", 15, 45, "Speed hack", "Misc_Clock", function()
		if EmpBOT.Options["Misc_Clock"] then
			TimeScaleChange = true
		else
			LocalPlayer():ConCommand("incrementvar sv_cheats "..NormSvCheats.." "..NormSvCheats.." "..NormSvCheats)
			LocalPlayer():ConCommand("incrementvar host_timescale "..NormHostTimeScale.." "..NormHostTimeScale.." "..NormHostTimeScale)
		end
	end)
	AddSlider( Misc, "Misc_Clock_Speed", 160, 45, 0, 10, 0 )
	AddComboBox( Misc, 300, 45, 50, 15, "Misc_Clock_Mode", {"Fast", "Slow"}, function() TimeScaleChange = true end )

	AddCheckBox( Misc, "Admin Box", 15, 65, "Display all admins in a box", "Misc_AdminBox", function()
		if EmpBOT.Options["Misc_AdminBox"] then
			AddDisplayBox( "Admins", 1 )
		end
	end)
	AddComboBox( Misc, 120, 65, 90, 15, "Misc_AdminBox_Mode", {"Auto", "Top Left", "Top Right", "Bottom Left", "Bottom Right"} )
	AddCheckBox( Misc, "Spectators Box", 15, 85, "Display all people spectating you in a box", "Misc_SpectatorsBox", function()
		if EmpBOT.Options["Misc_SpectatorsBox"] then
			AddDisplayBox( "Spectators", 2 )
		end
	end)
	AddComboBox( Misc, 120, 85, 90, 15, "Misc_SpectatorsBox_Mode", {"Auto", "Top Left", "Top Right", "Bottom Left", "Bottom Right"} )
	
	//Friends Tab
	local FriendsList = vgui.Create("DListView", Friends)
	FriendsList:SetPos( 25, 55 )
	FriendsList:SetSize( 275, 200 )
	FriendsList:SetMultiSelect(false)
	FriendsList:AddColumn("Player Name")
	FriendsList:AddColumn("Steam ID")
	
	local EnemiesList = vgui.Create("DListView", Friends)
	EnemiesList:SetPos( 300, 55 )
	EnemiesList:SetSize( 275, 200 )
	EnemiesList:SetMultiSelect(false)
	EnemiesList:AddColumn("Player Name")
	EnemiesList:AddColumn("Steam ID")
	
	function RefreshFriendsList()
		FriendsList:Clear()
		EnemiesList:Clear()
		for k, v in pairs(player.GetAll()) do
			if v != LocalPlayer() then
				if EmpBOT.Options["Friends_SteamFriends"] && v:GetFriendStatus() == "friend" then
					if !table.HasValue(EmpBOT.FriendsList, v:SteamID()) then table.insert(EmpBOT.FriendsList, v:SteamID()) end
				end
				if EmpBOT.Options["Friends_SteamEnemies"] && v:GetFriendStatus() == "friend" then
					local PlayerSteamID = v:SteamID()
					for k, v in pairs(EmpBOT.FriendsList) do
						if v == PlayerSteamID then
							table.remove(EmpBOT.FriendsList, k)
						end
					end
					if table.HasValue(EmpBOT.FriendsList, v:SteamID()) then table.remove(EmpBOT.FriendsList, v:SteamID()) end
				end
				if EmpBOT.Options["Friends_FriendIsEnemy"] then
					if table.HasValue(EmpBOT.FriendsList, v:SteamID()) then
						EnemiesList:AddLine(v:Nick(), v:SteamID())
					else
						FriendsList:AddLine(v:Nick(), v:SteamID())
					end
				else
					if table.HasValue(EmpBOT.FriendsList, v:SteamID()) then
						FriendsList:AddLine(v:Nick(), v:SteamID())
					else
						EnemiesList:AddLine(v:Nick(), v:SteamID())
					end
				end
			end
		end
	end
	RefreshFriendsList()
	
	AddMainMenuButton( Friends, "Remove Friend", 112.5, 260, function()
		local SelectedLine = FriendsList:GetSelectedLine()
		if SelectedLine != nil then
			local PlayerNick = FriendsList:GetLine(SelectedLine):GetValue(1)
			local PlayerSteamID = FriendsList:GetLine(SelectedLine):GetValue(2)
			if EmpBOT.Options["Friends_FriendIsEnemy"] then
				table.insert(EmpBOT.FriendsList, PlayerSteamID)
			else
				for k, v in pairs(EmpBOT.FriendsList) do
					if v == PlayerSteamID then
						table.remove(EmpBOT.FriendsList, k)
						break
					end
				end
			end
			RefreshFriendsList()
		end
	end)
	
	AddMainMenuButton( Friends, "Add Friend", 387.5, 260, function()
		local SelectedLine = EnemiesList:GetSelectedLine()
		if SelectedLine != nil then
			local PlayerNick = EnemiesList:GetLine(SelectedLine):GetValue(1)
			local PlayerSteamID = EnemiesList:GetLine(SelectedLine):GetValue(2)
			if EmpBOT.Options["Friends_FriendIsEnemy"] then
				for k, v in pairs(EmpBOT.FriendsList) do
					if v == PlayerSteamID then
						table.remove(EmpBOT.FriendsList, k)
						break
					end
				end
			else
				table.insert(EmpBOT.FriendsList, PlayerSteamID)
			end
			RefreshFriendsList()
		end
	end)
	
	AddMainMenuButton( Friends, "Refresh List", (Friends:GetWide()/2)-50, 260, function() RefreshFriendsList() end )
	AddMainMenuButton( Friends, "Manage Saves", (Friends:GetWide()/2)-50, 300, function() ChangeTab( FriendSaves, 13 ) end )
	AddMainMenuButton( Friends, "Clear Friends", 387.5, 300, function() table.Empty( EmpBOT.FriendsList ) RefreshFriendsList() end )
	AddCheckBox( Friends, "Friend Is Enemy", 5, 265, "Turns the friends list into the enemies list", "Friends_FriendIsEnemy", function() RefreshFriendsList() end )
	AddCheckBox( Friends, "Steam Friends", 5, 285, "Make your friends on steam automatically appear on the friends list", "Friends_SteamFriends", function() RefreshFriendsList() end )
	AddCheckBox( Friends, "Steam Enemies", 5, 305, "Make your friends on steam automatically appear on the enemies list", "Friends_SteamEnemies", function() RefreshFriendsList() end )
	
	//Manage Friend Saves
	AddSavePage( FriendSaves, "Friends" )
	AddGenericButton( FriendSaves, "<-- Finished   ", 100, 20, 25, 335, function () ChangeTab( Friends, 6 ) end )

	//Cams Tab
	AddCheckBox( Cams, "Cams", 15, 45, "Enables/Disables cams hacks", "Cams_Toggle" )
	AddCheckBox( Cams, "Client Side Noclip", 15, 65, "Fly around the map freely (everyone else on the server wont see you flying)", "Cams_CSNoclip" )
	AddSlider( Cams, "Cams_CSNoclip_Speed", 125, 65, 0, 100, 0 )
	AddCheckBox( Cams, "Thirdperson", 15, 85, "An over shoulder view", "Cams_ThirdPerson" )
	AddSlider( Cams, "Cams_ThirdPerson_Zoom", 125, 85, 0, 100, 0 )

	//Spam Tab
	AddCheckBox( Spam, "Spam", 15, 45, "Enables/Disables Chat Spammer", "Spam_Toggle" )
	AddCheckBox( Spam, "Delay", 15, 65, "Pauses between each spam for x seeconds", "Spam_Delay" )
	AddSlider( Spam, "Spam_Delay_Value", 80, 65, 0, 10, 2 )
	AddCheckBox( Spam, "Anti-Anti-Spam", 15, 85, "Adds a random number to the end of your message to help avoid Anti-Spammers", "Spam_AntiAntiSpam" )

	AddCheckBox( Spam, "Message 1", 15, 265, "Enable spam message #1", "Spam_Message_1" )
	AddCheckBox( Spam, "Message 2", 15, 285, "Enable spam message #2", "Spam_Message_2" )
	AddCheckBox( Spam, "Message 3", 15, 305, "Enable spam message #3", "Spam_Message_3" )
	AddCheckBox( Spam, "Message 4", 15, 325, "Enable spam message #4", "Spam_Message_4" )
	AddCheckBox( Spam, "Message 5", 15, 345, "Enable spam message #5", "Spam_Message_5" )
	AddTextEntry( Spam, 485, 100, 262, "", "Spam1", true )
	AddTextEntry( Spam, 485, 100, 282, "", "Spam2", true )
	AddTextEntry( Spam, 485, 100, 302, "", "Spam3", true )
	AddTextEntry( Spam, 485, 100, 322, "", "Spam4", true )
	AddTextEntry( Spam, 485, 100, 342, "", "Spam5", true )
	
	//Config Tab
	AddSavePage( Config, "Configs" )
	
	if EmpBOT.ActiveTab == nil then EmpBOT.ActiveTab = 1 end
	if EmpBOT.ActiveTab == 1 then ChangeTab( Main, 1 )
	elseif EmpBOT.ActiveTab == 2 then ChangeTab( Aimbot, 2 )
	elseif EmpBOT.ActiveTab == 3 then ChangeTab( ESP, 3 )
	elseif EmpBOT.ActiveTab == 4 then ChangeTab( Ents, 4 )
	elseif EmpBOT.ActiveTab == 5 then ChangeTab( Misc, 5 )
	elseif EmpBOT.ActiveTab == 6 then ChangeTab( Friends, 6 )
	elseif EmpBOT.ActiveTab == 7 then ChangeTab( Cams, 7 )
	elseif EmpBOT.ActiveTab == 8 then ChangeTab( Bhop, 8 )
	elseif EmpBOT.ActiveTab == 9 then ChangeTab( Spam, 9 )
	elseif EmpBOT.ActiveTab == 10 then ChangeTab( Test10, 10 )
	elseif EmpBOT.ActiveTab == 11 then ChangeTab( Test11, 11 )
	elseif EmpBOT.ActiveTab == 12 then ChangeTab( Config, 12 )
	elseif EmpBOT.ActiveTab == 13 then ChangeTab ( FriendSaves, 13 )
	elseif EmpBOT.ActiveTab == 14 then ChangeTab ( EntitySaves, 14 )
	elseif EmpBOT.ActiveTab == 15 then ChangeTab ( CustomCrosshair, 15 ) end

	function CloseMenu()
		MenuOpen = false
		Menu:Close()
	end
end
LoadEmpBOT(true)

hook.Add("SetupMove", "AutoBhop", function(ply, mv, cmd)
    if not ply:Alive() then return end

    if mv:KeyDown(IN_JUMP) then
        if not ply:OnGround() then
            mv:SetButtons(bit.band(mv:GetButtons(), bit.bnot(IN_JUMP)))
        end
    end
end)

hook.Add("PreDrawPlayerHands", "WhiteHandsOnly", function(hands, vm, ply, weapon)
    render.SetColorModulation(0, 0, 0, 0)
    render.SetBlend(0.8)
    render.MaterialOverride(Material("models/debug/debugwhite"))
end)

hook.Add("PostDrawPlayerHands", "WhiteHandsOnly_Reset", function()
    render.SetColorModulation(0, 0, 0, 0)
    render.SetBlend(0.8)
    render.MaterialOverride(nil)
end)

if CLIENT then
    local bhopEnabled = CreateClientConVar("bhop_enabled", "1", true, false)
    local bhopAuto = CreateClientConVar("bhop_auto", "1", true, false)
    local bhopSpeed = CreateClientConVar("bhop_speed", "1.0", true, false)
    local bhopGroundStrafe = CreateClientConVar("bhop_groundstrafe", "1", true, false)
    
    local lastJumpTime = 0
    local shouldJump = false
    
    local function AutoStrafe(cmd)
        if not bhopAuto:GetBool() then return end
        
        local ply = LocalPlayer()
        if not IsValid(ply) or not ply:Alive() then return end
        
        if ply:IsOnGround() then return end
        
        local vel = ply:GetVelocity()
        local speed = vel:Length2D()
        
        if speed > 50 then
            local forward = cmd:GetForwardMove()
            local side = cmd:GetSideMove()
            
            if forward == 0 and side == 0 then
                local viewAngles = cmd:GetViewAngles()
                local moveAngles = Angle(0, viewAngles.y, 0)
                
                local localVel = WorldToLocal(vel, Angle(0,0,0), Vector(0,0,0), moveAngles)
                
                if localVel.y > 0 then
                    cmd:SetSideMove(-400)
                else
                    cmd:SetSideMove(400)
                end
            end
        end
    end
    
    hook.Add("CreateMove", "BunnyHop", function(cmd)
        if not bhopEnabled:GetBool() then return end
        
        local ply = LocalPlayer()
        if not IsValid(ply) or not ply:Alive() then return end
        if bhopAuto:GetBool() then
            local buttons = cmd:GetButtons()
            
            if bit.band(buttons, IN_JUMP) ~= 0 then
                -- If we're on ground, jump
                if ply:IsOnGround() then
                    cmd:SetButtons(bit.bor(buttons, IN_JUMP))
                    shouldJump = true
                else
                    cmd:SetButtons(bit.band(buttons, bit.bnot(IN_JUMP)))
                    shouldJump = false
                end
            else
                shouldJump = false
            end
        end
        
        if bhopSpeed:GetFloat() ~= 1.0 then
            local forward = cmd:GetForwardMove()
            local side = cmd:GetSideMove()
            
            if forward ~= 0 or side ~= 0 then
                cmd:SetForwardMove(forward * bhopSpeed:GetFloat())
                cmd:SetSideMove(side * bhopSpeed:GetFloat())
            end
        end
        
        AutoStrafe(cmd)
        
        if bhopGroundStrafe:GetBool() and ply:IsOnGround() then
            local vel = ply:GetVelocity()
            local speed = vel:Length2D()
            
            if speed > 100 then
                cmd:SetForwardMove(cmd:GetForwardMove() * 1.2)
                cmd:SetSideMove(cmd:GetSideMove() * 1.2)
            end
        end
    end)
    
    hook.Add("HUDPaint", "BhopInfo", function()
        if not bhopEnabled:GetBool() then return end
        
        local ply = LocalPlayer()
        if not IsValid(ply) then return end
        
        local vel = ply:GetVelocity()
        local speed = math.Round(vel:Length2D())
        local units = "UPS"
        
        if GetConVarNumber("bhop_show_kph") == 1 then
            speed = math.Round(speed * 0.036) -- UPS to KM/H conversion
            units = "KM/H"
        end
        
        surface.SetFont("ChatFont")
        surface.SetTextColor(0, 255, 0, 255)
        surface.SetTextPos(10, ScrH() - 60)
        surface.DrawText("Speed: " .. speed .. " " .. units)
        
        surface.SetTextPos(10, ScrH() - 40)
        if ply:IsOnGround() then
            surface.SetTextColor(255, 255, 0, 255)
            surface.DrawText("On Ground")
        else
            surface.SetTextColor(0, 255, 255, 255)
            surface.DrawText("In Air")
        end
        
        -- Draw enabled status
        surface.SetTextPos(10, ScrH() - 20)
        surface.SetTextColor(255, 100, 100, 255)
        surface.DrawText("BHOP: " .. (bhopEnabled:GetBool() and "ON" or "OFF"))
    end)
    
    CreateClientConVar("bhop_show_kph", "0", true, false)
    CreateClientConVar("bhop_show_hud", "1", true, false)
    
    concommand.Add("toggle_bhop", function()
        RunConsoleCommand("bhop_enabled", bhopEnabled:GetBool() and "0" or "1")
        print("[BunnyHop] " .. (bhopEnabled:GetBool() and "Disabled" or "Enabled"))
    end)
    
    print("[BunnyHop] Script loaded. Commands:")
    print("  toggle_bhop - Toggle bunny hop")
    print("  bhop_enabled 0/1 - Enable/disable")
    print("  bhop_auto 0/1 - Auto-jump on/off")
    print("  bhop_speed X.X - Speed multiplier")
    
end

local HUD_COLOR = Color(0, 120, 255, 120)
local TEXT_COLOR = Color(0, 208, 255)

local Y_OFFSET = 200 -- increase this to move HUD higher

local hide = {
    ["CHudHealth"] = true,
    ["CHudBattery"] = true,
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true
}

hook.Add("HUDShouldDraw", "HideDefaultHUD", function(name)
    if hide[name] then return false end
end)

hook.Add("HUDPaint", "BlueTransparentHUD", function()
    local ply = LocalPlayer()
    if not IsValid(ply) then return end

    local w, h = ScrW(), ScrH()

    local baseY = h - Y_OFFSET

    -- Health
    draw.SimpleText("HP: " .. ply:Health(), "Trebuchet24", 30, baseY - 100, TEXT_COLOR)

    -- Armor
    draw.SimpleText("Armor: " .. ply:Armor(), "Trebuchet24", 30, baseY - 50, TEXT_COLOR)

    -- Ammo
    local wep = ply:GetActiveWeapon()
    if IsValid(wep) then
        local clip = wep:Clip1()
        local reserve = ply:GetAmmoCount(wep:GetPrimaryAmmoType())

        draw.SimpleText("Ammo: " .. clip .. " / " .. reserve, "Trebuchet24", w - 210, baseY - 70, TEXT_COLOR)
    end
end)

local FOV_VALUE = 120 -- adjust this (default is usually 75-90)

hook.Add("CalcView", "ForceHighFOV", function(ply, pos, angles, fov)
    if not IsValid(ply) then return end

    return {
        origin = pos,
        angles = angles,
        fov = FOV_VALUE,
        drawviewer = false
    }
end)
