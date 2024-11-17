-- Author: SlopeSlayer910
-- GitHub: https://github.com/SlopeSlayer910
-- Workshop: https://steamcommunity.com/profiles/76561198890501264/myworkshopfiles/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 974 (1368 with comment) chars

j=math
p=input.getNumber
u=j.rad
s=j.abs
n=j.huge
type=property.getNumber("Weapon Type")o=5
z=5
A={{h=.025,f=300,g=800},{h=.02,f=300,g=1000},{h=.01,f=300,g=1000},{h=.005,f=600,g=900},{h=.002,f=3600,g=800},{h=.001,f=3600,g=700},{h=.0005,f=3600,g=600}}_=A[type]i={a={b=0,c=0}}function w(l)_.d={}_.a={}_.d.b=_.g*j.cos(l)_.d.c=_.g*j.sin(l)_.a.b=0
_.a.c=0
_.m=0
end
function x()_.d.b=_.d.b*(1-_.h)_.d.c=_.d.c*(1-_.h)-.5
end
function y()_.a.b=_.a.b+_.d.b/60
_.a.c=_.a.c+_.d.c/60
end
function q(l)w(l)while(_.f>=_.m and i.a.b>_.a.b)do
_.m=_.m+1
x()y()if(_.a.b+_.d.b*(_.f-_.m))<i.a.b-10 then
return n
end
if(_.d.c<-175)and((_.a.c-i.a.c)<-175)then
return n
end
end
return(_.a.c-i.a.c)end
function r(D,B,C)v=n
t=0
for e=B,D,C do
if(s(q(u(e)))<v)then
v=s(q(u(e)))t=e
end
end
return t
end
function onTick()i.a.b=p(1)i.a.c=p(2)k={r(90,(j.deg(j.atan(i.a.c,i.a.b))//10)*10-10,10)}for e=2,z,1 do
k[e]=r(k[e-1]+10/(o^(e-2)),k[e-1]-10/(o^(e-2)),10/(o^(e-1)))end
output.setNumber(1,k[#k])end
