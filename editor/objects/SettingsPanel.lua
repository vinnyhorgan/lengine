SettingsPanel = Object:extend()

function SettingsPanel:new()
	self.open = false

	self.runCommandInput = {value = ""}
	self.editCommandInput = {value = ""}
	self.backgroundColor = nuklear.colorRGBA(0, 0, 0)
	self.filterInput = {value = ""}
	self.widthInput = {value = ""}
	self.heightInput = {value = ""}

	self:load()
end

function SettingsPanel:load()
	local contents, message = lf.read(project .. "/settings.json")

	if contents then
		local settingsTable = json.decode(contents)

		self.runCommandInput.value = settingsTable.runCommand
		self.editCommandInput.value = settingsTable.editCommand
		self.backgroundColor = nuklear.colorRGBA(settingsTable.backgroundColor.r, settingsTable.backgroundColor.g, settingsTable.backgroundColor.b)
		self.filterInput.value = settingsTable.filter
		self.widthInput.value = settingsTable.width
		self.heightInput.value = settingsTable.height

		sc().console:log("Loaded settings")
	else
		sc().console:log("Error loading settings: " .. message)
	end
end

function SettingsPanel:save()
	local r, g, b = nuklear.colorParseRGBA(self.backgroundColor)

	local settingsTable = {
		runCommand = self.runCommandInput.value,
		editCommand = self.editCommandInput.value,
		backgroundColor = {r = r, g = g, b = b},
		filter = self.filterInput.value,
		width = self.widthInput.value,
		height = self.heightInput.value
	}

	local success, message = lf.write(project .. "/settings.json", json.encode(settingsTable))

	if success then
		sc().console:log("Saved settings")
	else
		sc().console:log("Error saving settings: " .. message)
	end
end

function SettingsPanel:draw()
	if sc().ui:treePush("node", "Custom Commands") then
		sc().ui:layoutRow("dynamic", 30, 1)

		sc().ui:label("Run command")
		sc().ui:edit("simple", self.runCommandInput)
		sc().ui:label("Code editor command")
		sc().ui:edit("simple", self.editCommandInput)

		sc().ui:treePop()
	end

	if sc().ui:treePush("node", "Graphics") then
		sc().ui:layoutRow("dynamic", 30, 1)

		sc().ui:label("Window Width")
		sc().ui:edit("simple", self.widthInput)

		sc().ui:label("Window Height")
		sc().ui:edit("simple", self.heightInput)

		sc().ui:label("Filter ('blur', 'pixel')")
		sc().ui:edit("simple", self.filterInput)

		sc().ui:treePop()
	end

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