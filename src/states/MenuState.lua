MenuState = Class{__include = BaseState}

function MenuState:enter()
    music = gSounds['background']
    music:setVolume(0.5)
end

function MenuState:render()
    music:play()
    love.graphics.setFont( gFonts['bigfont'] )
    love.graphics.setColor( 0,0,0)
    love.graphics.print('MAIN MENU', 30, 20)

    love.graphics.setFont( gFonts['smallfont'] )
	love.graphics.print('[Enter] PLAY', 30, 100)
	love.graphics.print('[Escape] EXIT', 30, 120)
end

function MenuState:update(dt)
    if love.keyboard.wasPressed('return') then
        gStateMachine:change('info', {})
    end
end

function MenuState:exit() end


function love.keypressed(key)
    if key == 'enter' then
        gStateMachine:change('info', {})
    end
end
