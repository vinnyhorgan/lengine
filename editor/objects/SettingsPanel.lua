SettingsPanel = Object:extend()

function SettingsPanel:new()
	self.open = false
end

function SettingsPanel:draw()
	sc.ui:layoutRow("dynamic", 20, 1)

	sc.ui:label("BRUH")

	if sc.ui:button("Close") then
		self.open = false
	end
end