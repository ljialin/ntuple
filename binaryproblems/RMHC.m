% RMHC
function [res]=RMHC(objFuncName,NoisyObjFuncName,d,r,T)
addpath('../binaryproblems')
noisyObjFunc=str2func(NoisyObjFuncName);
objFunc=str2func(objFuncName);
parent=zeros(1,d);
for i=1:d
    if rand < 0.5
        parent(i) = 1;
    end
end
bestSoFarFit = noisyObjFunc(parent,r);
t = r;
res = [objFunc(parent)];
while(t <= T-r)
    child = parent;
    mut = randi(d);
    child(mut) = 1 - parent(mut);
    newFit = noisyObjFunc(child,r);
    if newFit >= bestSoFarFit
        parent = child;
        bestSoFarFit = newFit;
    end
    res = [res objFunc(parent)];
    t = t + r;
end
end