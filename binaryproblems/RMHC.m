% RMHC
T=500;
R=50;
d=10;
trials=10000;
rmhcresults=zeros(R,trials);
hitting1=zeros(1,R);

for r=1:R
    for run=1:trials
        x=RandomBinaryString(d);
        evals=0;
        while evals<=(T-2*r)
            xp=x;
            mut=randi(d);
            xp(mut)=1-xp(mut);
            if NoisyOneMax(xp,r)>=NoisyOneMax(x,r)
                x=xp;
            end
            evals=evals+r*2;
        end
        %disp(sprintf('%d',OneMax(x)));
        rmhcresults(r,run)=OneMax(x);
        if OneMax(x)==d
            hitting1(r)=hitting1(r)+1;
        end
    end
end