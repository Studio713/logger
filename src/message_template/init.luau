local types_message_template = require(script.Parent.types.types_message_template)
local data_types = require(script.data_types)

local tokenTemplate = "{@?[%w_]+}"

local MessageTemplateImpl = {} :: types_message_template.MessageTemplateImpl
MessageTemplateImpl.__index = MessageTemplateImpl

local function destructureData(data: unknown)
	local result

	local dataType = typeof(data)
	local destructor = data_types[dataType]
	if destructor then
		result = destructor()
	else
		result = data_types["default"]
	end

	return tostring(result)
end

function MessageTemplateImpl.new(messageTemplate)
	local self = setmetatable({} :: types_message_template.MessageTemplateProto, MessageTemplateImpl)

	self.raw = messageTemplate
	self.tokens = self:tokenize(messageTemplate)

	return self
end

function MessageTemplateImpl:getOutput(args: { unknown })
	if #self.tokens == 0 then
		return self.raw
	end

	local result: { string } = {}
	local lastArg = 1

	for i = 1, #self.tokens do
		local token = self.tokens[i]
		if typeof(token.name) == "string" then
			if token.destructure then
				table.insert(result, destructureData(args[lastArg]))
				lastArg += 1
			else
				table.insert(result, tostring(args[lastArg]))
				lastArg += 1
			end
		else
			table.insert(result, token.text)
		end
	end

	return table.concat(result, "")
end

function MessageTemplateImpl:tokenize(messageTemplate)
	local tokens = {} :: { types_message_template.Token }

	local lastEnd = 0

	local iterator = messageTemplate:gmatch("()(" .. tokenTemplate .. ")()")

	for startPos, match, endPos in iterator do
		if startPos > lastEnd then
			table.insert(tokens, { text = messageTemplate:sub(lastEnd, startPos - 1) })
		end

		local inner = match:sub(2, -2)
		local destructure = false

		if inner:sub(1, 1) == "@" then
			destructure = true
		end

		table.insert(tokens, { name = inner, destructure = destructure, raw = match })

		lastEnd = endPos
	end

	if lastEnd <= #messageTemplate then
		table.insert(tokens, { text = messageTemplate:sub(lastEnd) })
	end

	return tokens
end

return MessageTemplateImpl
