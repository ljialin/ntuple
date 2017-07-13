% Compact GA
function [solution]=Baseline(objFuncName,d,K,nParent,T)
addpath('../binaryproblems')
t=0;
p=ones(1,d)/2;
objFunc=str2func(objFuncName);
while(t <= T-nParent)
    % Generate nParent
    parents = zeros(nParent,d);
    fitness = zeros(1,nParent);
    for i=1:nParent
        for j=1:d
            if rand > p(j)
                parents(i,j) = 1;
            else
                parents(i,j) = 0;
            end
        end
        fitness(i) = objFunc(parents(i),1);
    end
    sumFitness = zeros(2,d);
    occurence = zeros(2,d);
    for k=1:d
        for i=1:nParent
            if(parents(i,k)==0)
            	sumFitness(1,k) = sumFitness(1,k) + fitness(i);
                occurence(1,k) = occurence(1,k) + 1;
            else
                sumFitness(2,k) = sumFitness(2,k) + fitness(i);
                occurence(2,k) = occurence(2,k) + 1;
            end
        end
    end
    meanFitness = sumFitness./occurence;
    for k=1:d
        if (meanFitness(1,k) <= meanFitness(2,k))
            p(k) = p(k) + 1/K;
        else
            p(k) = p(k) - 1/K;
        end
    end
    t = t + nParent;
    if(min(p)>=1 || max(p)<=0)
        break;
    end
end
solution=zeros(1,d);
for i=1:d
    if p(i) >= 0.5
        solution(i) = 1;
    end
end
end