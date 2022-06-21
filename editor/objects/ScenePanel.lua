ScenePanel = Object:extend()

function ScenePanel:new()
	lf.createDirectory(project)
	lf.createDirectory(project .. "/scenes")

	self.currentScene = nil

	self.imageCache = {}
end

function ScenePanel:run()
	if self.currentScene then
		os.execute("love ../runtime " .. self.currentScene.name)

		sc().console:log("Running scene: " .. self.currentScene.name)
	else
		sc().console:log("Cannot run: no scene loaded")
	end
end

function ScenePanel:newScene()
	self.currentScene = {
		name = "unsaved",
		entities = {}
	}

	sc().console:log("Created new scene")
end

function ScenePanel:saveScene(name)
	if self.currentScene then
		self.currentScene.name = name
		local success, message = lf.write(project .. "/scenes/" .. self.currentScene.name .. ".json", json.encode(self.currentScene))

		if success then
			sc().console:log("Saved scene: " .. self.currentScene.name)
		else
			sc().console:log("Error saving scene: " .. message)
		end
	else
		sc().console:log("Cannot save: no scene loaded")
	end
end

function ScenePanel:loadScene(scene)
	local contents, message = lf.read(project .. "/scenes/" .. scene)

	if contents then
		self.currentScene = json.decode(contents)
		self:loadImages()

		sc().console:log("Loaded scene: " .. self.currentScene.name)
	else
		sc().console:log("Error loading scene: " .. message)
	end
end

function ScenePanel:loadImages()
	for _, entity in pairs(self.currentScene.entities) do
		local spriterenderer = getComponent(entity, "spriterenderer")

		if spriterenderer then
			if spriterenderer.texture ~= "" then
				local exists = lf.getInfo(spriterenderer.texture)

				if exists then
					self.imageCache[entity.id] = lg.newImage(spriterenderer.texture)

					sc().console:log("Loaded texture: " .. spriterenderer.texture)
				end
			end
		end
	end
end

function ScenePanel:draw()
	sc().ui:layoutRow("dynamic", 20, 1)

	if sc().ui:menuBegin("Menu", nil, 150, 300) then
		sc().ui:layoutRow("dynamic", 20, 1)

		if sc().ui:menuItem("New Scene") then
			self:newScene()
		end

		if sc().ui:menuItem("Save Scene") then
			if self.currentScene then
				if self.currentScene.name == "unsaved" then
					sc().input:saveScene()
				else
					self:saveScene(self.currentScene.name)
				end
			end
		end

		if sc().ui:menuItem("Run") then
			self:run()
		end

		if sc().ui:menuItem("New Entity") then
			sc().input:newEntity()
		end

		if sc().ui:treePush("node", "Add Component") then
			if sc().ui:menuItem("Sprite Renderer") then
				sc().entity:addComponent("spriterenderer")
			end

			if sc().ui:menuItem("Script") then
				sc().entity:addComponent("script")
			end

			sc().ui:treePop()
		end

		if sc().ui:menuItem("Settings") then
			sc().settings.open = true
		end

		if sc().ui:menuItem("About") then
			sc().about.open = true
		end

		sc().ui:menuEnd()
	end

	if self.currentScene then
		sc().ui:label("NAME: " .. self.currentScene.name)

		for _, entity in pairs(self.currentScene.entities) do
			if sc().ui:button(entity.name) then
				sc().entity.currentEntity = entity

				sc().console:log("Selected entity: " .. entity.name)
			end
		end
	end
end