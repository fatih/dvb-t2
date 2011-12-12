function [z o] =database_generation(q)
z=[];
o=[]
for i=0:q-1
    m=dec2bin(i);
    n=[m(:)];
    e=str2num(n);
    t=transpose(e);
    a=[];
    b=[];
    for k=1:log2(q)
      t(k)= 0;
      p=qamsquare_mod_test(t,q);
      t(k)= 1;
      l=qamsquare_mod_test(t,q);
      a=[a p]; 
      b=[b l];
    end;
    z=[z;a];
    o=[o;b];

end;
end