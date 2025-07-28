local HttpService = game:GetService("HttpService")

local DataDestructors: { [string]: (data: unknown) -> string } = {
	Color3 = function(data)
		local color = data :: Color3
		return `\{R: {color.R},G: {color.G},B: {color.B}\}`
	end,
	table = function(data)
		return HttpService:JSONEncode(data)
	end,
	UDim = function(data)
		local udim = data :: UDim
		return `\{Scale: {udim.Scale}, Offset: {udim.Offset}\}`
	end,
	UDim2 = function(data)
		local udim = data :: UDim2
		return `\{X: \{Scale: {udim.X.Scale}, Offset: {udim.X.Offset}\}, Y: \{Scale: {udim.Y.Scale}, Offset: {udim.Y.Offset}\}\}`
	end,
	Vector2 = function(data)
		local vector = data :: Vector2
		return `\{X: {vector.X}, Y: {vector.Y}\}`
	end,
	Vector3 = function(data)
		local vector = data :: Vector3
		return `\{X: {vector.X}, Y: {vector.Y}, Z: {vector.Z}\}`
	end,
	CFrame = function(data)
		local cframe = data :: CFrame
		local cframeOrientation = { cframe:ToOrientation() }
		return `\{Position: \{X: {cframe.X}, Y: {cframe.Y}, Z: {cframe.Z}\}, Orientation: \{X: {cframeOrientation[1]},Y: {cframeOrientation[2]},Z: {cframeOrientation[3]}\}\}`
	end,
	default = function(data)
		return tostring(data)
	end,
}

return DataDestructors
