function info_load()
    src1 = love.audio.newSource("./sounds/synne.wav", "static")

end

function info_draw()
    love.graphics.print('ABOUT RADON', 50, 30)
    
    love.graphics.setFont( smallfont )
    love.graphics.print('Radon does not show any short term effects, and is very hard to detect without proper monitoring.', 50, 200)
    love.graphics.print('It is the number one cause of lung cancer amongst non-smokers.', 50, 300)
    love.graphics.print('Radon induced lung cancer kills more than house fires and carbon monoxide combined.', 50, 400)
    love.graphics.print('If your Radon levels are significantly high after monitoring for a given time period,', 50, 500)
    love.graphics.print('you should consider calling a professional to determine a possible solution.', 50, 600)
    love.graphics.print('Before that, there are some easy measures you can do yourself: read more at www.airthings.com.', 50, 700)

    src1:setVolume(0.9) -- 90% of ordinary volume
    src1:setPitch(0.5) -- one octave lower
    src1:play()

end