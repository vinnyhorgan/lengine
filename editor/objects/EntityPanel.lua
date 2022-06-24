EntityPanel = Object:extend()

function EntityPanel:new()
	self.currentEntity = nil

	self.transformXInput = {value = ""}
	self.transformYInput = {value = ""}
	self.transformRotationInput = {value = ""}
	self.transformScaleXInput = {value = ""}
	self.transformScaleYInput = {value = ""}
	self.spriterendererTextureInput = {value = ""}
	self.scriptScriptInput = {value = ""}
end

function EntityPanel:newEntity(name)
	if sc().scene.currentScene then
		local entity = {
			id = uuid(),
			name = name,
			components = {
				{name = "transform", x = 100, y = 100, rotation = 0, scaleX = 1, scaleY = 1}
			}
		}

		table.insert(sc().scene.currentScene.entities, entity)

		self.currentEntity = entity

		sc().console:log("Created entity: " .. name)
	else
		sc().console:log("Cannot create entity: no scene loaded")
	end
end

function EntityPanel:deleteEntity(entity)
	for i, e in pairs(sc().scene.currentScene.entities) do
		if e.id == entity.id then
			table.remove(sc().scene.currentScene.entities, i)
		end
	end

	self.currentEntity = nil
end

function EntityPanel:addComponent(name)
	if self.currentEntity then
		local hasComponent = getComponent(self.currentEntity, name)

		if not hasComponent then
			if name == "spriterenderer" then
				table.insert(self.currentEntity.components, {
					name = "spriterenderer",
					texture = ""
				})

				sc().console:log("Added component: Sprite Renderer")
			elseif name == "script" then
				table.insert(self.currentEntity.components, {
					name = "script",
					file = ""
				})

				sc().input:addScript()

				sc().console:log("Added component: Script")
			elseif name == "rigidbody" then
				table.insert(self.currentEntity.components, {
					name = "rigidbody",
				})
			else
				sc().console:log("Error adding component: " .. name .. " does not exist")
			end
		else
			sc().console:log("Cannot add component: already added")
		end
	else
		sc().console:log("Cannot add component: no entity selected")
	end
end

function EntityPanel:addScript(name)
	local success, message = lf.write(project .. "/scripts/" .. name .. ".lua", "")

	if success then
		getComponent(self.currentEntity, "script").file = name

		sc().console:log("Created script: " .. name .. ".lua")
	else
		sc().console:log("Error creating script: " .. message)
	end
end

function EntityPanel:draw()
	sc().ui:layoutRow("dynamic", 20, 1)

	if self.currentEntity then
		sc().ui:label("NAME: " .. self.currentEntity.name)

		for _, component in pairs(self.currentEntity.components) do
			sc().ui:layoutRow("dynamic", 25, 1)

			sc().ui:spacing(1)

			if component.name == "transform" then
				sc().ui:label("Transform")

				sc().ui:label("X " .. component.x)

				if sc().ui:edit("simple", self.transformXInput) == "active" and lk.isDown("return") then
					component.x = tonumber(self.transformXInput.value)
				end

				sc().ui:label("Y " .. component.y)

				if sc().ui:edit("simple", self.transformYInput) == "active" and lk.isDown("return") then
					component.y = tonumber(self.transformYInput.value)
				end

				sc().ui:label("ROTATION " .. component.rotation)

				if sc().ui:edit("simple", self.transformRotationInput) == "active" and lk.isDown("return") then
					component.rotation = tonumber(self.transformRotationInput.value)
				end

				sc().ui:label("SCALE X " .. component.scaleX)

				if sc().ui:edit("simple", self.transformScaleXInput) == "active" and lk.isDown("return") then
					component.scaleX = tonumber(self.transformScaleXInput.value)
				end

				sc().ui:label("SCALE Y " .. component.scaleY)

				if sc().ui:edit("simple", self.transformScaleYInput) == "active" and lk.isDown("return") then
					component.scaleY = tonumber(self.transformScaleYInput.value)
				end
			elseif component.name == "spriterenderer" then
				sc().ui:label("Sprite Renderer")

				sc().ui:label("TEXTURE " .. component.texture)

				if sc().ui:edit("simple", self.spriterendererTextureInput) == "active" and lk.isDown("return") then
					component.texture = self.spriterendererTextureInput.value
					sc().scene:loadImages()
				end
			elseif component.name == "script" then
				sc().ui:label("Script")

				sc().ui:label("FILE " .. component.file)

				if sc().ui:edit("simple", self.scriptScriptInput) == "active" and lk.isDown("return") then
					component.file = self.scriptScriptInput.value
				end
			elseif component.name == "rigidbody" then
				sc().ui:label("Rigid Body")
			end

			if component.name ~= "transform" then
				if sc().ui:button("Remove") then
					removeComponent(self.currentEntity, component.name)
				end
			end
		end

		sc().ui:spacing(1)

		if sc().ui:button("Delete Entity") then
			self:deleteEntity(self.currentEntity)
		end
	end
end