-- Author: SlopeSlayer910
-- GitHub: https://github.com/SlopeSlayer910
-- Workshop: https://steamcommunity.com/profiles/76561198890501264/myworkshopfiles/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey

--Credit for formula
--https://steamcommunity.com/profiles/76561198105241347/myworkshopfiles/?appid=573090
--https://discord.com/channels/357480372084408322/370840938739925003/1291950070555611277

g=math
l=output.setNumber
x=input.getNumber
C=g.rad
F=g.abs
D=g.huge
H=g.sin
y=g.cos
w=g.log
type=property.getNumber("Weapon Type")u=3
G=3
J=3
j=1
t=0
M={{a=.025,k=300,d=800},{a=.02,k=300,d=1000},{a=.01,k=300,d=1000},{a=.005,k=600,d=900},{a=.002,k=3600,d=800},{a=.001,k=3600,d=700},{a=.0005,k=3600,d=600}}_=M[type]f={b={h=0,e=0}}function V(R,a,p)local i=w(1-(60*R*a)/((1-a)*p))/w(1-a)return i
end
function K(U,p,v,a)r=p*y(v)S=p*H(v)i=U
n=1-a
Q=r*n^i
W=r*n^i-.5*(1-n^i)/a
q=n*(1-n^i)/a
O=q*r/60
T=(S*q-.5*(i-q)/a)/60
return O,T,Q,W
end
function L(m)_.s={}_.b={}_.s.h=_.d*y(m)_.s.e=_.d*H(m)_.b.h=0
_.b.e=0
_.Y=0
end
function A(m)L(m)I=V(f.b.h,_.a,_.s.h)if I>_.k then
return D
end
_.b.h,_.b.e=K(I,_.d,m,_.a)return(f.b.e-_.b.e)end
function E(X,P,N)B=D
z=0
for c=P,X,N do
if(F(A(C(c)))<B)then
B=F(A(C(c)))z=c
end
end
return z
end
function onTick()if j==1 then
f.b.h=x(1)f.b.e=x(2)o={E(90,(g.deg(g.atan(f.b.e,f.b.h))//10)*10-10,10)}end
for c=(j-1)*(G-1)+2,j*G,1 do
o[c]=E(o[c-1]+10/(u^(c-2)),o[c-1]-10/(u^(c-2)),10/(u^(c-1)))end
if j>=J then
j=1
t=o[#o]else
j=j+1
end
l(1,t/360)l(2,f.b.h)l(3,f.b.e)l(4,t)l(5,type)end
