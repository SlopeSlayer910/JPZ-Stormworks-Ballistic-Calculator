
--- Developed using LifeBoatAPI - Stormworks Lua plugin for VSCode - https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--- If you have any issues, please report them here: https://github.com/nameouschangey/STORMWORKS_VSCodeExtension/issues - by Nameous Changey


--[====[ HOTKEYS ]====]
-- Press F6 to simulate this file
-- Press F7 to build the project, copy the output from /_build/out/ into the game to use
-- Remember to set your Author name etc. in the settings: CTRL+COMMA


--[====[ EDITABLE SIMULATOR CONFIG - *automatically removed from the F7 build output ]====]
---@section __LB_SIMULATOR_ONLY__
do
    ---@type Simulator -- Set properties and screen sizes here - will run once when the script is loaded
    simulator = simulator
    simulator:setScreen(1, "3x3")
    simulator:setProperty("Weapon Type", 7)
  
    -- Runs every tick just before onTick; allows you to simulate the inputs changing
    ---@param simulator Simulator Use simulator:<function>() to set inputs etc.
    ---@param ticks     number Number of ticks since simulator started
    function onLBSimulatorTick(simulator, ticks)
  
        -- touchscreen defaults
        local screenConnection = simulator:getTouchScreen(1)
        simulator:setInputBool(1, screenConnection.isTouched)
        simulator:setInputNumber(1, screenConnection.width)
        simulator:setInputNumber(2, screenConnection.height)
        simulator:setInputNumber(3, screenConnection.touchX)
        simulator:setInputNumber(4, screenConnection.touchY)
  
        -- NEW! button/slider options from the UI
        simulator:setInputBool(31, simulator:getIsClicked(1))       -- if button 1 is clicked, provide an ON pulse for input.getBool(31)
        simulator:setInputNumber(5, simulator:getSlider(1) * 7500)        -- set input 31 to the value of slider 1
        simulator:setInputBool(32, simulator:getIsToggled(2))       -- make button 2 a toggle, for input.getBool(32)
        simulator:setInputNumber(6, simulator:getSlider(2) * 100)   -- set input 32 to the value from slider 2
    end;
end
---@endsection


--[====[ IN-GAME CODE ]====]

-- try require("Folder.Filename") to include code from another file in this, so you can store code in libraries
-- the "LifeBoatAPI" is included by default in /_build/libs/ - you can use require("LifeBoatAPI") to get this, and use all the LifeBoatAPI.<functions>!

-- Get the type of weapon from the property
type = property.getNumber("Weapon Type")

-- Define the number of steps per scan
stepsPerScan = 3

-- Set the number of scans per tick
scansPerSet = 3

--The amount of ticks to run before changing the output / getting new input.
sets = 3

--Variables for during the execution of the program
runSets = 1
currentAngle = 0

-- Table of all the data relevant to each weapon type
projectileType = {
    {drag = 0.025, lifetime = 300, muzzel = 800},  -- Machine Gun
    {drag = 0.02, lifetime = 300, muzzel = 1000},  -- Light Autocannon
    {drag = 0.01, lifetime = 300, muzzel = 1000},  -- Rotary Autocannon
    {drag = 0.005, lifetime = 600, muzzel = 900},  -- Heavy Autocannon
    {drag = 0.002, lifetime = 3600, muzzel = 800}, -- Battle Cannon
    {drag = 0.001, lifetime = 3600, muzzel = 700}, -- Artillery Cannon
    {drag = 0.0005, lifetime = 3600, muzzel = 600} -- Bertha Cannon
}

-- Set the current projectile to the type selected
projectile = projectileType[type]

-- Initialize the target position
target = {pos = {x = 0, z = 0}}

--Credit
--https://steamcommunity.com/profiles/76561198105241347/myworkshopfiles/?appid=573090
--https://discord.com/channels/357480372084408322/370840938739925003/1291950070555611277

--[[
I_x = 636 --Initial Velocity
I_y = 636
t = 120 --time in ticks, 60 = one second
drag = 0.009

k = 1-drag

--V_x = I_x*k^t --Velocity at a given time
--V_y = I_x*k^t-0.5*(1-k^t)/drag

--a = (1-k^t)/drag
a = k*(1-k^t)/drag
S_x = a*I_x/60 --horizontal position
S_y = (I_x*a-0.5*(t-a)/drag)/60 --vertical position
]]

-- Function to solve for t
function solveForTime(position, drag, velocity)
    -- Calculate t using the rearranged formula
    local t = math.log(1 - (60 * position * drag) / ((1 - drag) * velocity)) / math.log(1 - drag)
    return t
end

function getBulletPosition(time, velocity, angle, drag)
    I_x = velocity*math.cos(angle)
    I_y = velocity*math.sin(angle)
    t = time --time in ticks, 60 = one second

    k = 1-drag

    V_x = I_x*k^t --Velocity at a given time
    V_z = I_x*k^t-0.5*(1-k^t)/drag

    a = k*(1-k^t)/drag

    S_x = a*I_x/60 --horizontal position
    S_z = (I_y*a-0.5*(t-a)/drag)/60 --vertical position

    return S_x, S_z, V_x, V_z
end

-- Function to initialize each projectile simulation
function setUp(pitch)
    -- Initialize the velocity table
    projectile.vel = {}
    -- Initialize the position table
    projectile.pos = {}
    -- Calculate the initial velocities based on the input pitch
    projectile.vel.x = projectile.muzzel * math.cos(pitch)
    projectile.vel.z = projectile.muzzel * math.sin(pitch)
    -- Reset and initialize other variables
    projectile.pos.x = 0
    projectile.pos.z = 0
    projectile.ticks = 0
end

-- Calculate vertical amount when the porjectile passes over the target distance based on launch pitch
function missAmount(pitch)
    setUp(pitch)
    impactTick = solveForTime(target.pos.x, projectile.drag, projectile.vel.x)
    if impactTick > projectile.lifetime then
        return math.huge
    end
    projectile.pos.x, projectile.pos.z = getBulletPosition(impactTick, projectile.muzzel, pitch, projectile.drag)
    return (target.pos.z - projectile.pos.z)
end

-- Perform a scan to find the closest angle
function scan(Stop, Start, Step)
    smallestMiss = math.huge
    closestAngle = 0
    for i = Start, Stop, Step do
        if (math.abs(missAmount(math.rad(i))) < smallestMiss) then
            smallestMiss = math.abs(missAmount(math.rad(i)))
            closestAngle = i
        end
    end
    return closestAngle
end

-- Main function executed on each tick
function onTick()
    if runSets == 1 then --start of a search cycle
        -- Update target position
        target.pos.x = input.getNumber(1)
        target.pos.z = input.getNumber(2)
        scans = {scan(90, (math.deg(math.atan(target.pos.z,target.pos.x))//10)*10-10, 10)}
    end
    -- Perform scans to find the optimal angle
    for i = (runSets-1)*(scansPerSet-1)+2, runSets*scansPerSet, 1 do
        scans[i] = scan(scans[i - 1] + 10 / (stepsPerScan^(i - 2)), scans[i - 1] - 10 / (stepsPerScan^(i - 2)), 10 / (stepsPerScan^(i - 1)))
    end

    if runSets >= sets then --End of search cycle
        runSets = 1
        currentAngle = scans[#scans]
    else --run next set
        runSets = runSets+1
    end
    -- Output the result
    output.setNumber(1, currentAngle/360) --converts the current angle in degrees to turns
    output.setNumber(2, target.pos.x)
    output.setNumber(3, target.pos.z)
    output.setNumber(4, currentAngle)
    output.setNumber(5, type)
end