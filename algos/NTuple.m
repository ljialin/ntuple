function [ ntuple ] = NTuple( v )
%NTUPLE Create a N-Tuple with a given ntuple
dim = length(v);
ntuple = EmptyNTuple(dim);
ntuple.vector = v;
end