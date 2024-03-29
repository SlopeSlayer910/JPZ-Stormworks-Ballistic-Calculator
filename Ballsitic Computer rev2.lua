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


type = property.getNumber("Weapon Type")
projectileType = {
{drag = 0.025,  lifetime = 300,  muzzel = 800},  --mg
{drag = 0.02,   lifetime = 300,  muzzel = 1000}, --lac
{drag = 0.01,   lifetime = 300,  muzzel = 1000}, --rac
{drag = 0.005,  lifetime = 600,  muzzel = 900},  --hac
{drag = 0.002,  lifetime = 3600, muzzel = 800},  --bc
{drag = 0.001,  lifetime = 3600, muzzel = 700},  --ac
{drag = 0.0005, lifetime = 3600, muzzel = 600},  --bertha
}
projectile = projectileType[type]
target = {pos = {x = 0, y = 1000}}
function setUp(pitch)
projectile.vel = {}
projectile.pos = {}
projectile.vel.x = projectile.muzzel*math.cos(pitch)
projectile.vel.y = projectile.muzzel*math.sin(pitch)
projectile.pos.x = 0
projectile.pos.y = 0
projectile.ticks = 0
end
function updateVelocities()
projectile.vel.x = projectile.vel.x * (1 - projectile.drag)
projectile.vel.y = projectile.vel.y * (1 - projectile.drag) - 0.5
end
function updatePosition()
projectile.pos.x = projectile.pos.x + projectile.vel.x/60
projectile.pos.y = projectile.pos.y + projectile.vel.y/60
end
function missAmount(pitch)
setUp(pitch)
while (projectile.lifetime >= projectile.ticks and target.pos.x > projectile.pos.x) do
  projectile.ticks = projectile.ticks + 1
  updateVelocities()
  updatePosition()
end
return (projectile.pos.y - target.pos.y)
end
function scan(Stop, Start, Step)
smallestMiss = math.huge
closestAngle = 0
for i=Start,Stop,Step do
  if (math.abs(missAmount(i*math.pi/180)) < smallestMiss) then
    smallestMiss = math.abs(missAmount(i*math.pi/180))
    closestAngle = i
  end
end
return closestAngle
end

function onTick()
target.pos.x = input.getNumber(1)
target.pos.y = input.getNumber(2)

scan1 = scan(90,0,10)
scan2 = scan(scan1 + 10, scan1 - 10, 2.5)
scan3 = scan(scan2 + 2.5,scan2 - 2.5, 0.2)
scan4 = scan(scan3 + 0.2,scan3 - 0.2, 0.04)
scan5 = scan(scan4 + 0.04,scan4 - 0.04, 0.008)

output.setNumber(1,scan5)
end
