MenuState = Class{__include = BaseState}

function MenuState:enter()
    music = gSounds['background']
    music:setVolume(0.1)
end

function MenuState:update(dt)
    if love.keyboard.wasPressed('return') then
        gStateMachine:change('play', {
            player = Player,
            obstacles = Obstacles,
            tiles = Tiles,
            ghosts = Ghosts,
            monitor = Monitor,
        })
    end
end

function MenuState:render()
    music:play()
    love.graphics.draw(gGraphics['menu'], 0, 0)
   -- love.graphics.draw(gGraphics['logo'], VIRTUAL_WIDTH - gGraphics['logo']:getWidth()/ 2, VIRTUAL_HEIGHT - gGraphics['logo']:getHeight() )

    love.graphics.setFont( gFonts['small'] )
    love.graphics.setColor(0, 0, 0)
	love.graphics.printf('Press `Enter` to play', 0, VIRTUAL_HEIGHT - 80, VIRTUAL_WIDTH, "center")
end

function MenuState:exit() end

