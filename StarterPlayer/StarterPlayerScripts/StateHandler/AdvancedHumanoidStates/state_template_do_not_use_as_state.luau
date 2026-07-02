-- To make adding new states earlier I have this file so I can just copy and paste the code in and then replace "Template" with the necessary word

local TemplateState = {}
TemplateState.__index = TemplateState

local ReplicatedStorage = game:GetService( "ReplicatedStorage" )

local Types = require( "../../Types" )
local GameEnums = require( ReplicatedStorage.ModuleScripts.GameEnums )

function TemplateState.new( context : Types.StateStateMachineType ) : Types.AdvancedHumanoidStateType
	local self = setmetatable( {}, TemplateState )
	
	self.context = context
	
	return self
end

function TemplateState.isStateActive( self : Types.AdvancedHumanoidStateType ) : boolean
	return false
end

function TemplateState.onEnter( self : Types.AdvancedHumanoidStateType ) end
function TemplateState.whileActive( self : Types.AdvancedHumanoidStateType ) end
function TemplateState.onExit( self : Types.AdvancedHumanoidStateType ) end

function TemplateState.getStateName() : string
	return "Template"
end

function TemplateState.getStateEnum() : number
	return GameEnums.CustomStateType.Template
end

return TemplateState
