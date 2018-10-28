pattern = '[A-Za-z][0-9]+([,][0-9]+)*$';

a = input('Enter expression: ','s');
if size(regexp(a,pattern,'match')) == 1 %%Si la expression es correcta
    character = a(1);
    a = erase(a,character);
    numbers = split(a,',')
   
else
    fprintf("Incorrecto")
end
