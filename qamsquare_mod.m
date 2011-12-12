function y = qamsquare_mod(x)
 
 global mod_type
 
 y=[];
 q=log2(mod_type); % mod_type is global 
 weight=[complex(-1,1);complex(1,1);complex(-1,-1);complex(1,-1)];
 n=1:2;
 gray=[1 0;0 0;1 1;0 1];
 for i=1:length(x)/q
     gray1=[1 0;0 0;1 1;0 1];
     yk=0;
     for k=1:q/2
          for m=1:2
              symbol(m)=x((i-1)*q+(k-1)*2+m);
          end;
          
          for c=1:4
                  if symbol(1)==gray1(c,1) &&  symbol(2)==gray1(c,2)
                     column=c;
                  end;
          end;
    
                               
          if k==q/2
              yk=yk + weight(column);
          else    
              yk=yk + weight(column)*(q/2-k)*2;
              if column==1 
                 gray1=[gray(2,n);gray(1,n);gray(4,n);gray(3,n)];
              elseif column==4 
                 gray1=[gray(3,n);gray(4,n);gray(1,n);gray(2,n)];
              elseif column==3
                 gray1=[gray(4,n);gray(3,n);gray(2,n);gray(1,n)];
              else
                 gray1=gray;
              end;    
          end;
     end;  
     y=[y yk];
end
 
end

