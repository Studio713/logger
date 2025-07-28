export type Token = {
	name: string?,
	text: string?,
	destructure: boolean?,
	raw: string?,
}

export type MessageTemplateImpl = {
	__index: MessageTemplateImpl,
	new: (messageTemplate: string) -> MessageTemplate,
	tokenize: (self: MessageTemplate, messageTemplate: string) -> { Token },
	getOutput: (self: MessageTemplate, ...unknown) -> string,
}
export type MessageTemplateProto = {
	raw: string,
	tokens: { Token },
}
export type MessageTemplate = typeof(setmetatable({} :: MessageTemplateProto, {} :: MessageTemplateImpl))

return nil
