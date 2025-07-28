local types_global = require(script.Parent.types_global)
local types_message_template = require(script.Parent.types_message_template)

export type LogEventImpl = {
	__index: LogEventImpl,
	new: (logLevel: types_global.LOG_LEVELS, messageTemplate: string, ...unknown) -> LogEvent,
}
export type LogEventProto = {
	messageTemplate: types_message_template.MessageTemplate, -- Replace with messagetemplate type
	level: types_global.LOG_LEVELS,
	args: { unknown },
}
export type LogEvent = typeof(setmetatable({} :: LogEventProto, {} :: LogEventImpl))

return nil
