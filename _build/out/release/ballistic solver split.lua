-- Author: SlopeSlayer910
-- GitHub: https://github.com/SlopeSlayer910
-- Workshop: https://steamcommunity.com/profiles/76561198890501264/myworkshopfiles/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 1130 (1526 with comment) chars

j=math
l=output.setNumber
z=j.pi
p=input.getNumber
C=j.rad
B=j.abs
s=j.huge
A=j.sin
y=j.cos
type=property.getNumber("Weapon Type")r=3
v=3
F=3
k=1
q=0
G={{i=.025,h=300,g=800},{i=.02,h=300,g=1000},{i=.01,h=300,g=1000},{i=.005,h=600,g=900},{i=.002,h=3600,g=800},{i=.001,h=3600,g=700},{i=.0005,h=3600,g=600}}_=G[type]d={a={c=0,b=0}}function I(n)_.e={}_.a={}_.e.c=_.g*y(n)_.e.b=_.g*A(n)_.a.c=0
_.a.b=0
_.o=0
end
function H()_.e.c=_.e.c*(1-_.i)_.e.b=_.e.b*(1-_.i)-.5
end
function E()_.a.c=_.a.c+_.e.c/60
_.a.b=_.a.b+_.e.b/60
end
function w(n)I(n)while(_.h>=_.o and d.a.c>_.a.c)do
_.o=_.o+1
H()E()if(_.a.c+_.e.c*(_.h-_.o))<d.a.c-10 then
return s
end
if(_.e.b<-175)and((_.a.b-d.a.b)<-175)then
return s
end
end
return(_.a.b-d.a.b)end
function u(D,J,K)x=s
t=0
for f=J,D,K do
if(B(w(C(f)))<x)then
x=B(w(C(f)))t=f
end
end
return t
end
function onTick()if k==1 then
d.a.c=p(1)*y(p(2)*z*2)d.a.b=p(1)*A(p(2)*z*2)m={u(90,(j.deg(j.atan(d.a.b,d.a.c))//10)*10-10,10)}end
for f=(k-1)*v+2,k*v,1 do
m[f]=u(m[f-1]+10/(r^(f-2)),m[f-1]-10/(r^(f-2)),10/(r^(f-1)))end
if k>=F then
k=1
q=m[#m]else
k=k+1
end
l(1,q/360)l(2,d.a.c)l(3,d.a.b)l(4,q)l(5,type)end
