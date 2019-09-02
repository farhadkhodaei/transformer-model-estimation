beta=0.1;
h=1:1:399;
ho=0:1:399;
for i=1:400
    ho(i)=0;
    h(i)=0;
end
S_Base=250000;
V1_Base=22000;
V2_Base=400;
I2_Base=S_Base/V2_Base;

Rc=mean(DVVx.*DVVx)/mean(Ix.*DVVx);
Ix=Ix-DVVx/Rc;

for Iteration=1:1000
    Iteration
    for i=1:1000
        ho(200+floor(Ix(i)/(2^0.5)/I2_Base*100))=VVx(i)/V2_Base*100*3.14/(2^0.5);
    end
    h=(beta*h+ho)./(1+beta);
   
end
plot(h)
hold
plot(h_simulink(:,1)*100+200,h_simulink(:,2),'*')
plot(-h_simulink(:,1)*100+200,-h_simulink(:,2),'*')
hold

