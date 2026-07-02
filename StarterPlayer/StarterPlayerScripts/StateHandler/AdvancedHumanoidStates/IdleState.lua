--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Types = require( "../../Types" )
local Utils = require( "./Utils" )
local GameEnums = require( ReplicatedStorage.ModuleScripts.GameEnums )

local IdleState = {} 
IdleState.__index = IdleState

function IdleState.new( context : Types.StateStateMachineType ) : Types.AdvancedHumanoidStateType
	local self = setmetatable( {}, IdleState )
	
	self.context = context
	
	return self :: Types.AdvancedHumanoidStateType
end

function IdleState.isStateActive( self : Types.AdvancedHumanoidStateType ) : boolean
	local humanoid : Humanoid = self.context.humanoid
	return humanoid:GetState() == Enum.HumanoidStateType.Running and humanoid.MoveDirection.Magnitude < 0.5
end

function IdleState.onEnter( self : Types.AdvancedHumanoidStateType) end

function IdleState.whileActive( self : Types.AdvancedHumanoidStateType) 
	assert(workspace.CurrentCamera, "Current camera does not exist")
	Utils.lerpToWalkingSettings(self.context.humanoid, workspace.CurrentCamera)
end

function IdleState.onExit( self : Types.AdvancedHumanoidStateType) end

function IdleState.getStateName() : string
	return "Idle"
end

function IdleState.getStateEnum() : GameEnums.CustomStateType
	return GameEnums.CustomStateType.Idle
end

return IdleState