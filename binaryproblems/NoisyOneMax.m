function res=NoisyOneMax(x,r)
noise = randn;
res = OneMax(x) + noise/sqrt(r);
end