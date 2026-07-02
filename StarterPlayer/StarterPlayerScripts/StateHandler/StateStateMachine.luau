--!strict
-- Services --
local RunService = game:GetService( "RunService" )
local ReplicatedStorage = game:GetService( "ReplicatedStorage" )
local Players = game:GetService( "Players" )

-- Modules --
local GameEnums = require( ReplicatedStorage.ModuleScripts.GameEnums )
local Types = require( ".././Types" )

-- Advanced Humanoid States --
local IdleState = require( "./AdvancedHumanoidStates/IdleState" )
local SprintingState = require( "./AdvancedHumanoidStates/SprintingState" )
local PunchingState = require( "./AdvancedHumanoidStates/PunchingState" )
local WalkingState = require( "./AdvancedHumanoidStates/WalkingState" )
local InAirState = require( "./AdvancedHumanoidStates/InAirState" )

local StateStateMachine = {}
StateStateMachine.__index = StateStateMachine

--[[
	Creates a new StateStateMachine with the character specified
]]--
function StateStateMachine.new( character : Model ) : Types.StateStateMachineType
	local self = setmetatable( {}, StateStateMachine ) :: Types.StateStateMachineType
	
	self.customState = GameEnums.CustomStateType.Idle
	self.character = character
	self.humanoid = character:FindFirstChildWhichIsA( "Humanoid" ) :: Humanoid
	
	-- Initialize all states
	self.__states = {
		[ GameEnums.CustomStateType.Idle ] = IdleState.new( self ),
		[ GameEnums.CustomStateType.Sprinting ] = SprintingState.new( self ),
		[ GameEnums.CustomStateType.Punching ] = PunchingState.new( self ),
		[ GameEnums.CustomStateType.Walking ] = WalkingState.new( self ),
		[ GameEnums.CustomStateType.InAir ] = InAirState.new( self )
	}
	
	return self 
end

--[[
	Changes the state of the state machine. Crazy...
]]--
function StateStateMachine.setState( self : Types.StateStateMachineType, newState : GameEnums.CustomStateType )
	self.customState = newState
end

--[[
	Updates the state of the machine.
]]--
function StateStateMachine.__update( self : Types.StateStateMachineType )
	local state = self.__states[self.customState]
	
	-- Check if current state is active
	if state:isStateActive() then
		state:whileActive()
		return 
	end
	
	-- Find the first state which is considered active
	for _, s in self.__states do
		if s:isStateActive() then
			self.lastState = self.customState
			self.customState = s.getStateEnum()
			return
		end
	end
	
	error("No active state could be found", 2)
end

--[[
	Creates a heartbeat connection.
]]--
function StateStateMachine.init( self : Types.StateStateMachineType )
	StateStateMachine.__connection =  RunService.Heartbeat:Connect( function()
		self:__update()
	end)
end

--[[
	Disconnects the heartbeat connection
]]--
function StateStateMachine.disconnect( self : Types.StateStateMachineType )
	StateStateMachine.__connection:Disconnect()
end

return StateStateMachine
