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
GAME_TITLE = 'AT Game'

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
        ['player'] = love.graphics.newImage('graphics/player.png')
    }

    gFrames = {
        ['player'] = GeneratePlayerQuads(gGraphics['player'])
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

    -- initialize our virtual resolution, which will be rendered within our
    -- actual window no matter its dimensions
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
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
    -- Game loop
    -- scroll our background and ground, looping back to 0 after a certain amount
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH

    gStateMachine:update(dt)
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

    -- background should be drawn regardless of state, scaled to fit our
    -- virtual resolution
    local backgroundWidth = gGraphics['background']:getWidth()
    local backgroundHeight = gGraphics['background']:getHeight()

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
