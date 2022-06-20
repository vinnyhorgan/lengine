editor = {}

function editor:enter()
	self.ui = nuklear.newUI()

	self.scene = ScenePanel()
	self.filesystem = FilesystemPanel()
	self.console = ConsolePanel()
end

function editor:update(dt)
	local w = lg.getWidth() / 5
	local h = lg.getHeight() / 5

	self.ui:frameBegin()

	if self.ui:windowBegin("Scene", 0, 0, w, h*2.5, "border", "title") then
		self.scene:draw()
	end
	self.ui:windowEnd()

	if self.ui:windowBegin("Inspector", w*4, 0, w, h*5, "border", "title") then
		self.ui:layoutRow("dynamic", 30, 1)
		self.ui:label("Hello, world!")
	end
	self.ui:windowEnd()

	if self.ui:windowBegin("Viewport", w, 0, w*3, h*3.5, "border", "title") then
		self.ui:layoutRow("dynamic", 30, 1)
		self.ui:label("Hello, world!")
	end
	self.ui:windowEnd()

	if self.ui:windowBegin("Filesystem", 0, h*2.5, w, h*2.5, "border", "title", "scrollbar") then
		self.filesystem:draw()
	end
	self.ui:windowEnd()

	if self.ui:windowBegin("Console", w, h*3.5, w*3, h*1.5, "border", "title", "scrollbar") then
		self.console:draw()
	end
	self.ui:windowEnd()

	self.ui:frameEnd()
end

function editor:draw()
	self.ui:draw()
end



function editor:keypressed(key, scancode, isrepeat)
	self.ui:keypressed(key, scancode, isrepeat)
end

function editor:keyreleased(key, scancode)
	self.ui:keyreleased(key, scancode)
end

function editor:mousepressed(x, y, button, istouch, presses)
	self.ui:mousepressed(x, y, button, istouch, presses)
end

function editor:mousereleased(x, y, button, istouch, presses)
	self.ui:mousereleased(x, y, button, istouch, presses)
end

function editor:mousemoved(x, y, dx, dy, istouch)
	self.ui:mousemoved(x, y, dx, dy, istouch)
end

function editor:textinput(text)
	self.ui:textinput(text)
end

function editor:wheelmoved(x, y)
	self.ui:wheelmoved(x, y)
end