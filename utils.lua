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