local Utils = {}

local UserInputService = game:GetService( "UserInputService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )

local StateSettings = require( ReplicatedStorage.ModuleScripts.StateSettings )
local Binds = require( ReplicatedStorage.ModuleScripts.Binds )
local GameEnums = require( ReplicatedStorage.ModuleScripts.GameEnums )

--[[
	math.lerp() walkspeed and FOV to sprint settings.
]]--
function Utils.lerpToSprintingSettings( humanoid : Humanoid, camera : Camera )
	local sprintSettings = StateSettings.SprintingStateSettings

	humanoid.WalkSpeed = math.lerp( humanoid.WalkSpeed, sprintSettings.WALK_SPEED, sprintSettings.INTERPOLATION_SPEED )
	camera.FieldOfView = math.lerp( camera.FieldOfView, sprintSettings.FOV, sprintSettings.INTERPOLATION_SPEED )
end

--[[
	math.lerp() walkspeed and FOV to walk settings.
]]--
function Utils.lerpToWalkingSettings( humanoid : Humanoid, camera : Camera )
	local walkingSettings = StateSettings.WalkingStateSetting	

	humanoid.WalkSpeed = math.lerp( humanoid.WalkSpeed, walkingSettings.WALK_SPEED, walkingSettings.INTERPOLATION_SPEED )
	camera.FieldOfView = math.lerp( camera.FieldOfView, walkingSettings.FOV, walkingSettings.INTERPOLATION_SPEED )
end


--[[
	Checks if the any action binded to sprint is active.
]]--
function Utils.isSprintRequested() : boolean
	return UserInputService:IsKeyDown( Binds.SPRINT_KEY )
end

--[[
	Checks if humanoid.MoveDirection.Magnitude is greater than 0.5
]]--
function Utils.isMoving( humanoid : Humanoid ) : boolean
	return humanoid.MoveDirection.Magnitude > 0.5
end


return Utils
