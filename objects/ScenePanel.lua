ScenePanel = Object:extend()

function ScenePanel:new()
	self.current = nil
end

function ScenePanel:draw()
	state.current().ui:layoutRow("dynamic", 20, 1)

	if state.current().ui:contextualBegin(100, 100, state.current().ui:windowGetBounds()) then
		state.current().ui:layoutRow("dynamic", 20, 1)

		if state.current().ui:contextualItem("NEW") then

		end

		if state.current().ui:contextualItem("SAVE") then

		end

		state.current().ui:contextualEnd()
	end
end