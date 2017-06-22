function res=NoisyOneMax(x,r)
% res=OneMax(x)+randn/sqrt(r);
res=0;
for i=1:r
    res=res+randn;
end
res=res/r+OneMax(x);
end