--!strict

-- To avoid cyclical dependency problems theres a file where all types are stored
-- I don't know if this is the best way of doing it but I remember reading to do it like this in a DevForum post

local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Players = game:GetService("Players")

local GameEnums = require( ReplicatedStorage.ModuleScripts.GameEnums )

local Types = {}

-- I genuinely could not think of a better name.
-- This dude basically just handles advanced humanoid states. (Punching, being idle, sprinting, etc)
export type StateStateMachineType = {
	new: ( Model ) -> StateStateMachineType,

	getAbsoluteState: ( StateStateMachineType ) -> Enum.HumanoidStateType | GameEnums.CustomStateType,
	setState: ( StateStateMachineType, GameEnums.CustomStateType ) -> nil,
	__update: (StateStateMachineType) -> nil,
	init: ( StateStateMachineType ) -> nil,
	disconnect: ( StateStateMachineType ) -> nil,
	
	__connection : RBXScriptConnection,
	character : Model,
	humanoid : Humanoid,
	lastState : GameEnums.CustomStateType,
	customState : GameEnums.CustomStateType,
	__states : { AdvancedHumanoidStateType }
}

export type AdvancedHumanoidStateType = {
	new : ( StateStateMachineType ) -> AdvancedHumanoidStateType,
	isStateActive: ( AdvancedHumanoidStateType ) -> boolean,
	onEnter: ( AdvancedHumanoidStateType ) -> nil,
	whileActive: ( AdvancedHumanoidStateType ) -> nil,
	onExit: ( AdvancedHumanoidStateType ) -> nil,
	
	getStateName : () -> string,
	getStateEnum : () -> GameEnums.CustomStateType,
	
	context : StateStateMachineType
}

return Types
