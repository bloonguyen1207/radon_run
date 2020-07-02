MenuState = Class{__include = BaseState}

function menu_load()

end

function MenuState:enter()

end

function MenuState:render()
    love.graphics.setFont( gFonts['bigfont'] )
    love.graphics.setColor( 0,0,0)
    love.graphics.print('MAIN MENU', 30, 20)

    love.graphics.setFont( gFonts['smallfont'] )
	love.graphics.print('[Enter] PLAY', 30, 100)
	love.graphics.print('[Escape] EXIT', 30, 120)
end

function MenuState:update(dt)

end

function MenuState:exit()

end


function love.keypressed(key)
    if key == 'enter' then
        gStateMachine:change('info', {})
    end
end