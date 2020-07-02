GhostInfoState = Class{__include = BaseState}

function GhostInfoState:enter(params)
    self.image = params.image
end

function GhostInfoState:render()
    love.graphics.draw(self.image, 100, 27)
    love.graphics.setColor(0,0,0)
    love.graphics.setFont( gFonts['bigfont'] )
    love.graphics.print('RADON', 30, 10)
    love.graphics.setFont( gFonts['smallfont'] )

    if self.image == gGraphics['ghosts']['adam'] then
        love.graphics.print('Radon does not show any short term effects,', 30, 50)
        love.graphics.print('and is very hard to detect without proper monitoring.', 30, 70)
        love.graphics.print('[press enter to continue]', 30, 110)
    elseif self.image == gGraphics['ghosts']['bob'] then
        love.graphics.print('It is the number one cause of lung cancer amongst non-smokers.', 30, 50)
        love.graphics.print('Radon induced lung cancer kills more than house fires', 30, 70)
        love.graphics.print('and carbon monoxide combined.', 30, 90)
        love.graphics.print('[press enter to continue]', 30, 130)
    else
        love.graphics.print('If your Radon levels are significantly high after monitoring', 30, 50)
        love.graphics.print('for a given time period, you should consider calling a', 30, 70)
        love.graphics.print('professional to determine a possible solution.', 30, 90)
        love.graphics.print('[press enter to continue]', 30, 130)
    end
end

function GhostInfoState:update()
    if love.keyboard.wasPressed('return') then
        Player.numGhostsKilled = Player.numGhostsKilled + 1

        if (Player.numGhostsKilled == TOTAL_GHOST_COUNT) then
            gStateMachine:change('info', {})
        else
            gStateMachine:change('play', {
                player = Player,
                obstacles = Obstacles,
                tiles = Tiles,
                ghosts = Ghosts,
                monitor = Monitor,
            })
        end
    end
end

function GhostInfoState:exit() end

function MenuState:exit() end