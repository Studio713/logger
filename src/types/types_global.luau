export type LOG_LEVELS = "OFF" | "FATAL" | "ERROR" | "WARN" | "INFO" | "DEBUG"

export type LoggerConfiguration = {
	logLevel: LOG_LEVELS,
	debugCondition: () -> boolean,
}

return nil
