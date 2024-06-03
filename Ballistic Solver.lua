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
  simulator:setProperty("Weapon Type", 5)

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
      simulator:setInputNumber(31, simulator:getSlider(1))        -- set input 31 to the value of slider 1

      simulator:setInputBool(32, simulator:getIsToggled(2))       -- make button 2 a toggle, for input.getBool(32)
      simulator:setInputNumber(32, simulator:getSlider(2) * 50)   -- set input 32 to the value from slider 2 * 50
  end;
end
---@endsection


--[====[ IN-GAME CODE ]====]

-- try require("Folder.Filename") to include code from another file in this, so you can store code in libraries
-- the "LifeBoatAPI" is included by default in /_build/libs/ - you can use require("LifeBoatAPI") to get this, and use all the LifeBoatAPI.<functions>!


-- Get the type of weapon from the property
type = property.getNumber("Weapon Type")

-- Define the number of steps per scan
stepsPerScan = 5

-- Set the total number of scans
numberOfScans = 5

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

-- Update projectile velocities
function updateVelocities()
  projectile.vel.x = projectile.vel.x * (1 - projectile.drag)
  projectile.vel.z = projectile.vel.z * (1 - projectile.drag) - 0.5
end

-- Updates projectile position
function updatePosition()
  projectile.pos.x = projectile.pos.x + projectile.vel.x / 60
  projectile.pos.z = projectile.pos.z + projectile.vel.z / 60
end

-- Calculate vertical amount when the porjectile passes over the target distance based on launch pitch
function missAmount(pitch)
  setUp(pitch)
  while (projectile.lifetime >= projectile.ticks and target.pos.x > projectile.pos.x) do
    projectile.ticks = projectile.ticks + 1
    updateVelocities()
    updatePosition()
    --if the projectile will not get within 10m of the target distance in the remander of its lifetime traveling at it's current speed then return huge
    if (projectile.pos.x + projectile.vel.x*(projectile.lifetime-projectile.ticks)) < target.pos.x - 10 then
      return math.huge
    end
    --if the projectile is 175m under the target and going down by 175m/s then return huge
    if (projectile.vel.z < -175) and ((projectile.pos.z - target.pos.z) < -175) then
      return math.huge
    end
  end
  return (projectile.pos.z - target.pos.z)
end

-- Perform a scan to find the closest angle
function scan(Stop, Start, Step)
  smallestMiss = math.huge
  closestAngle = 0
  for i = Start, Stop, Step do
    if (math.abs(missAmount(i * math.pi / 180)) < smallestMiss) then
      smallestMiss = math.abs(missAmount(i * math.pi / 180))
      closestAngle = i
    end
  end
  return closestAngle
end

-- Main function executed on each tick
function onTick()
  -- Update target position
  target.pos.x = input.getNumber(1)
  target.pos.z = input.getNumber(2)

  -- Perform scans to find the optimal angle
  scans = {scan(90, -90, 10)}
  for i = 2, numberOfScans, 1 do
    scans[i] = scan(scans[i - 1] + 10 / (stepsPerScan^(i - 2)), scans[i - 1] - 10 / (stepsPerScan^(i - 2)), 10 / (stepsPerScan^(i - 1)))
  end

  -- Output the result
  output.setNumber(1, scans[#scans])
end