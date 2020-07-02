InfoState = Class{__include = BaseState}

function InfoState:enter() end

function InfoState:render()
    src1 = gSounds['synne1']
    src2 = gSounds['synne2']
    love.graphics.draw(gGraphics['ghosts']['bob'], 150, 27)
    love.graphics.setColor(0,0,0)
    love.graphics.setFont( gFonts['bigfont'] )
    love.graphics.print('The end', 30, 10)
    
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
    if love.keyboard.wasPressed('return') then
        gStateMachine:change('menu', {})
    end
end

function InfoState:exit()
    src1:stop()
end