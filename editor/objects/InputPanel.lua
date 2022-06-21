InputPanel = Object:extend()

function InputPanel:new()
	self.open = false
	self.mode = nil

	self.input = {value = ""}
end

function InputPanel:saveScene()
	self.open = true
	self.mode = "saveScene"
end

function InputPanel:newEntity()
	self.open = true
	self.mode = "newEntity"
end

function InputPanel:draw()
	sc.ui:layoutRow("dynamic", 30, 1)

	if self.mode == "saveScene" then
		sc.ui:label("Scene Name")
		sc.ui:edit("simple", self.input)

		sc.ui:spacing(1)

		if sc.ui:button("Save") then
			sc.scene:saveScene(self.input.value)
			self.input.value = ""
			self.open = false
		end
	elseif self.mode == "newEntity" then
		sc.ui:label("Entity Name")
		sc.ui:edit("simple", self.input)

		sc.ui:spacing(1)

		if sc.ui:button("Create") then
			sc.entity:newEntity(self.input.value)
			self.input.value = ""
			self.open = false
		end
	end

	if sc.ui:button("Close") then
		self.open = false
	end
end