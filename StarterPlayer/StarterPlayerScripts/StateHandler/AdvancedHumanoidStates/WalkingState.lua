--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService( "UserInputService" )

local Types = require( "../../Types" )
local Utils = require( "./Utils" )
local GameEnums = require( ReplicatedStorage.ModuleScripts.GameEnums )

local IdleState = require("./IdleState")

local WalkingState = {}
WalkingState.__index = WalkingState

function WalkingState.new( context : Types.StateStateMachineType ) : Types.AdvancedHumanoidStateType
	local self = setmetatable( {}, WalkingState )
	
	self.context = context
	
	return self :: Types.AdvancedHumanoidStateType
end

function WalkingState.isStateActive( self : Types.AdvancedHumanoidStateType )
	local states = self.context.__states
	
	-- This is bad. "It's basically: If it's not any of the other states than ya it this state"
	-- I think the other way where it determines current state each heartbeat should be used
	return 
		Utils.isMoving(self.context.humanoid) and 
		not Utils.isSprintRequested() and
		not states[GameEnums.CustomStateType.InAir]:isStateActive()
end

function WalkingState.onEnter( self : Types.AdvancedHumanoidStateType ) end

function WalkingState.whileActive( self : Types.AdvancedHumanoidStateType )
	assert(workspace.CurrentCamera, "Current camera does not exist")
	Utils.lerpToWalkingSettings(self.context.humanoid, workspace.CurrentCamera)	
end

function WalkingState.onExit( self : Types.AdvancedHumanoidStateType ) end

function WalkingState.getStateName() : string
	return "Walking"
end

function WalkingState.getStateEnum() : GameEnums.CustomStateType
	return GameEnums.CustomStateType.Walking
end

return WalkingState
