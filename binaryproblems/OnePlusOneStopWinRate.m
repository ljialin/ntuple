% (1+1)-EA
T=500;
runs=10;
R=50;
d=10;
prob=1/d;
trials=10000;
winHitting4=zeros(1,R);
for r=1:R
    for run=1:trials
        x=RandomBinaryString(d);
        evals=0;
        findOpt=0;
        while (findOpt==0&&evals<=T-2*r)
            xp=x;
            for i=1:d
                if rand<=prob
                    xp(i)=1-xp(i);
                end
            end
            if SampleGame(xp,r)>=SampleGame(x,r)
                x=xp;
            end
            evals=evals+r*2;
            if WinRate(x)==1
                findOpt=1;
            end
        end
        if WinRate(x)==1
            winHitting4(r)=winHitting4(r)+1;
        end
    end
end