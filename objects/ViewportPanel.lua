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
	state.current().ui:layoutRow("static", self.height, self.width, 1)

	local x, y, w, h = state.current().ui:windowGetBounds()

	if w ~= self.width or h ~= self.height then
		self:resizeCanvas(w, h)
	end

	lg.setCanvas(self.canvas)
		lg.clear(135/255, 206/255, 235/255)
		lg.rectangle("fill", 10, 10, 10, 10)
	lg.setCanvas()

	state.current().ui:image(self.canvas)
end