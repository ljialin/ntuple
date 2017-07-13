%% Bandit index
%% Author : Jialin Liu
%% CSEE, University of Essex
%% Email: jialin.liu@essex.ac.uk
function [banditIdx,armIdx]=UCB(Bandits, t, k)
e=10e-6;

banditIdx=1;
bestSoFar=-1000000;
for b=1:length(Bandits)
    nbM = Bandits{b}.nbMutate;
    if(nbM>0)
        urgency = -Bandits{b}.maxDelta/nbM + sqrt(log(t)/nbM/k);
    else
        urgency = 1000000;
    end
    urgency = urgency+rand*e;
    if(urgency > bestSoFar)
        banditIdx = b;
        bestSoFar = urgency;
    end
end
bandit = Bandits{banditIdx};
nbM = bandit.nbMutate;
armIdx = 1;
bestSoFar = 0;
for i = 1:bandit.nbArms
    nbP = bandit.nbPulls(i);
    if(nbP>0)
        ucb = bandit.armTRewards(i)/nbP + sqrt(log(nbM)/nbP/k);
    else
        ucb = 1000000;
    end
    ucb = ucb + rand*e;
    if(ucb > bestSoFar)
        armIdx=i;
        bestSoFar=ucb;
    end    
end
end