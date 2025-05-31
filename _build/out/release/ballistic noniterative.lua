-- Author: SlopeSlayer910
-- GitHub: https://github.com/SlopeSlayer910
-- Workshop: https://steamcommunity.com/profiles/76561198890501264/myworkshopfiles/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 1172 (1568 with comment) chars

f=math
o=output.setNumber
I=input.getNumber
E=f.rad
G=f.abs
B=f.huge
D=f.sin
H=f.cos
C=f.log
type=property.getNumber("Weapon Type")q=3
y=3
N=3
i=1
s=0
K={{_=.025,j=300,d=800},{_=.02,j=300,d=1000},{_=.01,j=300,d=1000},{_=.005,j=600,d=900},{_=.002,j=3600,d=800},{_=.001,j=3600,d=700},{_=.0005,j=3600,d=600}}a=K[type]e={b={g=0,h=0}}function Q(V,_,p)local k=C(1-(60*V*_)/((1-_)*p))/C(1-_)return k
end
function M(L,p,w,_)local r=p*H(w)local W=p*D(w)local k=L
local l=1-_
local R=r*l^k
local T=r*l^k-.5*(1-l^k)/_
local t=l*(1-l^k)/_
local P=t*r/60
local X=(W*t-.5*(k-t)/_)/60
return P,X,R,T
end
function J(n)a.u={}a.b={}a.u.g=a.d*H(n)a.u.h=a.d*D(n)a.b.g=0
a.b.h=0
a.Y=0
end
function v(n)J(n)local A=Q(e.b.g,a._,a.u.g)if A>a.j then
return B
end
a.b.g,a.b.h=M(A,a.d,n,a._)return(e.b.h-a.b.h)end
function x(S,U,O)z=B
F=0
for c=U,S,O do
if(G(v(E(c)))<z)then
z=G(v(E(c)))F=c
end
end
return F
end
function onTick()if i==1 then
e.b.g=I(1)e.b.h=I(2)m={x(90,(f.deg(f.atan(e.b.h,e.b.g))//10)*10-10,10)}end
for c=(i-1)*(y-1)+2,i*y,1 do
m[c]=x(m[c-1]+10/(q^(c-2)),m[c-1]-10/(q^(c-2)),10/(q^(c-1)))end
if i>=N then
i=1
s=m[#m]else
i=i+1
end
o(1,s/360)o(2,e.b.g)o(3,e.b.h)o(4,s)o(5,type)end
