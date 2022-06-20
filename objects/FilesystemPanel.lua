FilesystemPanel = Object:extend()

function FilesystemPanel:new()
	self.currentPath = {project}

	self.items = {}
end

function FilesystemPanel:draw()
	state.current().ui:layoutRow("dynamic", 20, 1)

	local path = ""

	for _, dir in pairs(self.currentPath) do
		path = path .. dir .. "/"
	end

	state.current().ui:label("PATH: " .. path)

	if state.current().ui:button("..") then
		if table.last(self.currentPath) ~= project then
			table.pop(self.currentPath)
		end
	end

	self.items = lf.getDirectoryItems(path)

	for _, item in pairs(self.items) do
		local filetype = lf.getInfo(path .. item).type
		local extension = string.sub(item, -4)

		if filetype == "file" then
			if extension == "json" then
				if state.current().ui:button(item) then
					state.current().scene:loadScene(item)
				end
			else
				state.current().ui:label(item)
			end
		elseif filetype == "directory" then
			if state.current().ui:button(item) then
				table.insert(self.currentPath, item)
			end
		end
	end
end