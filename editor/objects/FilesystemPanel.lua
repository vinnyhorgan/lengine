FilesystemPanel = Object:extend()

function FilesystemPanel:new()
	self.currentPath = {project}

	self.items = {}
end

function FilesystemPanel:draw()
	sc().ui:layoutRow("dynamic", 20, 1)

	local path = ""

	for _, dir in pairs(self.currentPath) do
		path = path .. dir .. "/"
	end

	sc().ui:label("PATH: " .. path)

	if sc().ui:button("..") then
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
				if sc().ui:button(item) then
					sc().scene:loadScene(item)
				end
			elseif extension == ".lua" then
				if sc().ui:button(item) then
					if sc().settings.editCommandInput.value == "" then
						sc().console:log("WARNING: edit command not set")
					else
						os.execute(sc().settings.editCommandInput.value .. " " .. lf.getSaveDirectory() .. "/" .. project .. "/scripts/" .. item)

						sc().console:log("Editing file: " .. item)
					end
				end
			else
				sc().ui:label(item)
			end
		elseif filetype == "directory" then
			if sc().ui:button(item) then
				table.insert(self.currentPath, item)
			end
		end
	end
end