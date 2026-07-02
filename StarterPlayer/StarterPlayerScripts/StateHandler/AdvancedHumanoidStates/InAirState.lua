--!strict
local InAirState = {}
InAirState.__index = InAirState

local ReplicatedStorage = game:GetService( "ReplicatedStorage" )

local Types = require( "../../Types" )
local GameEnums = require( ReplicatedStorage.ModuleScripts.GameEnums )

function InAirState.new( context : Types.StateStateMachineType ) : Types.AdvancedHumanoidStateType
	local self = setmetatable( {}, InAirState )
	
	self.context = context

	return self
end

function InAirState.isStateActive( self : Types.AdvancedHumanoidStateType ) : boolean
	return self.context.humanoid.FloorMaterial == Enum.Material.Air
end

function InAirState.onEnter( self : Types.AdvancedHumanoidStateType ) end
function InAirState.whileActive( self : Types.AdvancedHumanoidStateType ) end
function InAirState.onExit( self : Types.AdvancedHumanoidStateType ) end

function InAirState.getStateName() : string
	return "In Air"
end

function InAirState.getStateEnum() : number
	return GameEnums.CustomStateType.InAir
end

return InAirState
