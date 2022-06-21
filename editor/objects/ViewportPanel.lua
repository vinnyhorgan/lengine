ViewportPanel = Object:extend()

function ViewportPanel:new()
	self.width = 100
	self.height = 100

	self.canvas = lg.newCanvas(self.width, self.height)
end

function ViewportPanel:resizeCanvas(width, height)
	self.width = width
	self.height = height

	self.canvas = lg.newCanvas(self.width, self.height)
end

function ViewportPanel:draw()
	sc.ui:layoutRow("static", self.height, self.width, 1)

	local x, y, w, h = sc.ui:windowGetBounds()

	w = w - 20
	h = h - 45

	if w ~= self.width or h ~= self.height then
		self:resizeCanvas(w, h)
	end

	lg.setCanvas(self.canvas)
		lg.clear(135/255, 206/255, 235/255)

		if sc.scene.currentScene then
			for _, entity in pairs(sc.scene.currentScene.entities) do
				local transform = getComponent(entity, "transform")
				local spriterenderer = getComponent(entity, "spriterenderer")

				if spriterenderer then
					local texture = sc.scene.imageCache[entity.id]
					if texture then
						lg.draw(texture, transform.x, transform.y)
					end
				end

				if sc.entity.currentEntity then
					if entity.id == sc.entity.currentEntity.id then
						lg.setColor(1, 0, 0)
						lg.line(transform.x, transform.y, transform.x + 50, transform.y)
						lg.setColor(0, 0, 1)
						lg.line(transform.x, transform.y, transform.x, transform.y - 50)
						lg.setColor(1, 1, 1)
					end
				end
			end
		end
	lg.setCanvas()

	sc.ui:image(self.canvas)
end