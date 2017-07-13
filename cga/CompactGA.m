% Compact GA
function [res]=CompactGA(objFuncName,NoisyObjFuncName,d,K,nParent,T)
addpath('../binaryproblems')
t=0;
p=ones(1,d)/2;
noisyObjFunc=str2func(NoisyObjFuncName);
objFunc=str2func(objFuncName);
res = [];
stop=0;
bestSoFar = zeros(1,d);
while(t <= T-nParent && stop==0)
    % Generate nParent
    parents = zeros(nParent,d);
    fitness = zeros(1,nParent);
    for i=1:nParent
        for j=1:d
            if rand < p(j)
                parents(i,j) = 1;
            end
        end
        fitness(i) = noisyObjFunc(parents(i,:),1);
    end
%     [Y,I] = sort(fitness,'descend');
%     bestSoFar = parents(I(1),:);
    for i=1:nParent-1
        for j=i+1:nParent
            if (isinf(fitness(i))==0 && isinf(fitness(j))==0)
                if fitness(i) > fitness(j) % i wins
                    for k=1:d
                        if (parents(i,k) ~= parents(j,k))
                            if (parents(i,k) == 1)
                                p(k) = p(k) + 1/K;
                            else
                                p(k) = p(k) - 1/K;
                            end
                        end
                    end
                else % j wins
                    for k=1:d
                        if (parents(i,k) ~= parents(j,k))
                            if (parents(j,k) == 1)
                                p(k) = p(k) + 1/K;
                            else
                                p(k) = p(k) - 1/K;
                            end
                        end
                    end
                end 
            end
        end
    end
%     res = [res objFunc(bestSoFar)];
    sol = zeros(1,d);
    for i=1:d
        if p(i) > 0.5
            sol(i) =1;
        end
    end
    res = [res objFunc(sol)];
    t = t + nParent;
    stop=1;
    for i=1:d
        if (p(i)<1 & p(i)>0)
            stop=0;
        end
    end
end
end