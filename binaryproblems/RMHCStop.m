% RMHC
runs=10;
R=50;
d=10;
T=500;
trials=10000;
initPoints=InitPoints(d);
rmhcresultsstop=zeros(R,trials);
RMHCEVALS=zeros(R,trials);
hitting2=zeros(1,R);
for r=1:R
    for run=1:trials
        x=RandomBinaryString(d);
        evals=0;
        findOpt=0;
        while (findOpt==0&&evals<=T-2*r)
            xp=x;
            mut=randi(d);
            xp(mut)=1-xp(mut);
            if NoisyOneMax(xp,r)>=NoisyOneMax(x,r)
                x=xp;
            end
            evals=evals+r*2;
            if OneMax(x)==d
                findOpt=1;
            end
        end
        %disp(sprintf('%d',OneMax(x)));
        rmhcresultsstop(r,run)=OneMax(x);
        RMHCEVALS(r,run)=evals;
        if OneMax(x)==d
            hitting2(r)=hitting2(r)+1;
        end
    end
end