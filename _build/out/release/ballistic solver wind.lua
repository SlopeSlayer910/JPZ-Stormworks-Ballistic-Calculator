-- Author: SlopeSlayer910
-- GitHub: https://github.com/SlopeSlayer910
-- Workshop: https://steamcommunity.com/profiles/76561198890501264/myworkshopfiles/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 1192 (1588 with comment) chars

l=math
i=output.setNumber
q=l.pi
n=input.getNumber
G=l.rad
E=l.abs
s=l.huge
u=l.sin
t=l.cos
type=property.getNumber("Weapon Type")r=5
K=5
P={{h=.025,k=300,j=800},{h=.02,k=300,j=1000},{h=.01,k=300,j=1000},{h=.005,k=600,j=900},{h=.002,k=3600,j=800},{h=.001,k=3600,j=700},{h=.0005,k=3600,j=600}}_=P[type]e={a={b=0,g=0,c=0}}function N(p)_.d,_.a={},{}_.d.b=_.j*t(p)_.d.g=0
_.d.c=_.j*u(p)_.a.b=0
_.a.g=0
_.a.c=0
_.o=0
end
function M()_.d.b=_.d.b*(1-_.h)+(D*z)_.d.g=_.d.g+(w*z)_.d.c=_.d.c*(1-_.h)-.5
end
function I()_.a.b=_.a.b+_.d.b/60
_.a.g=_.a.g+_.d.g/60
_.a.c=_.a.c+_.d.c/60
end
function B(p)N(p)while(_.k>=_.o and e.a.b>_.a.b)do
_.o=_.o+1
M()I()if(_.a.b+_.d.b*(_.k-_.o))<e.a.b-10 then
return s
end
if(_.d.c<-175)and((_.a.c-e.a.c)<-175)then
return s
end
end
return(_.a.c-e.a.c)end
function C(J,L,O)y=s
v=0
for f=L,J,O do
if(E(B(G(f)))<y)then
y=E(B(G(f)))v=f
end
end
return v
end
function onTick()x=n(1)A=n(2)H=n(3)F=n(4)z=n(5)e.a.b=x*t(A*q*2)e.a.g=0
e.a.c=x*u(A*q*2)D=H*t(F*q*2)w=H*u(F*q*2)m={C(90,l.deg(l.atan(e.a.c,e.a.b))//10-10,10)}for f=2,K,1 do
m[f]=C(m[f-1]+10/(r^(f-2)),m[f-1]-10/(r^(f-2)),10/(r^(f-1)))end
i(1,m[#m]/360)i(2,e.a.b)i(3,e.a.c)i(4,m[#m])i(5,type)i(7,D)i(8,w)i(9,_.a.g)end
