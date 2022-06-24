function checkCollision(x1, y1, w1, h1, x2, y2, w2, h2)
	return x1 < x2 + w2 and
			x2 < x1 + w1 and
			y1 < y2 + h2 and
			y2 < y1 + h1
end

function table.pop(tab)
	table.remove(tab, #tab)
end

function table.last(tab)
	return tab[#tab]
end

function uuid()
	local res = ""

	for i = 1, 10 do
		res = res .. string.char(math.random(97, 122))
	end

	return res
end

function getComponent(entity, name)
	for _, component in pairs(entity.components) do
		if component.name == name then
			return component
		end
	end

	return false
end

function fileExists(name)
	local f = io.open(name,"r")

	if f ~= nil then
		f:close()
		return true
	else
		return false
	end
end

function copyFile(file1, file2)
	local infile = io.open(file1, "r")
	local contents = infile:read("*a")
	infile:close()

	os.execute("echo '' > " .. file2)

	local outfile = io.open(file2, "w")
	outfile:write(contents)
	outfile:close()
end

function isInTable(tab, item)
	for _, i in pairs(tab) do
		if i == item then
			return true
		end
	end

	return false
end