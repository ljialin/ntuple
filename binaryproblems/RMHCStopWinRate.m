% RMHC
runs=10;
R=50;
d=10;
T=500;
trials=10000;
winHitting2=zeros(1,R);
for r=1:R
    for run=1:trials
        x=RandomBinaryString(d);
        evals=0;
        findOpt=0;
        while (findOpt==0&&evals<=T-2*r)
            xp=x;
            mut=randi(d);
            xp(mut)=1-xp(mut);
            if SampleGame(xp,r)>=SampleGame(x,r)
                x=xp;
            end
            evals=evals+r*2;
            if WinRate(x)==1
                findOpt=1;
            end
        end
        if WinRate(x)==1
            winHitting2(r)=winHitting2(r)+1;
        end
    end
end