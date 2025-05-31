-- Author: SlopeSlayer910
-- GitHub: https://github.com/SlopeSlayer910
-- Workshop: https://steamcommunity.com/profiles/76561198890501264/myworkshopfiles/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 1095 (1491 with comment) chars

j=math
m=output.setNumber
y=input.getNumber
z=j.rad
x=j.abs
r=j.huge
type=property.getNumber("Weapon Type")q=3
s=3
G=3
k=1
p=0
H={{i=.025,g=300,h=800},{i=.02,g=300,h=1000},{i=.01,g=300,h=1000},{i=.005,g=600,h=900},{i=.002,g=3600,h=800},{i=.001,g=3600,h=700},{i=.0005,g=3600,h=600}}_=H[type]e={a={c=0,b=0}}function B(n)_.f={}_.a={}_.f.c=_.h*j.cos(n)_.f.b=_.h*j.sin(n)_.a.c=0
_.a.b=0
_.o=0
end
function A()_.f.c=_.f.c*(1-_.i)_.f.b=_.f.b*(1-_.i)-.5
end
function F()_.a.c=_.a.c+_.f.c/60
_.a.b=_.a.b+_.f.b/60
end
function t(n)B(n)while(_.g>=_.o and e.a.c>_.a.c)do
_.o=_.o+1
A()F()if(_.a.c+_.f.c*(_.g-_.o))<e.a.c-10 then
return r
end
if(_.f.b<-175)and((_.a.b-e.a.b)<-175)then
return r
end
end
return(_.a.b-e.a.b)end
function v(E,C,D)u=r
w=0
for d=C,E,D do
if(x(t(z(d)))<u)then
u=x(t(z(d)))w=d
end
end
return w
end
function onTick()if k==1 then
e.a.c=y(1)e.a.b=y(2)l={v(90,(j.deg(j.atan(e.a.b,e.a.c))//10)*10-10,10)}end
for d=(k-1)*(s-1)+2,k*s,1 do
l[d]=v(l[d-1]+10/(q^(d-2)),l[d-1]-10/(q^(d-2)),10/(q^(d-1)))end
if k>=G then
k=1
p=l[#l]else
k=k+1
end
m(1,p/360)m(2,e.a.c)m(3,e.a.b)m(4,p)m(5,type)end
