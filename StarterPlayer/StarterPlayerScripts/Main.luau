-- Quick implementation for testing. Don't expect it to stay like this. I'd prefer a 

local Types = require("./Types")
local StateStateMachine = require("./StateHandler/StateStateMachine")
local AnimationHandler = require("./StateHandler/AnimationHandler")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Main = {}
Main.__index = Main

local stateStateMachine = nil
local FPSRig = nil

local animationHandler = nil

local function onCharacterAdded( character : Model )
	FPSRig = ReplicatedStorage.FPSRig:Clone()
	FPSRig.Parent = workspace
	
	character:WaitForChild("Humanoid")
	print("Humanoid loaded")
	
	stateStateMachine = StateStateMachine.new(character)
	stateStateMachine:init()
	
	animationHandler = AnimationHandler.new(stateStateMachine)
	animationHandler:init(FPSRig)
end

local function onCharacterRemoving( character : Model )
	stateStateMachine.disconnect()
	animationHandler.disconnect()
end

function Main.new()
	local self = setmetatable( {}, Main )
	
	self.player = Players.LocalPlayer :: Player
	
	self.player.CharacterAdded:Connect(onCharacterAdded)
	return self
end

return Main.new()
