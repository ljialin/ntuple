%% MABRMHC
%% Author : Jialin Liu
%% CSEE, University of Essex
%% Email: jialin.liu@essex.ac.uk
function [res] = MABRMHC(objFuncName,NoisyObjFuncName,d,r,T)
for b=1:d
    Bandits{b}.maxDelta=0;
    Bandits{b}.nbArms=2;
    Bandits{b}.values=[0 1];
    Bandits{b}.armTRewards=zeros(1,2);
    Bandits{b}.nbPulls=zeros(1,2);
    Bandits{b}.nbMutate=0;
end
addpath('../binaryproblems')

noisyObjFunc=str2func(NoisyObjFuncName);
objFunc=str2func(objFuncName);
res = [];
parent = zeros(1,d);
for i=1:d
    parent(i) = randi(2) - 1;
end
bestSoFarFit = noisyObjFunc(parent,r);
t = r;
pulls=1;
while(t < T - r)
    child = parent;
    [mut,armIdx]=UCB(Bandits,t,2);
    child(mut)=Bandits{mut}.values(armIdx);
    newFit = noisyObjFunc(child,r);
    delta = newFit - bestSoFarFit;
    Bandits{mut}.maxDelta=Bandits{mut}.maxDelta+delta;
    Bandits{mut}.armTRewards(armIdx)=Bandits{mut}.armTRewards(armIdx)+delta;
    Bandits{mut}.nbPulls(armIdx)=Bandits{mut}.nbPulls(armIdx)+1;
    Bandits{mut}.nbMutate=Bandits{mut}.nbMutate+1;
    if newFit >= bestSoFarFit
        parent = child;
        bestSoFarFit = newFit;
    end
    res = [res objFunc(parent,r)];
    t = t + r;
    pulls = pulls + 1;
end
end