Console = Object:extend()

function Console:new()
	self.buffer = {}
	self.scroll = false
end

function Console:log(text)
	local timestamp = os.date("[%H:%M:%S] ")

	table.insert(self.buffer, timestamp .. text)

	self.scroll = true
end

function Console:draw()
	state.current().ui:layoutRow("dynamic", 12, 1)

	for _, log in pairs(self.buffer) do
		state.current().ui:label(log)
	end

	if self.scroll then
		local target = 0

		for _, log in pairs(self.buffer) do
			target = target + 12
		end

		state.current().ui:windowSetScroll(0, target)

		self.scroll = false
	end
end