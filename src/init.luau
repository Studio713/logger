local configuration = require(script.configuration)
local enums = require(script.enums)
local log_event = require(script.log_event)
local types_log_event = require(script.types.types_log_event)
local types_logger = require(script.types.types_logger)

local Logger = {} :: types_logger.Logger

Logger.configuration = configuration

local function write(logmethod: (output: string) -> nil, event: types_log_event.LogEvent)
	if configuration.logLevel < enums.LOG_LEVELS[event.level] then
		return
	end
	if event.level == "DEBUG" and not configuration.debugCondition() then
		return
	end

	local message = event.messageTemplate:getOutput(event.args)

	logmethod(`[{event.level}]: {message}`)
end

function Logger.configure()
	return Logger.configuration
end

function Logger.fatal(messageTemplate, ...)
	local event = log_event.new("FATAL", messageTemplate, ...)
	write(error, event)
end
function Logger.error(messageTemplate, ...)
	local event = log_event.new("ERROR", messageTemplate, ...)
	write(error, event)
end
function Logger.warn(messageTemplate, ...)
	local event = log_event.new("WARN", messageTemplate, ...)
	write(warn, event)
end
function Logger.info(messageTemplate, ...)
	local event = log_event.new("INFO", messageTemplate, ...)
	write(print, event)
end
function Logger.debug(messageTemplate: string, ...)
	local event = log_event.new("DEBUG", messageTemplate, ...)
	write(print, event)
end

return Logger
