-- Author: SlopeSlayer910
-- GitHub: https://github.com/SlopeSlayer910
-- Workshop: https://steamcommunity.com/profiles/76561198890501264/myworkshopfiles/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 1192 (1588 with comment) chars

j=math
k=output.setNumber
p=j.pi
n=input.getNumber
A=j.rad
B=j.abs
s=j.huge
t=j.sin
u=j.cos
type=property.getNumber("Weapon Type")r=5
P=5
O={{l=.025,i=300,h=800},{l=.02,i=300,h=1000},{l=.01,i=300,h=1000},{l=.005,i=600,h=900},{l=.002,i=3600,h=800},{l=.001,i=3600,h=700},{l=.0005,i=3600,h=600}}_=O[type]e={a={c=0,g=0,b=0}}function K(o)_.d,_.a={},{}_.d.c=_.h*u(o)_.d.g=0
_.d.b=_.h*t(o)_.a.c=0
_.a.g=0
_.a.b=0
_.q=0
end
function I()_.d.c=_.d.c*(1-_.l)+(y*v)_.d.g=_.d.g+(C*v)_.d.b=_.d.b*(1-_.l)-.5
end
function J()_.a.c=_.a.c+_.d.c/60
_.a.g=_.a.g+_.d.g/60
_.a.b=_.a.b+_.d.b/60
end
function z(o)K(o)while(_.i>=_.q and e.a.c>_.a.c)do
_.q=_.q+1
I()J()if(_.a.c+_.d.c*(_.i-_.q))<e.a.c-10 then
return s
end
if(_.d.b<-175)and((_.a.b-e.a.b)<-175)then
return s
end
end
return(_.a.b-e.a.b)end
function F(L,M,N)D=s
x=0
for f=M,L,N do
if(B(z(A(f)))<D)then
D=B(z(A(f)))x=f
end
end
return x
end
function onTick()H=n(1)G=n(2)w=n(3)E=n(4)v=n(5)e.a.c=H*u(G*p*2)e.a.g=0
e.a.b=H*t(G*p*2)y=w*u(E*p*2)C=w*t(E*p*2)m={F(90,j.deg(j.atan(e.a.b,e.a.c))//10-10,10)}for f=2,P,1 do
m[f]=F(m[f-1]+10/(r^(f-2)),m[f-1]-10/(r^(f-2)),10/(r^(f-1)))end
k(1,m[#m]/360)k(2,e.a.c)k(3,e.a.b)k(4,m[#m])k(5,type)k(7,y)k(8,C)k(9,_.a.g)end
