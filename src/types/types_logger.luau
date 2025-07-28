local types_global = require(script.Parent.types_global)
type configuration = {
	setMinimumLogLevel: (level: types_global.LOG_LEVELS) -> configuration,
	setDebugCondition: (callback: () -> boolean) -> configuration,
}
export type Logger = {
	configure: () -> configuration,
	fatal: (messageTemplate: string, ...unknown) -> nil,
	error: (messageTemplate: string, ...unknown) -> nil,
	warn: (messageTemplate: string, ...unknown) -> nil,
	info: (messageTemplate: string, ...unknown) -> nil,
	debug: (messageTemplate: string, ...unknown) -> nil,
}

return nil
