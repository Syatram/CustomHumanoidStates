local CustomStateType = {
	Test = 0 :: CustomStateType,
	Punching = 1 :: CustomStateType,
	Sprinting = 2 :: CustomStateType,
	Idle = 3 :: CustomStateType,
	Walking = 4 :: CustomStateType,
	InAir = 5 :: CustomStateType
}

local Enums = {
	CustomStateType = CustomStateType :: typeof( CustomStateType )
}

export type CustomStateType = number
export type Enums = typeof( Enums )

return Enums :: Enums
