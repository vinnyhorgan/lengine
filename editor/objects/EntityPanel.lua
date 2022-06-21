EntityPanel = Object:extend()

function EntityPanel:new()
	self.currentEntity = nil

	self.transformXInput = {value = ""}
	self.transformYInput = {value = ""}
	self.spriterendererTextureInput = {value = ""}
	self.scriptScriptInput = {value = ""}
end

function EntityPanel:newEntity(name)
	if sc().scene.currentScene then
		local entity = {
			id = uuid(),
			name = name,
			components = {
				{name = "transform", x = 0, y = 0}
			}
		}

		table.insert(sc().scene.currentScene.entities, entity)

		self.currentEntity = entity

		sc().console:log("Created entity: " .. name)
	else
		sc().console:log("Cannot create entity: no scene loaded")
	end
end

function EntityPanel:addComponent(name)
	if self.currentEntity then
		if name == "spriterenderer" then
			table.insert(self.currentEntity.components, {
				name = "spriterenderer",
				texture = ""
			})

			sc().console:log("Added component: Sprite Renderer")
		elseif name == "script" then
			table.insert(self.currentEntity.components, {
				name = "script",
				script = ""
			})

			sc().console:log("Added component: Script")
		else
			sc().console:log("Error adding component: " .. name .. " does not exist")
		end
	else
		sc().console:log("Cannot add component: no entity selected")
	end
end

function EntityPanel:draw()
	sc().ui:layoutRow("dynamic", 20, 1)

	if self.currentEntity then
		sc().ui:label("NAME: " .. self.currentEntity.name)

		for _, component in pairs(self.currentEntity.components) do
			sc().ui:layoutRow("dynamic", 25, 1)

			sc().ui:label(component.name)

			sc().ui:layoutRow("dynamic", 25, 2)

			if component.name == "transform" then
				sc().ui:label("X " .. component.x)
				sc().ui:edit("simple", self.transformXInput)
				sc().ui:label("Y " .. component.y)
				sc().ui:edit("simple", self.transformYInput)

				if sc().ui:button("Save") then
					component.x = tonumber(self.transformXInput.value) or component.x
					component.y = tonumber(self.transformYInput.value) or component.y
				end
			elseif component.name == "spriterenderer" then
				sc().ui:label("TEXTURE " .. component.texture)
				sc().ui:edit("simple", self.spriterendererTextureInput)

				if sc().ui:button("Save") then
					component.texture = self.spriterendererTextureInput.value
					sc().scene:loadImages()
				end
			elseif component.name == "script" then
				sc().ui:label("SRIPT " .. component.script)
				sc().ui:edit("simple", self.scriptScriptInput)

				if sc().ui:button("Save") then
					component.script = self.scriptScriptInput.value
				end
			end
		end
	end
end