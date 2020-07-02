InfoState = Class{__include = BaseState}


function info_load()
    

end

function InfoState:enter()
    self.player = Player()
    self.obstacles = {
        Obstacle(gGraphics['obstacles']['longTable'], 28),
        Obstacle(gGraphics['obstacles']['lamp'], 31, 15),
        Obstacle(gGraphics['obstacles']['mirror'], 108, 16),
        Obstacle(gGraphics['obstacles']['bookcase'], 216),
        Obstacle(gGraphics['obstacles']['diningTable'], 324),
    }
    -- Create tiles
    self.tiles = {
        Tile(155, 50),
        Tile(205, 75),
        Tile(255, 75),
        Tile(335, 110),
    }

    -- Create ghosts
    self.ghosts = {
        Ghost(gGraphics['ghosts']['adam'], 80, 0),
        Ghost(gGraphics['ghosts']['bob'], 224, 75, -1),
        Ghost(gGraphics['ghosts']['carl'], 330, 12),
    }

    self.monitor = Monitor(VIRTUAL_WIDTH - 70, 50)
end

function InfoState:render()
    src1 = gSounds['synne1']
    src2 = gSounds['synne2']
    love.graphics.draw(gGraphics['ghosts']['bob'], 100, 27)
    love.graphics.setColor(0,0,0)
    love.graphics.setFont( gFonts['bigfont'] )
    love.graphics.print('RADON', 30, 10)
    
    love.graphics.setFont( gFonts['smallfont'] )
    love.graphics.print('Radon does not show any short term effects,', 30, 50)
    love.graphics.print('and is very hard to detect without proper monitoring.', 30, 70)
    love.graphics.print('It is the number one cause of lung cancer amongst non-smokers.', 30, 90)
    love.graphics.print('Radon induced lung cancer kills more than house fires and', 30, 110)
    love.graphics.print('carbon monoxide combined.', 30, 130)
    love.graphics.print('Read more at:', 30, 170)
    love.graphics.setFont(gFonts['bigfont'])
    love.graphics.print('www.airthings.com.', 30, 193)

    src1:setVolume(1)
    src1:setPitch(1.5)
    src1:play()
end



function InfoState:update(dt)
    if love.keyboard.wasPressed('p') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play', {
            player = self.player,
            obstacles = self.obstacles,
            monitor = self.monitor,
            tiles = self.tiles,
            ghosts = self.ghosts,
        })
    end
end

function InfoState:exit()
    src1:stop()
end
