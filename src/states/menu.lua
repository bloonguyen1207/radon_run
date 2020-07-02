function menu_load()

end

function menu_draw()
	love.graphics.setNewFont(30)
	love.graphics.print('MAIN MENU!', 30, 30)

	love.graphics.setNewFont(15)
	love.graphics.print('[Enter] PLAY', 50, 75)
	love.graphics.print('[Escape]  EXIT', 50, 100)
end