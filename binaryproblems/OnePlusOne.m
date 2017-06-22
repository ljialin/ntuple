% (1+1)-EA
T=500;
R=50;
d=10;
prob=1/d;
trials=10000;
oporesults=zeros(R,trials);
hitting3=zeros(1,R);
for r=1:R
    for run=1:trials
        x=RandomBinaryString(d);
        evals=0;
        while evals<=(T-2*r)
            xp=x;
            for i=1:d
                if rand<=prob
                    xp(i)=1-xp(i);
                end
            end
            if NoisyOneMax(xp,r)>=NoisyOneMax(x,r)
                x=xp;
            end
            evals=evals+r*2;
        end
        oporesults(r,run)=OneMax(x);
        if OneMax(x)==d
            hitting3(r)=hitting3(r)+1;
        end
    end
end