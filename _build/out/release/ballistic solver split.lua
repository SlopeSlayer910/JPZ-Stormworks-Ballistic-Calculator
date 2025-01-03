-- Author: SlopeSlayer910
-- GitHub: https://github.com/SlopeSlayer910
-- Workshop: https://steamcommunity.com/profiles/76561198890501264/myworkshopfiles/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 1095 (1491 with comment) chars

j=math
l=output.setNumber
t=input.getNumber
z=j.rad
y=j.abs
r=j.huge
type=property.getNumber("Weapon Type")q=3
w=3
D=3
k=1
p=0
B={{h=.025,i=300,g=800},{h=.02,i=300,g=1000},{h=.01,i=300,g=1000},{h=.005,i=600,g=900},{h=.002,i=3600,g=800},{h=.001,i=3600,g=700},{h=.0005,i=3600,g=600}}_=B[type]d={a={b=0,c=0}}function C(n)_.f={}_.a={}_.f.b=_.g*j.cos(n)_.f.c=_.g*j.sin(n)_.a.b=0
_.a.c=0
_.o=0
end
function A()_.f.b=_.f.b*(1-_.h)_.f.c=_.f.c*(1-_.h)-.5
end
function F()_.a.b=_.a.b+_.f.b/60
_.a.c=_.a.c+_.f.c/60
end
function x(n)C(n)while(_.i>=_.o and d.a.b>_.a.b)do
_.o=_.o+1
A()F()if(_.a.b+_.f.b*(_.i-_.o))<d.a.b-10 then
return r
end
if(_.f.c<-175)and((_.a.c-d.a.c)<-175)then
return r
end
end
return(_.a.c-d.a.c)end
function s(G,E,H)u=r
v=0
for e=E,G,H do
if(y(x(z(e)))<u)then
u=y(x(z(e)))v=e
end
end
return v
end
function onTick()if k==1 then
d.a.b=t(1)d.a.c=t(2)m={s(90,(j.deg(j.atan(d.a.c,d.a.b))//10)*10-10,10)}end
for e=(k-1)*(w-1)+2,k*w,1 do
m[e]=s(m[e-1]+10/(q^(e-2)),m[e-1]-10/(q^(e-2)),10/(q^(e-1)))end
if k>=D then
k=1
p=m[#m]else
k=k+1
end
l(1,p/360)l(2,d.a.b)l(3,d.a.c)l(4,p)l(5,type)end
