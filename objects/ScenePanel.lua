ScenePanel = Object:extend()

function ScenePanel:new()
	self.currentScene = nil
end

function ScenePanel:newScene()
	self.currentScene = {
		name = "unsaved",
		entities = {}
	}
end

function ScenePanel:saveScene()
	if self.currentScene then
		print(lf.write(project .. "/scenes/" .. self.currentScene.name .. ".json", json.encode(self.currentScene)))
	end
end

function ScenePanel:loadScene(scene)
	state.current().console:log("Loading " .. scene)

	self.currentScene = json.decode(lf.read(project .. "/scenes/" .. scene))
end

function ScenePanel:draw()
	state.current().ui:layoutRow("dynamic", 20, 1)

	if state.current().ui:contextualBegin(100, 100, state.current().ui:windowGetBounds()) then
		state.current().ui:layoutRow("dynamic", 20, 1)

		if state.current().ui:contextualItem("NEW") then
			self:newScene()
		end

		if state.current().ui:contextualItem("SAVE") then
			self:saveScene()
		end

		state.current().ui:contextualEnd()
	end

	if self.currentScene then
		state.current().ui:label("NAME: " .. self.currentScene.name)

		for _, entity in pairs(self.currentScene.entities) do
			state.current().ui:label(entity.name)
		end
	end
end