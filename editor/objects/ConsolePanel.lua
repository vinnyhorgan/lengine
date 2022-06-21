ConsolePanel = Object:extend()

function ConsolePanel:new()
	self.buffer = {}
	self.scroll = false
end

function ConsolePanel:log(text)
	local timestamp = os.date("[%H:%M:%S] ")

	table.insert(self.buffer, timestamp .. text)

	self.scroll = true
end

function ConsolePanel:draw()
	sc().ui:layoutRow("dynamic", 12, 1)

	for _, log in pairs(self.buffer) do
		sc().ui:label(log)
	end

	if self.scroll then
		local target = 0

		for _, log in pairs(self.buffer) do
			target = target + 12
		end

		sc().ui:windowSetScroll(0, target)

		self.scroll = false
	end
end