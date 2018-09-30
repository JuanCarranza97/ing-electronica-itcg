current_serial = instrfind;

try
    s = size(current_serial);
    s = s(1,2);
    
    port =  char(current_serial.Port(s));
    if char(current_serial.Status(s)) == "open"
        fprintf("%s is currently open\n",port);   
        while 1
            answer = input('Would you like to close it? \n-[Y]es or [N]o\n','s');
            if(answer == "Y" | answer == 'y' | answer == "Yes" | answer == "yes")
                fprintf("Closing %s...\n",port);
                fclose(current_serial);
                delete(current_serial)
                fprintf("Done :)\n");
                break;
            elseif (answer == "N" | answer == 'n' | answer == "No" | answer == "no" )
                fprintf("Ok.. Bye :c\n");
                break;
            end       
        end
    else
        fprintf('All ports currently closed\n');
        delete(current_serial)
    end
catch
     fprintf("All it's okay\n");
     fprintf("I have not detected any serial port e.e\n");  
end

clearvars answer current_serial port s ans