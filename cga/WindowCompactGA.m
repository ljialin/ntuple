% Compact GA
function [res]=WindowCompactGA(objFuncName,NoisyObjFuncName,d,K,w,T)
% objFuncName='OneMax';
% NoisyObjFuncName='NoisyOneMax';
% d=10;
% K=d;
% w=2;
% T=500;

addpath('../binaryproblems')
p=ones(1,d)/2;
fitness = ones(1,w)*(-Inf);
parents = zeros(w,d);
noisyObjFunc=str2func(NoisyObjFuncName);
objFunc=str2func(objFuncName);
res = [];
stop=0;
bestSoFar = zeros(1,d);
for j=1:d
    if rand < p(j)
        bestSoFar(j) = 1;
    end
end
parents(1,:) = bestSoFar;
fitness(1) = noisyObjFunc(parents(1,:),1);
t=1;
while(t < T && stop==0)
    % Shift fitness, first element will be replaced later
    fitness = circshift(fitness,[0,1]);
    % Generate nParent, first row will be replaced later
    parents = circshift(parents,[1,0]);
    for j=1:d
        if rand < p(j)
            parents(1,j) = 1;
        end
    end
    fitness(1) = noisyObjFunc(parents(1,:),1);
%     [Y,I] = sort(fitness,'descend');
%     bestSoFar = parents(I(1),:);
%     idx = find(Y>-Inf,1,'last');
    for i=1:w-1
        for j=i+1:w
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
    t = t + 1;
    stop=1;
    for i=1:d
        if (p(i)<1 & p(i)>0)
            stop=0;
        end
    end
end
end