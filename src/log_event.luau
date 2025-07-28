local message_template = require(script.Parent.message_template)
local types_log_event = require(script.Parent.types.types_log_event)

local LogEventImpl = {} :: types_log_event.LogEventImpl
LogEventImpl.__index = LogEventImpl

function LogEventImpl.new(logLevel, messageTemplate, ...)
	local self = setmetatable({} :: types_log_event.LogEventProto, LogEventImpl)

	self.messageTemplate = message_template.new(messageTemplate)
	self.timestamp = DateTime.now():ToIsoDate()
	self.level = logLevel
	self.args = { ... } -- Array of args

	return self
end

return LogEventImpl
