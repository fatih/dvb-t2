function y = constellation_rotation(x)
%rotates constellation w.r.t. angle given
%x is an array which consists of mapped signals
%modulation= 4,16,64,256 olabilir
%angle deðeri modulation type göre deðiþir
  
  global angle_bb  

  %angle=constellation_rotation_database(mod_type); % TODO: angle is global variable, has to be fixed
  y(1)= real(angle_bb*x(1))+imag(angle_bb*x(1))*1i;
  for i=2:length(x)
      y(i)= real(angle_bb*x(i))+imag(angle_bb*x(i))*1i;
  end;    
end

%sistem in entegresindeki niyetler
%--yapýldý-- 1) angle deðeri databaseden gelicek
%2) real imag fonksiyonlarý cos ve sinus açýlýmlarý kullanýlarak atýlacak

