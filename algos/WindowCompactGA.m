% Compact GA
function [p]=WindowCompactGA(d,K,w,T)
addpath('../binaryproblems')
t=0;
p=ones(1,d)/2;
K=K*w;
fitness = ones(1,w)*(-Inf);
parents = zeros(w,d);
while(t < T)
    % Shift fitness
    fitness = circshift(fitness,[1,1]);
    % Generate nParent
    parents = circshift(parents,[1,0]);
    for j=1:d
        if rand > p(j)
            parents(1,j) = 1;
        else
            parents(1,j) = 0;
        end
    end
    fitness(1) = NoisyOneMax(parents(1,:),1);
    [Y,I] = sort(fitness,'descend');
    idx = find(Y>-Inf,1,'last');
    for i=1:idx-1
        for j=i+1:idx
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
    t = t + 1;
    if(min(p)>=1 || max(p)<=0)
        break;
    end
end
end