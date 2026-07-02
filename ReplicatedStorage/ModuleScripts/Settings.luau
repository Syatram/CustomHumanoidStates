-- Basically all of the consts which are values that come out of my ass go here so I can change them easily
-- Ex: Since things like walking speed or fov are kinda arbitrary I put it here to be easily changed

local SprintingStateSettings = {
	[ "FOV" ] = 90,
	[ "WALK_SPEED" ] = 25,
	[ "INTERPOLATION_SPEED" ] = 0.05
}

local WalkingStateSettings = {
	[ "FOV" ] = 70,
	[ "WALK_SPEED" ] = 16,
	[ "INTERPOLATION_SPEED" ] = 0.05
}

local StateSettings = {
	SprintingStateSettings = SprintingStateSettings,
	WalkingStateSetting = WalkingStateSettings
}

return StateSettings
