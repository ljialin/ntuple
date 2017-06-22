function wr=SampleGame(x,r)
p=WinRate(x);
wr=0;
for i=1:r
    if rand<=p
        wr=wr+1;
    end
end
wr=wr/r;
end