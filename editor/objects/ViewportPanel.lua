ViewportPanel = Object:extend()

function ViewportPanel:new()
	self.width = 100
	self.height = 100

	self.canvas = lg.newCanvas(self.width, self.height)

	self.gizmo = Gizmo()

	self.cameraPointer = {x = 0, y = 0}

	self.camera = Camera()

	if sc().settings.filterInput.value == "pixel" then
		lg.setDefaultFilter("nearest", "nearest")
	end
end

function ViewportPanel:resizeCanvas(width, height)
	self.width = width
	self.height = height

	self.canvas = lg.newCanvas(self.width, self.height)
end

function ViewportPanel:draw()
	sc().ui:layoutRow("static", self.height, self.width, 1)

	local x, y, w, h = sc().ui:windowGetBounds()

	w = w - 20
	h = h - 45

	local mouseX, mouseY = self.camera:worldCoords(lm.getX(), lm.getY() + 75)

	if w ~= self.width or h ~= self.height then
		self:resizeCanvas(w, h)
	end

	if lk.isDown("up") then
		self.cameraPointer.y = self.cameraPointer.y - 2
	elseif lk.isDown("down") then
		self.cameraPointer.y = self.cameraPointer.y + 2
	end

	if lk.isDown("left") then
		self.cameraPointer.x = self.cameraPointer.x - 2
	elseif lk.isDown("right") then
		self.cameraPointer.x = self.cameraPointer.x + 2
	end

	if lk.isDown("w") then
		self.camera.scale = self.camera.scale + 0.01
	elseif lk.isDown("s") then
		self.camera.scale = self.camera.scale - 0.01
	end

	self.camera:lookAt(self.cameraPointer.x, self.cameraPointer.y)

	lg.setCanvas(self.canvas)
		r, g, b = nuklear.colorParseRGBA(sc().settings.backgroundColor)
		lg.clear(r/255, g/255, b/255)

		self.camera:attach(0, 0, self.width, self.height)

		lg.setColor(0, 0, 0)
		lg.line(-10000, 0, 10000, 0)
		lg.line(0, -10000, 0, 10000)

		lg.rectangle("line", 0, 0, tonumber(sc().settings.widthInput.value) or 0, tonumber(sc().settings.heightInput.value) or 0)

		lg.rectangle("fill", mouseX, mouseY, 1, 1)
		lg.setColor(1, 1, 1)

		if sc().scene.currentScene then
			for _, entity in pairs(sc().scene.currentScene.entities) do
				local transform = getComponent(entity, "transform")
				local spriterenderer = getComponent(entity, "spriterenderer")
				local rigidbody = getComponent(entity, "rigidbody")

				if spriterenderer then
					local texture = sc().scene.imageCache[entity.id]
					if texture then
						lg.draw(texture, transform.x, transform.y, math.rad(transform.rotation), transform.scaleX, transform.scaleY)
					end
				end

				if rigidbody then
					lg.rectangle("line", transform.x, transform.y, rigidbody.width, rigidbody.height)
				end

				if sc().entity.currentEntity then
					if entity.id == sc().entity.currentEntity.id then
						self.gizmo:draw(entity, mouseX, mouseY)
					end
				end
			end
		end

		self.camera:detach()
	lg.setCanvas()

	sc().ui:image(self.canvas)
end