ViewportPanel = Object:extend()

function ViewportPanel:new()
	self.width = 100
	self.height = 100

	self.canvas = lg.newCanvas(self.width, self.height)

	self.gizmo = Gizmo()

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

	local mouseX = lm.getX() - x - 11
	local mouseY = lm.getY() - y - 37

	if w ~= self.width or h ~= self.height then
		self:resizeCanvas(w, h)
	end

	lg.setCanvas(self.canvas)
		r, g, b = nuklear.colorParseRGBA(sc().settings.backgroundColor)
		lg.clear(r/255, g/255, b/255)

		if sc().scene.currentScene then
			for _, entity in pairs(sc().scene.currentScene.entities) do
				local transform = getComponent(entity, "transform")
				local spriterenderer = getComponent(entity, "spriterenderer")
				local rigidbody = getComponent(entity, "rigidbody")

				if spriterenderer then
					local texture = sc().scene.imageCache[entity.id]
					if texture then
						lg.draw(texture, transform.x, transform.y, transform.rotation, transform.scaleX, transform.scaleY)
					end
				end

				if rigidbody then
					lg.rectangle("line", transform.x, transform.y, 30, 30)
				end

				if sc().entity.currentEntity then
					if entity.id == sc().entity.currentEntity.id then
						self.gizmo:draw(entity, mouseX, mouseY)
					end
				end
			end
		end
	lg.setCanvas()

	sc().ui:image(self.canvas)
end