fprintf("Initializing ARROB ...\n");
arrob_serie = serial('COM1','BaudRate',115200);
arrob_serie.BytesAvailableFcnMode = 'terminator';
arrob_serie.BytesAvailableFcn = @arrob_serial_complete;
fopen(arrob_serie);
fprintf("Done B)\n");
global a
a = 1

while 1
    keyboard = input('Done\n','s');
    if (keyboard == "b")
        fprintf("%d",a);
        fprintf("Saliendo\n")
        break;
    end
end

fclose(arrob_serie)
delete(arrob_serie)
clearvars arrob_serie keyboard a

function arrob_serial_complete(obj,event)
    global a
    a = 2
    fprintf("Me meti a la interrupcion \n");
end
