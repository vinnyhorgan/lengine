ScenePanel = Object:extend()

function ScenePanel:new()
	self.currentScene = nil

	self.save = false

	signal.register("popupAccept", function(name)
		if self.save then
			self:saveScene(name)
			self.save = false
		end
	end)
end

function ScenePanel:newScene()
	self.currentScene = {
		name = "unsaved",
		entities = {}
	}
end

function ScenePanel:saveScene(name)
	if self.currentScene then
		self.currentScene.name = name
		lf.write(project .. "/scenes/" .. self.currentScene.name .. ".json", json.encode(self.currentScene))
	end
end

function ScenePanel:loadScene(scene)
	sc.console:log("Loading " .. scene)

	self.currentScene = json.decode(lf.read(project .. "/scenes/" .. scene))
end

function ScenePanel:draw()
	sc.ui:layoutRow("dynamic", 20, 1)

	if sc.ui:contextualBegin(100, 100, sc.ui:windowGetBounds()) then
		sc.ui:layoutRow("dynamic", 20, 1)

		if sc.ui:contextualItem("NEW") then
			self:newScene()
		end

		if sc.ui:contextualItem("SAVE") then
			if self.currentScene then
				if self.currentScene.name == "unsaved" then
					sc.popup = true
					self.save = true
				else
					self:saveScene(self.currentScene.name)
				end
			end
		end

		sc.ui:contextualEnd()
	end

	if self.currentScene then
		sc.ui:label("NAME: " .. self.currentScene.name)

		for _, entity in pairs(self.currentScene.entities) do
			if sc.ui:button(entity.name) then
				sc.entity.currentEntity = entity
			end
		end
	end
end