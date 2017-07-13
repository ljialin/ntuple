function [ ntuple ] = EmptyNTuple( dim )
%EMPTYNTUPLE Create an empty N-Tuple
field1 = 'vector';
value1 = NaN(1,dim);
field2 = 'mean';
value2 = NaN;
field3 = 'num';
value3 = 0;
field4 = 'ucb';
value4 = Inf;
ntuple = struct(field1,value1,field2,value2,field3,value3,field4,value4);
end