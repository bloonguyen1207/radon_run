require 'src/Dependencies'

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
end

--[[
    A callback that processes key strokes as they happen, just the once.
    Does not account for keys that are held down, which is handled by a
    separate function (`love.keyboard.isDown`). Useful for when we want
    things to happen right away, just once, like when we want to quit.
]]
function love.keypressed(key)

end

--[[
    Called each frame after update; is responsible simply for
    drawing all of our game objects and more to the screen.
]]
function love.draw()

end
