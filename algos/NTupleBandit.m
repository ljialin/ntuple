%function [ res ] = NTupleBandit(T, objFunc, searchSpace, tupleN, r)
T = 10;
objFunc = 'NoisyOneMax'; 
intervals = [1 2; 3 6; 1 10];
searchSpace = SearchSpace(intervals);
tupleN = [1 2];
r = 1;

%NTUPLEBANDIT

% Init the list of ntuples
dim = searchSpace.dim;
nbNTuplesPerN = zeros(1:length(tupleN));
for i=1:length(tupleN)
    nbNTuplesPerN(i) = nchoosek(dim,tupleN(i));
end
nbNTuples = sum(nbNTuplesPerN);
TMP = arrayfun(@(K) EmptyNTuple(K), 1:nbNTuples, 'UniformOutput',0);
tupleArray = horzcat(TMP{:});
clear TMP;
% Put the ntuples
for n=tupleN
    combinations = nchoosek([1:dim], 1);
    for i=1:length(combinations)
        tupleArray(i) = NTuple(combinations(i));
    end
end
% Start optimisation
t = 0;
while t-r <= T 
    % Selection
    [V, I] = max([tupleArray(:).ucb]);
    selectedIdx = I(1);
    fit = objFunc([tupleArray(selectedIdx).vector, r]);
    tupleArray(selectedIdx).mean = ( fit + ...
        tupleArray(selectedIdx).mean * tupleArray(selectedIdx).num ) ...
        / (tupleArray(selectedIdx).num + 1);
        
    t = t + r;
end
%end
