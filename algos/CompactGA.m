% Compact GA
function [p]=CompactGA(d,K,nParent,T)
addpath('../binaryproblems')
t=0;
p=ones(1,d)/2;
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
        fitness(i) = NoisyOneMax(parents(i),1);
    end
    [Y,I] = sort(fitness,'descend');
    for i=1:nParent-1
        for j=i+1:nParent
            for k=1:d
                if (parents(I(i),k) ~= parents(I(j),k))
                    if (parents(I(i),k) == 1)
                        p(k) = p(k) + 1/K;
                    else
                        p(k) = p(k) - 1/K;
                    end
                end
            end
        end
    end
    t = t + nParent;
    if(min(p)>=1 || max(p)<=0)
        min(p)
        max(p)
        break;
    end
end
end