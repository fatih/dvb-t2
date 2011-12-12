function Lr= cell_interleaver_paremeter_generator()

global Ncells;
global r_fec;


Nd= ceil(log2(Ncells));
y(1,:)=[zeros(1,Nd)];
y(2,:)=[1 zeros(1,Nd-1)];
y(3,:)=[zeros(1,Nd-1) 1];
for t=4:2.^Nd
  y(t,3:end)=y(t-1,2:end-1);
  switch Nd 
      case {11}
          y(t,2)= xor (y(t-1,end),y(t-1,end-3)); 
      case {12}
          y(t,2)= xor (y(t-1,end),y(t-1,end-2)); 
      case {13}
          y(t,2)= xor(xor (y(t-1,end),y(t-1,end-1)),xor (y(t-1,end-4),y(t-1,end-6)));
      case {14}
          y(t,2)= xor(xor(xor (y(t-1,end),y(t-1,end-1)),xor (y(t-1,end-4),y(t-1,end-5))),xor (y(t-1,end-9),y(t-1,end-11)));
      case {15}
          y(t,2)= xor(xor (y(t-1,end),y(t-1,end-1)),xor (y(t-1,end-2),y(t-1,end-12)));
  end;
  y(t,1)= mod(t-1,2);

end;


q=1;

for i=1:2.^Nd
  a=num2str(y(i,:));
  Lq(q)= bin2dec(a);
  if Lq(q) < Ncells 
      q=q+1;
  end;
end;

k=0;
X=[];
%%X=zeros(1,r_fec,1);%%3 nisan
for r=1:1:r_fec
    w=2.^Nd;
    while (w>=2.^Nd)
        m=fliplr(dec2bin(k));
        w=bin2dec(m);
        k=k+1;
    end;
    X=[X w];
end;

Lr=zeros(Ncells,r_fec,1);%% 3nisan
for q=1:Ncells
    for n=1:r_fec
        Lr(q,n)=mod((Lq(q)+X(n)),Ncells);
    end;
end;    
        




return

  
  
          

  
