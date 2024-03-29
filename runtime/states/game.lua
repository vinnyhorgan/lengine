game = {}

function game:enter(prev, args)
	lf.createDirectory("images")

	local file = io.open("/home/mary/.local/share/love/editor/test/scenes/" .. args[1] .. ".json", "r")

	self.scene = json.decode(file:read("*all"))

	file:close()

	file = io.open("/home/mary/.local/share/love/editor/test/settings.json", "r")

	self.settings = json.decode(file:read("*all"))

	file:close()

	lw.setMode(self.settings.width, self.settings.height)

	self.world = wf.newWorld(0, self.settings.gravity, true)

	if self.settings.filter == "pixel" then
		lg.setDefaultFilter("nearest", "nearest")
	end

	self.imageCache = {}
	self.scriptCache = {}

	self.collisionClasses = {}

	for _, entity in pairs(self.scene.entities) do
		local transform = getComponent(entity, "transform")

		local spriterenderer = getComponent(entity, "spriterenderer")
		local script = getComponent(entity, "script")
		local rigidbody = getComponent(entity, "rigidbody")

		if spriterenderer then
			if spriterenderer.texture ~= "" then
				local exists = fileExists("/home/mary/.local/share/love/editor/test/assets/" .. spriterenderer.texture)

				if exists then
					copyFile("/home/mary/.local/share/love/editor/test/assets/" .. spriterenderer.texture, lf.getSaveDirectory() .. "/" .. spriterenderer.texture)


					file = io.open("/home/mary/.local/share/love/editor/test/settings.json", "r")

					self.imageCache[entity.id] = lg.newImage(spriterenderer.texture)
				end
			end
		end

		if rigidbody then
			if not isInTable(self.collisionClasses, rigidbody.collisionClass) then
				self.world:addCollisionClass(rigidbody.collisionClass)
				table.insert(self.collisionClasses, rigidbody.collisionClass)
			end

			rigidbody.collider = self.world:newRectangleCollider(transform.x, transform.y, rigidbody.width, rigidbody.height)

			if rigidbody.static then
				rigidbody.collider:setType("static")
			end

			if rigidbody.fixedRotation then
				rigidbody.collider:setFixedRotation(true)
			end

			rigidbody.collider:setCollisionClass(rigidbody.collisionClass)
			rigidbody.collider:setObject(entity)

			rigidbody.collider:setAngle(transform.rotation)
		end

		if script then
			if script.script ~= "" then
				local exists = fileExists("/home/mary/.local/share/love/editor/test/scripts/" .. script.file .. ".lua")

				if exists then
					self.scriptCache[entity.id] = dofile("/home/mary/.local/share/love/editor/test/scripts/" .. script.file .. ".lua")()
					self.scriptCache[entity.id]:enter(entity)
				end
			end
		end
	end
end

function game:update(dt)
	self.world:update(dt)
end

function game:draw()
	lg.clear(self.settings.backgroundColor.r/255, self.settings.backgroundColor.g/255, self.settings.backgroundColor.b/255)

	for _, entity in pairs(self.scene.entities) do
		local transform = getComponent(entity, "transform")
		local spriterenderer = getComponent(entity, "spriterenderer")
		local script = getComponent(entity, "script")
		local rigidbody = getComponent(entity, "rigidbody")

		if spriterenderer then
			local texture = self.imageCache[entity.id]

			if texture then
				if rigidbody then
					lg.draw(texture, transform.x, transform.y, math.rad(transform.rotation), transform.scaleX, transform.scaleY, rigidbody.width / 2, rigidbody.height / 2)
				else
					lg.draw(texture, transform.x, transform.y, math.rad(transform.rotation), transform.scaleX, transform.scaleY)
				end
			end
		end

		if script then
			local scriptz = self.scriptCache[entity.id]

			if scriptz then
				scriptz:update()
			end
		end

		if rigidbody then
			transform.x = rigidbody.collider:getX()
			transform.y = rigidbody.collider:getY()
			transform.rotation = math.deg(rigidbody.collider:getAngle())
		end
	end

	self.world:draw()
end