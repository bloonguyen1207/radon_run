InfoState = Class{__include = BaseState}


function info_load()
    

end

function InfoState:enter()

end

function InfoState:render()
    src1 = gSounds['synne']
    love.graphics.setColor(0,0,0)
    love.graphics.setFont( gFonts['bigfont'] )
    love.graphics.print('RADON', 30, 10)
    
    love.graphics.setFont( gFonts['smallfont'] )
    love.graphics.print('Radon does not show any short term effects, and is very hard to detect', 30, 50)
    love.graphics.print('without proper monitoring. It is the number one cause of lung cancer', 30, 70)
    love.graphics.print('amongst non-smokers. Radon induced lung cancer kills more than house fires and carbon monoxide', 30, 90)
    love.graphics.print('combined. If your Radon levels are significantly high after monitoring for a given time', 30, 110)
    love.graphics.print('period, you should consider calling a professional to determine a possible solution.', 30, 130)
    love.graphics.print('Before that, there are some easy measures you can do yourself.', 30, 150)
    love.graphics.setFont( gFonts['bigfont'] )
    love.graphics.print('www.airthings.com.', 30, 195)

    src1:setVolume(1)
    src1:setPitch(1.5)
    src1:play()

end

function InfoState:exit()
    src1:stop()
end

function InfoState:update(dt)

end
