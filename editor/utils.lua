function CheckCollision(x1, y1, w1, h1, x2, y2, w2, h2)
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

function removeComponent(entity, name)
	for i, component in pairs(entity.components) do
		if component.name == name then
			table.remove(entity.components, i)
		end
	end
end