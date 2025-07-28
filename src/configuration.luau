local RunService = game:GetService("RunService")

local enums = require(script.Parent.enums)
local types_global = require(script.Parent.types.types_global)

local Configuration = {
	logLevel = enums.LOG_LEVELS.DEBUG,
	debugCondition = function()
		return RunService:IsStudio()
	end,
}

function Configuration.setMinimumLogLevel(level: types_global.LOG_LEVELS)
	Configuration.logLevel = enums.LOG_LEVELS[level]
	return Configuration
end

function Configuration.setDebugCondition(callback: () -> boolean)
	Configuration.debugCondition = callback
	return Configuration
end

return Configuration
