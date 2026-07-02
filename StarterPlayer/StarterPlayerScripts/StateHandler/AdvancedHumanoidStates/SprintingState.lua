--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService( "UserInputService" )

local Types = require( "../../Types" )
local Utils = require( "./Utils" )

local Binds = require( ReplicatedStorage.ModuleScripts.Binds )
local GameEnums = require( ReplicatedStorage.ModuleScripts.GameEnums )
local Settings = require( ReplicatedStorage.ModuleScripts.StateSettings ).SprintingStateSettings

local SprintingState = {}
SprintingState.__index = SprintingState

function SprintingState.new( context : Types.StateStateMachineType ) : Types.AdvancedHumanoidStateType
	local self = setmetatable( {}, SprintingState )
	
	self.context = context
	
	return self :: Types.AdvancedHumanoidStateType
end

function SprintingState.isStateActive( self : Types.AdvancedHumanoidStateType ) : boolean
	local states = self.context.__states
	
	return 
		Utils.isSprintRequested() and 
		Utils.isMoving( self.context.humanoid ) and
		not states[GameEnums.CustomStateType.InAir]:isStateActive()
end

function SprintingState.onEnter( self : Types.AdvancedHumanoidStateType ) end

function SprintingState.whileActive( self : Types.AdvancedHumanoidStateType )
	assert(workspace.CurrentCamera, "Current camera does not exist")
	Utils.lerpToSprintingSettings(self.context.humanoid, workspace.CurrentCamera)
end

function SprintingState.onExit( self : Types.AdvancedHumanoidStateType ) end

function SprintingState.getStateName()
	return "Sprinting"
end

function SprintingState.getStateEnum()
	return GameEnums.CustomStateType.Sprinting
end

return SprintingState
