export = logger;
export as namespace logger;

declare namespace logger {
  type LogLevel = "OFF" | "FATAL" | "ERROR" | "WARN" | "INFO" | "DEBUG";
  interface Configuration {
    setMinimumLogLevel: (level: LogLevel) => Configuration;
    setDebugCondition: (callback: () => boolean) => Configuration;
  }

  export function configure(): Configuration;

  export function fatal(messageTemplate: string, ...args: unknown[]): void;
  export function error(messageTemplate: string, ...args: unknown[]): void;
  export function warn(messageTemplate: string, ...args: unknown[]): void;
  export function info(messageTemplate: string, ...args: unknown[]): void;
  export function debug(messageTemplate: string, ...args: unknown[]): void;
}
