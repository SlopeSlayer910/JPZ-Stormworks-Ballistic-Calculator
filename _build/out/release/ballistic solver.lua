-- Author: SlopeSlayer910
-- GitHub: https://github.com/SlopeSlayer910
-- Workshop: https://steamcommunity.com/profiles/76561198890501264/myworkshopfiles/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 974 (1368 with comment) chars

j=math
v=input.getNumber
q=j.rad
u=j.abs
o=j.huge
type=property.getNumber("Weapon Type")n=5
z=5
x={{g=.025,h=300,i=800},{g=.02,h=300,i=1000},{g=.01,h=300,i=1000},{g=.005,h=600,i=900},{g=.002,h=3600,i=800},{g=.001,h=3600,i=700},{g=.0005,h=3600,i=600}}_=x[type]f={a={b=0,c=0}}function D(l)_.e={}_.a={}_.e.b=_.i*j.cos(l)_.e.c=_.i*j.sin(l)_.a.b=0
_.a.c=0
_.m=0
end
function C()_.e.b=_.e.b*(1-_.g)_.e.c=_.e.c*(1-_.g)-.5
end
function B()_.a.b=_.a.b+_.e.b/60
_.a.c=_.a.c+_.e.c/60
end
function r(l)D(l)while(_.h>=_.m and f.a.b>_.a.b)do
_.m=_.m+1
C()B()if(_.a.b+_.e.b*(_.h-_.m))<f.a.b-10 then
return o
end
if(_.e.c<-175)and((_.a.c-f.a.c)<-175)then
return o
end
end
return(_.a.c-f.a.c)end
function p(A,y,w)t=o
s=0
for d=y,A,w do
if(u(r(q(d)))<t)then
t=u(r(q(d)))s=d
end
end
return s
end
function onTick()f.a.b=v(1)f.a.c=v(2)k={p(90,(j.deg(j.atan(f.a.c,f.a.b))//10)*10-10,10)}for d=2,z,1 do
k[d]=p(k[d-1]+10/(n^(d-2)),k[d-1]-10/(n^(d-2)),10/(n^(d-1)))end
output.setNumber(1,k[#k])end
