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

-- size of our actual window
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- size we're trying to emulate with push
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- Game title and shit
GAME_TITLE = 'Radon Run'

GROUND_HEIGHT = 48

local backgroundScroll = 0
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 50

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
    gSounds = {
        ['synne'] = love.audio.newSource("sounds/Wergelandsveien73.wav", "static"),
    }

    -- TODO: Load graphics
    gGraphics = {
        ['background'] = love.graphics.newImage('graphics/background.png'),
        ['ground'] = love.graphics.newImage('graphics/ground.png'),
        ['furni1'] = love.graphics.newImage('graphics/furni1.png'),
        ['radon1'] = love.graphics.newImage('graphics/Radon1.png'),
        ['obstacles'] = {
            ['bookcase'] = love.graphics.newImage('graphics/furni2.png'),
            ['longTable'] = love.graphics.newImage('graphics/furni5.png'),
            ['diningTable'] = love.graphics.newImage('graphics/furni6.png'),
            ['lamp'] = love.graphics.newImage('graphics/furni7.png'),
            ['mirror'] = love.graphics.newImage('graphics/furni8.png'),
        },
        ['tile'] = love.graphics.newImage('graphics/tile.png'),
        ['player'] = {
            ['left'] = love.graphics.newImage('graphics/player/hero2.png'),
            ['right'] = love.graphics.newImage('graphics/player/hero1.png'),
            ['radon_left'] = love.graphics.newImage('graphics/player/hero_radon2.png'),
            ['radon_right'] = love.graphics.newImage('graphics/player/hero_radon1.png'),
        },
    }

    gFonts = {
        ['bigfont'] = love.graphics.newFont('fonts/m3x6.ttf',50),
        ['smallfont'] = love.graphics.newFont('fonts/m3x6.ttf',20),
    }

    -- TODO: Load sounds

    gamestate = 'menu'


    gStateMachine = StateMachine {
        ['play'] = function() return PlayState() end,
        ['menu'] = function() return MenuState() end,
        ['info'] = function() return InfoState() end,
    }

    gStateMachine:change('menu', {})
    
    -- Create obstacles
    Obstacles = {
        Obstacle(gGraphics['obstacles']['longTable'], 28),
        Obstacle(gGraphics['obstacles']['lamp'], 31, 15),
        Obstacle(gGraphics['obstacles']['mirror'], 108, 16),
        Obstacle(gGraphics['obstacles']['bookcase'], 216),
        Obstacle(gGraphics['obstacles']['diningTable'], 324),
    }

    -- Create tiles
    Tiles = {
        Tile(155, 50),
        Tile(205, 75),
        Tile(255, 75),
        Tile(335, 110),
    }

    gStateMachine:change('play', {
        player = Player(),
        obstacles = Obstacles,
        tiles = Tiles,
    })

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

function love.keypressed(key)
    if key == 'return' then
    gStateMachine:change('info', {})
    end

    if key == 'escape' then
    gStateMachine:change('menu', {})
    end

    if key == 'p' then
        gStateMachine:change('play', {
            player = Player()
        })
    end
    
end


--[[
    Called each frame after update; is responsible simply for
    drawing all of our game objects and more to the screen.
]]
function love.draw()
    love.graphics.setFont( gFonts['smallfont'] )
    local x, y = love.mouse.getPosition()

    -- begin drawing with push, in our virtual resolution
    push:start()

    love.graphics.draw(gGraphics['background'], 0, 0)
    love.graphics.draw(gGraphics['ground'], 0, VIRTUAL_HEIGHT - 48)

    -- use the state machine to defer rendering to the current state we're in
    gStateMachine:render()

    -- display FPS for debugging; simply comment out to remove

    push:finish()
end

--[[
    Renders the current FPS.
]]
