game = {}

function game:enter(prev, args)
	local file = io.open("/home/mary/.local/share/love/editor/test/scenes/" .. args[1] .. ".json", "r")

	self.scene = json.decode(file:read("*all"))

	file:close()

	self.imageCache = {}
	self.scriptCache = {}

	for _, entity in pairs(self.scene.entities) do
		local spriterenderer = getComponent(entity, "spriterenderer")
		local script = getComponent(entity, "script")

		if spriterenderer then
			if spriterenderer.texture ~= "" then
				local exists = lf.getInfo(spriterenderer.texture)

				if exists then
					self.imageCache[entity.id] = lg.newImage(spriterenderer.texture)
				end
			end
		end

		if script then
			if script.script ~= "" then
				local exists = lf.getInfo(script.script .. ".lua")

				if exists then
					self.scriptCache[entity.id] = require(script.script)()
					self.scriptCache[entity.id]:enter(entity)
				end
			end
		end
	end
end

function game:update(dt)

end

function game:draw()
	lg.clear(135/255, 206/255, 235/255)

	for _, entity in pairs(self.scene.entities) do
		local transform = getComponent(entity, "transform")
		local spriterenderer = getComponent(entity, "spriterenderer")
		local script = getComponent(entity, "script")

		if spriterenderer then
			local texture = self.imageCache[entity.id]

			if texture then
				lg.draw(texture, transform.x, transform.y)
			end
		end

		if script then
			local scriptz = self.scriptCache[entity.id]

			if scriptz then
				scriptz:update()
			end
		end
	end
end