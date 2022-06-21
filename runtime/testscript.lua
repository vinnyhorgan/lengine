local test = Object:extend()

function test:enter(entity)
	self.entity = entity
end

function test:update(dt)
	local transform = getComponent(self.entity, "transform")
	transform.x = transform.x + 1
end

return test