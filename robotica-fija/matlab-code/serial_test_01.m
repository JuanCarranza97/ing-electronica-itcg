fprintf("Initializing ARROB ...\n");
arrob_serie = serial('COM14','BaudRate',115200);
fopen(arrob_serie);
fprintf("Done B)\n");

for i=0:1:10
    fprintf(arrob_serie,"a1");
    fprintf("Led On, i = %d\n",i);
    pause(.5);
    fprintf(arrob_serie,"a0");
    fprintf("Led off\n");
    pause(.5)
    return;
    if i == 5
        fprintf("Mi momento ah llegado .. \n")
        pause(1);
        my_fun()
        break;
    end
end

fprintf("Closing ARROB ...\n");
fclose(arrob_serie);
clearvars arrob_serie i
fprintf("Bye Bye :c \n");

function my_fun()
    fprintf("Se metio a la funcion")
    
end
