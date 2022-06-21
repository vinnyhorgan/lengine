editor = {}

function editor:enter()
	self.ui = nuklear.newUI()

	self.scene = ScenePanel()
	self.entity = EntityPanel()
	self.viewport = ViewportPanel()
	self.filesystem = FilesystemPanel()
	self.console = ConsolePanel()
	self.settings = SettingsPanel()
	self.about = AboutPanel()
	self.input = InputPanel()
end

function editor:update(dt)
	local w = lg.getWidth() / 5
	local h = lg.getHeight() / 5

	self.ui:frameBegin()

	if self.ui:windowBegin("Scene", 0, 0, w, h*2.5, "border", "title", "scrollbar") then
		self.scene:draw()
	end
	self.ui:windowEnd()

	if self.ui:windowBegin("Entity", w*4, 0, w, h*5, "border", "title", "scrollbar") then
		self.entity:draw()
	end
	self.ui:windowEnd()

	if self.ui:windowBegin("Viewport", w, 0, w*3, h*3.5, "border", "title") then
		self.viewport:draw()
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

	if self.settings.open then
		if self.ui:windowBegin("Settings", w*2.5-200, h*2.5-200, 400, 400, "border", "title", "scrollbar", "movable") then
			self.settings:draw()
		end
		self.ui:windowEnd()
	end

	if self.about.open then
		if self.ui:windowBegin("About", w*2.5-100, h*2.5-60, 200, 120, "border", "title", "movable") then
			self.about:draw()
		end
		self.ui:windowEnd()
	end

	if self.input.open then
		if self.ui:windowBegin("Input", w*2.5-100, h*2.5-110, 200, 220, "border", "title", "scrollbar", "movable") then
			self.input:draw()
		end
		self.ui:windowEnd()
	end

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