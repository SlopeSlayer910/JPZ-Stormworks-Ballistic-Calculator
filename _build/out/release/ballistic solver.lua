-- Author: SlopeSlayer910
-- GitHub: https://github.com/SlopeSlayer910
-- Workshop: https://steamcommunity.com/profiles/76561198890501264/myworkshopfiles/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 974 (1368 with comment) chars

j=math
u=input.getNumber
v=j.rad
s=j.abs
n=j.huge
type=property.getNumber("Weapon Type")o=5
w=5
z={{h=.025,g=300,f=800},{h=.02,g=300,f=1000},{h=.01,g=300,f=1000},{h=.005,g=600,f=900},{h=.002,g=3600,f=800},{h=.001,g=3600,f=700},{h=.0005,g=3600,f=600}}_=z[type]i={a={b=0,c=0}}function A(l)_.e={}_.a={}_.e.b=_.f*j.cos(l)_.e.c=_.f*j.sin(l)_.a.b=0
_.a.c=0
_.m=0
end
function C()_.e.b=_.e.b*(1-_.h)_.e.c=_.e.c*(1-_.h)-.5
end
function B()_.a.b=_.a.b+_.e.b/60
_.a.c=_.a.c+_.e.c/60
end
function p(l)A(l)while(_.g>=_.m and i.a.b>_.a.b)do
_.m=_.m+1
C()B()if(_.a.b+_.e.b*(_.g-_.m))<i.a.b-10 then
return n
end
if(_.e.c<-175)and((_.a.c-i.a.c)<-175)then
return n
end
end
return(_.a.c-i.a.c)end
function t(y,x,D)r=n
q=0
for d=x,y,D do
if(s(p(v(d)))<r)then
r=s(p(v(d)))q=d
end
end
return q
end
function onTick()i.a.b=u(1)i.a.c=u(2)k={t(90,(j.deg(j.atan(i.a.c,i.a.b))//10)*10-10,10)}for d=2,w,1 do
k[d]=t(k[d-1]+10/(o^(d-2)),k[d-1]-10/(o^(d-2)),10/(o^(d-1)))end
output.setNumber(1,k[#k])end
