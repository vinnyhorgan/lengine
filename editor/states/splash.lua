splash = {}

function splash:enter()
	self.t = 0
	self.duration = 0.5
	self.background = lg.newImage("splash.jpg")
end

function splash:update(dt)
	self.t = self.t + dt

	if self.t > self.duration then
		state.switch(editor)
	end
end

function splash:draw()
	lg.draw(self.background, 0, 0)
end