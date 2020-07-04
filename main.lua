require './src/Dependencies'

-- size of our actual window
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- size we're trying to emulate with push
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- Game title and shit
GAME_TITLE = 'Radon Run'

BACKGROUND_SCROLL_SPEED = 60

GRAVITY = 7

TOTAL_GHOST_COUNT = 3

function love.load()
    -- set love's default filter to "nearest-neighbor", which essentially
    -- means there will be no filtering of pixels (blurriness), which is
    -- important for a nice crisp, 2D look
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- set the title of our application window
    love.window.setTitle(GAME_TITLE)

    -- seed the RNG so that calls to random are always random
    math.randomseed(os.time())

    Player = Player()
    Obstacles = {
        Obstacle(gGraphics['obstacles']['longTable'], 14),
        Obstacle(gGraphics['obstacles']['lamp'], 17, 15),
        Obstacle(gGraphics['obstacles']['mirror'], 108, 16),
        Obstacle(gGraphics['obstacles']['bookcase'], 180),
        Obstacle(gGraphics['obstacles']['diningTable'], 324),
    }

    Tiles = {
        Tile(50, 120),
        Tile(125, 75),
        Tile(255, 75),
        Tile(335, 120),
    }

    Ghosts = {
        Ghost(gGraphics['ghosts']['adam'], 50, 150),
        Ghost(gGraphics['ghosts']['bob'], 224, 95, -1),
        Ghost(gGraphics['ghosts']['carl'], 330, 30),
    }

    Monitor = Monitor(VIRTUAL_WIDTH - 50, 30)

    gStateMachine = StateMachine {
        ['menu'] = function() return MenuState() end,
        ['info'] = function() return InfoState() end,
        ['play'] = function() return PlayState() end,
        ['ghostInfo'] = function() return GhostInfoState() end,
    }

    gStateMachine:change('menu', {})

    -- initialize our virtual resolution, which will be rendered within our
    -- actual window no matter its dimensions
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    -- a table we'll use to keep track of which keys have been pressed this
    -- frame, to get around the fact that LÖVE's default callback won't let us
    -- test for input from within other functions
    love.keyboard.keysPressed = {}
end

--[[
    Called whenever we change the dimensions of our window, as by dragging
    out its bottom corner, for example. In this case, we only need to worry
    about calling out to `push` to handle the resizing. Takes in a `w` and
    `h` variable representing width and height, respectively.
]]
function love.resize(w, h)
    push:resize(w, h)
end


function love.update(dt)
    gStateMachine:update(dt)

    -- reset keys pressed
    love.keyboard.keysPressed = {}
end

--[[
    A callback that processes key strokes as they happen, just the once.
    Does not account for keys that are held down, which is handled by a
    separate function (`love.keyboard.isDown`). Useful for when we want
    things to happen right away, just once, like when we want to quit.
]]

function love.keypressed(key)
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true
end

--[[
    A custom function that will let us test for individual keystrokes outside
    of the default `love.keypressed` callback, since we can't call that logic
    elsewhere by default.
]]
function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

--[[
    Called each frame after update; is responsible simply for
    drawing all of our game objects and more to the screen.
]]
function love.draw()
    love.graphics.setFont( gFonts['small'] )

    -- begin drawing with push, in our virtual resolution
    push:start()

    love.graphics.draw(gGraphics['background'], 0, 0)
    love.graphics.draw(gGraphics['ground'], 0, VIRTUAL_HEIGHT - 48)

    -- use the state machine to defer rendering to the current state we're in
    gStateMachine:render()

    push:finish()
end
