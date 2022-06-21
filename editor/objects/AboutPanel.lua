AboutPanel = Object:extend()

function AboutPanel:new()
	self.open = false
end

function AboutPanel:draw()
	sc.ui:layoutRow("dynamic", 20, 1)

	sc.ui:label("Lengine by Vinny Horgan")
	sc.ui:label("©2022")

	if sc.ui:button("Close") then
		self.open = false
	end
end