function wr=WinRate(x)
d=length(x);
v=0;
for i=1:d
    v=v+x(i)*(2^(d-i));
end
wr=v/(2^d-1);
end