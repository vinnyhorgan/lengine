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

function InputPanel:addScript()
	self.open = true
	self.mode = "addScript"
end

function InputPanel:draw()
	sc().ui:layoutRow("dynamic", 30, 1)

	if self.mode == "saveScene" then
		sc().ui:label("Scene Name")

		if sc().ui:edit("simple", self.input) == "active" and lk.isDown("return") then
			sc().scene:saveScene(self.input.value)
			self.input.value = ""
			self.open = false
		end

		sc().ui:spacing(1)
	elseif self.mode == "newEntity" then
		sc().ui:label("Entity Name")

		if sc().ui:edit("simple", self.input) == "active" and lk.isDown("return") then
			sc().entity:newEntity(self.input.value)
			self.input.value = ""
			self.open = false
		end

		sc().ui:spacing(1)
	elseif self.mode == "addScript" then
		sc().ui:label("Script Name")

		if sc().ui:edit("simple", self.input) == "active" and lk.isDown("return") then
			sc().entity:addScript(self.input.value)

			self.input.value = ""
			self.open = false
		end

		sc().ui:spacing(1)
	end

	if sc().ui:button("Close") then
		self.open = false
	end
end