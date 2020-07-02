require './src/Dependencies'
-- push is a library that will allow us to draw our game at a virtual
-- resolution, instead of however large our window is; used to provide
-- a more retro aesthetic
--
-- https://github.com/Ulydev/push
push = require'lib/push'

-- the "Class" library we're using will allow us to represent anything in
-- our game as code, rather than keeping track of many disparate variables and
-- methods
--
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require'lib/class'

require './src/states/menu'
require './src/states/info'
require './src/states/characters'

-- size of our actual window
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- size we're trying to emulate with push
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- Game title and shit
GAME_TITLE = 'AT Game'

function love.load()
    -- set love's default filter to "nearest-neighbor", which essentially
    -- means there will be no filtering of pixels (blurriness), which is
    -- important for a nice crisp, 2D look
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- set the title of our application window
    love.window.setTitle(GAME_TITLE)

    -- seed the RNG so that calls to random are always random
    math.randomseed(os.time())

    -- TODO: Load sounds
    gFonts = {}

    -- TODO: Load graphics
    gGraphics = {
        ['player'] = love.graphics.newImage('graphics/player.png')
    }

    gFrames = {
        ['player'] = GeneratePlayerQuads(gGraphics['player'])
    }

    -- TODO: Load sounds
    gSounds = {}

    gamestate = 'menu'
    background = love.graphics.newImage('graphics/airbg.png')
    font = love.graphics.newFont('fonts/m3x6.ttf',200)

    -- initialize our virtual resolution, which will be rendered within our
    -- actual window no matter its dimensions
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
end

function love.update(dt)
    -- Game loop

    if gamestate == 'menu' then
		-- Loads all needed assets and variables.
		-- reload()
    end
    
end

--[[
    A callback that processes key strokes as they happen, just the once.
    Does not account for keys that are held down, which is handled by a
    separate function (`love.keyboard.isDown`). Useful for when we want
    things to happen right away, just once, like when we want to quit.
]]
function love.keypressed(key)

    if gamestate == 'menu' then
		-- For starting a new game.
		if key == 'return' then
			gamestate = 'info'
        end
    elseif gamestate == 'info' then
    
        if key == 'return' then
            gamestate = 'characters'
        end
    end
    

end

--[[
    Called each frame after update; is responsible simply for
    drawing all of our game objects and more to the screen.
]]
function love.draw()
    love.graphics.setFont( font )

    if gamestate == 'menu' then
        love.graphics.draw(background)

        -- for i = 0, love.graphics.getWidth() / background:getWidth() do
        --    for j = 0, love.graphics.getHeight() / background:getHeight() do
        --        love.graphics.draw(background, i * background:getWidth(), j * background:getHeight())
        --    end
        -- end
		menu_draw()
    end
    
    if gamestate == 'info' then
        love.graphics.setBackgroundColor(1, 0, 0)

        info_draw()
    end

    if gamestate == 'characters' then
        love.graphics.setBackgroundColor(0, 1, 0)

        characters_draw()
    end

end
