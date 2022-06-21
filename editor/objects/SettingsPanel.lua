SettingsPanel = Object:extend()

function SettingsPanel:new()
	self.open = false

	self.backgroundColor = nuklear.colorRGBA(0, 0, 0)

	self:load()
end

function SettingsPanel:load()
	local contents, message = lf.read(project .. "/settings.json")

	if contents then
		local settingsTable = json.decode(contents)

		self.backgroundColor = nuklear.colorRGBA(settingsTable.backgroundColor.r, settingsTable.backgroundColor.g, settingsTable.backgroundColor.b)

		sc().console:log("Loaded settings")
	else
		sc().console:log("Error loading settings: " .. message)
	end
end

function SettingsPanel:save()
	local r, g, b = nuklear.colorParseRGBA(self.backgroundColor)

	local settingsTable = {
		backgroundColor = {r = r, g = g, b = b}
	}

	local success, message = lf.write(project .. "/settings.json", json.encode(settingsTable))

	if success then
		sc().console:log("Saved settings")
	else
		sc().console:log("Error saving settings: " .. message)
	end
end

function SettingsPanel:draw()
	if sc().ui:treePush("node", "Background Color") then
		sc().ui:layoutRow("dynamic", 200, 1)

		self.backgroundColor = sc().ui:colorPicker(self.backgroundColor)

		sc().ui:treePop()
	end

	sc().ui:layoutRow("dynamic", 20, 1)

	if sc().ui:button("Save") then
		self:save()
		self.open = false
	end

	if sc().ui:button("Close") then
		self.open = false
	end
end