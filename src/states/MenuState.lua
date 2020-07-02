MenuState = Class{__include = BaseState}

function MenuState:enter()
    music = gSounds['background']
    music:setVolume(0.1)
    self.player = Player()
    self.obstacles = {
        Obstacle(gGraphics['obstacles']['longTable'], 28),
        Obstacle(gGraphics['obstacles']['lamp'], 31, 15),
        Obstacle(gGraphics['obstacles']['mirror'], 108, 16),
        Obstacle(gGraphics['obstacles']['bookcase'], 216),
        Obstacle(gGraphics['obstacles']['diningTable'], 324),
    }
    self.tiles = {
        Tile(155, 50),
        Tile(205, 75),
        Tile(255, 75),
        Tile(335, 110),
    }
    self.ghosts = {
        Ghost(gGraphics['ghosts']['adam'], 80, 0),
        Ghost(gGraphics['ghosts']['bob'], 224, 75, -1),
        Ghost(gGraphics['ghosts']['carl'], 330, 12),
    }
    self.monitor = Monitor(VIRTUAL_WIDTH - 70, 50)
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
        gStateMachine:change('play', {
            player = self.player,
            obstacles = self.obstacles,
            monitor = self.monitor,
            tiles = self.tiles,
            ghosts = self.ghosts,
        })
    end
end

function MenuState:exit() end


function love.keypressed(key)
    if key == 'enter' then
        gStateMachine:change('info', {})
    end
end
