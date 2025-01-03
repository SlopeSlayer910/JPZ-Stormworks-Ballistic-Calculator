-- Author: SlopeSlayer910
-- GitHub: https://github.com/SlopeSlayer910
-- Workshop: https://steamcommunity.com/profiles/76561198890501264/myworkshopfiles/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 1192 (1588 with comment) chars

h=math
i=output.setNumber
q=h.pi
n=input.getNumber
H=h.rad
z=h.abs
u=h.huge
r=h.sin
s=h.cos
type=property.getNumber("Weapon Type")t=5
M=5
K={{l=.025,k=300,j=800},{l=.02,k=300,j=1000},{l=.01,k=300,j=1000},{l=.005,k=600,j=900},{l=.002,k=3600,j=800},{l=.001,k=3600,j=700},{l=.0005,k=3600,j=600}}_=K[type]e={a={b=0,g=0,c=0}}function J(p)_.d,_.a={},{}_.d.b=_.j*s(p)_.d.g=0
_.d.c=_.j*r(p)_.a.b=0
_.a.g=0
_.a.c=0
_.o=0
end
function N()_.d.b=_.d.b*(1-_.l)+(w*D)_.d.g=_.d.g+(E*D)_.d.c=_.d.c*(1-_.l)-.5
end
function I()_.a.b=_.a.b+_.d.b/60
_.a.g=_.a.g+_.d.g/60
_.a.c=_.a.c+_.d.c/60
end
function v(p)J(p)while(_.k>=_.o and e.a.b>_.a.b)do
_.o=_.o+1
N()I()if(_.a.b+_.d.b*(_.k-_.o))<e.a.b-10 then
return u
end
if(_.d.c<-175)and((_.a.c-e.a.c)<-175)then
return u
end
end
return(_.a.c-e.a.c)end
function B(O,L,P)x=u
C=0
for f=L,O,P do
if(z(v(H(f)))<x)then
x=z(v(H(f)))C=f
end
end
return C
end
function onTick()F=n(1)A=n(2)G=n(3)y=n(4)D=n(5)e.a.b=F*s(A*q*2)e.a.g=0
e.a.c=F*r(A*q*2)w=G*s(y*q*2)E=G*r(y*q*2)m={B(90,h.deg(h.atan(e.a.c,e.a.b))//10-10,10)}for f=2,M,1 do
m[f]=B(m[f-1]+10/(t^(f-2)),m[f-1]-10/(t^(f-2)),10/(t^(f-1)))end
i(1,m[#m]/360)i(2,e.a.b)i(3,e.a.c)i(4,m[#m])i(5,type)i(7,w)i(8,E)i(9,_.a.g)end
