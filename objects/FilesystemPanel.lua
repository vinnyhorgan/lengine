FilesystemPanel = Object:extend()

function FilesystemPanel:new()
	self.currentPath = {"test"}

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
		table.pop(self.currentPath)
	end

	self.items = lf.getDirectoryItems(path)

	for _, item in pairs(self.items) do
		local filetype = lf.getInfo(path .. item).type

		if filetype == "file" then
			state.current().ui:label(item)
		elseif filetype == "directory" then
			if state.current().ui:button(item) then
				table.insert(self.currentPath, item)
			end
		end
	end
end