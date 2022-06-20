EntityPanel = Object:extend()

function EntityPanel:new()
	self.currentEntity = nil

	self.create = false

	signal.register("popupAccept", function(name)
		if self.create then
			self:newEntity(name)
			self.create = false
		end
	end)

	self.transformXInput = {value = ""}
	self.transformYInput = {value = ""}
end

function EntityPanel:newEntity(name)
	if sc.scene.currentScene then
		local entity = {
			id = uuid(),
			name = name,
			components = {
				{name = "transform", x = 0, y = 0}
			}
		}

		table.insert(sc.scene.currentScene.entities, entity)

		self.currentEntity = entity
	end
end

function EntityPanel:addComponent()
	if self.currentEntity then

	end
end

function EntityPanel:draw()
	sc.ui:layoutRow("dynamic", 20, 1)

	if sc.ui:contextualBegin(150, 100, sc.ui:windowGetBounds()) then
		sc.ui:layoutRow("dynamic", 20, 1)

		if sc.ui:contextualItem("NEW") then
			sc.popup = true
			self.create = true
		end

		if sc.ui:contextualItem("ADD COMPONENT") then
			self:addComponent()
		end

		sc.ui:contextualEnd()
	end

	if self.currentEntity then
		sc.ui:label("NAME: " .. self.currentEntity.name)

		for _, component in pairs(self.currentEntity.components) do
			sc.ui:label(component.name)

			sc.ui:layoutRow("dynamic", 20, 2)

			if component.name == "transform" then
				sc.ui:label("X " .. component.x)
				sc.ui:edit("simple", self.transformXInput)
				sc.ui:label("Y " .. component.y)
				sc.ui:edit("simple", self.transformYInput)

				if sc.ui:button("Save") then
					component.x = tonumber(self.transformXInput.value)
					component.y = tonumber(self.transformYInput.value)
				end
			end
		end
	end
end