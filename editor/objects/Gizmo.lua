Gizmo = Object:extend()

function Gizmo:new()
	self.draggingX = false
	self.draggingY = false
	self.draggingXY = false
end

function Gizmo:draw(entity, mouseX, mouseY)
	local transform = getComponent(entity, "transform")

	if checkCollision(transform.x - 10, transform.y - 10, 70, 2, mouseX, mouseY, 1, 1) then
		lg.setColor(1, 0, 0, 0.5)
		lg.rectangle("fill", transform.x - 10, transform.y - 10, 70, 2)

		if lm.isDown(1) and not self.draggingY then
			self.draggingX = true
		end
	else
		lg.setColor(1, 0, 0)
		lg.rectangle("fill", transform.x - 10, transform.y - 10, 70, 2)
	end

	if checkCollision(transform.x - 10, transform.y - 10, 2, 70, mouseX, mouseY, 1, 1) then
		lg.setColor(0, 0, 1, 0.5)
		lg.rectangle("fill", transform.x - 10, transform.y - 10, 2, 70)

		if lm.isDown(1) and not self.draggingX then
			self.draggingY = true
		end
	else
		lg.setColor(0, 0, 1)
		lg.rectangle("fill", transform.x - 10, transform.y - 10, 2, 70)
	end

	if checkCollision(transform.x - 10, transform.y - 10, 10, 10, mouseX, mouseY, 1, 1) then
		lg.setColor(0, 1, 0, 0.5)
		lg.rectangle("fill", transform.x - 10, transform.y - 10, 10, 10)

		if lm.isDown(1) and not self.draggingX and not self.draggingY then
			self.draggingXY = true
		end
	else
		lg.setColor(0, 1, 0)
		lg.rectangle("fill", transform.x - 10, transform.y - 10, 10, 10)
	end

	lg.setColor(1, 1, 1)

	if self.draggingX then
		transform.x = mouseX
	end

	if self.draggingY then
		transform.y = mouseY
	end

	if self.draggingXY then
		transform.x = mouseX
		transform.y = mouseY
	end

	if self.draggingX and not lm.isDown(1) then
		self.draggingX = false
	end

	if self.draggingY and not lm.isDown(1) then
		self.draggingY = false
	end

	if self.draggingXY and not lm.isDown(1) then
		self.draggingXY = false
	end
end