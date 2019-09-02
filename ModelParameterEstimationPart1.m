V1=yout(:,1);
I1=yout(:,2);
I2=yout(:,3);
V2=yout(:,4);

TBase=0.00002;
S_Base=250000;
V1_Base=22000;
V2_Base=400;
a=V1_Base/V2_Base;
Z1_Base=V1_Base^2/S_Base;
Z2_Base=V2_Base^2/S_Base;

R1_PU=0.02;
R2_PU=0.02;
X1_PU=0.08;
X2_PU=0.08;


R1=R1_PU*Z1_Base;
R2=R2_PU*Z2_Base;
X1=X1_PU*Z1_Base;
X2=X2_PU*Z2_Base;

a=1;

L1=X1/6.28/50;
L2=X2/6.28/50;

alpha=0.00001;

VV1=0:1:999;
VV2=0:1:999;
II1=0:1:999;
II2=0:1:999;
for i=1:1000
    VV1(i)=0;
    VV2(i)=0;
    II1(i)=0;
    II2(i)=0;
end
for Iteration=1:1000
    Iteration
    for i=2:1001
        Indice=i;
        if Indice>1000
            Indice=Indice-1000;
        end
        Indice_Pre=Indice-1;
        if Indice_Pre<1
            Indice_Pre=Indice_Pre+1000;
        end
        Indice_Pre2=Indice_Pre-1;
        if Indice_Pre2<1
            Indice_Pre2=Indice_Pre2+1000;
        end
        VV1(Indice)=(1-alpha)*VV1(Indice_Pre)+TBase*V1(Indice);
        VV2(Indice)=(1-alpha)*VV2(Indice_Pre)+TBase*V2(Indice);
        II1(Indice)=(1-alpha)*II1(Indice_Pre)+TBase*I1(Indice);
        II2(Indice)=(1-alpha)*II2(Indice_Pre)+TBase*I2(Indice);
        
        
        
        VVx(Indice)=VV2(Indice)+R2*II2(Indice)+L2*I2(Indice);
        VVxp(Indice)=VV1(Indice)-R1*II1(Indice)-L1*I1(Indice);
        
        DVVx(Indice)=1/TBase*(VVx(Indice)-VVx(Indice_Pre));
        DVVxp(Indice)=1/TBase*(VVxp(Indice)-VVxp(Indice_Pre));
        Ix(Indice)=I1(Indice)*a-I2(Indice);
        
    end
    a=max(abs(DVVxp))/max(abs(DVVx));
end

figure(1)
plot(VVxp/a)
hold
plot(VVx)
hold
max(abs(DVVxp/a)-abs(DVVx))
figure(2)
plot(DVVx)
figure(3)
plot(Ix)
