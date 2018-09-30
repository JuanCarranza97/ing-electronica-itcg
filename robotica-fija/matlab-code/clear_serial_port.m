serial_info = instrfind;
s = size(serial_info);
s = s(1,2);

if s ~= 0
    for i = 1:1:s
        current_serial = serial_info(i);
        status = current_serial.Status;
    
        if status == "open"
            port = current_serial.Port;
            fprintf("%s is currently open\n",port);   
            while 1
                answer = input('Would you like to close it? \n-[Y]es or [N]o\n','s');
                if(answer == "Y" | answer == 'y' | answer == "Yes" | answer == "yes")
                    fprintf("Closing %s...\n",port);
                    fclose(current_serial);
                    delete(instrfind)
                    fprintf("Done :)\n");
                    break;
                elseif (answer == "N" | answer == 'n' | answer == "No" | answer == "no" )
                    fprintf("Ok.. Bye :c\n");
                    break;
                end       
            end
            clearvars answer current_serial port s ans i serial_info status
            return;
        end  
    end
end

fprintf("Any port is open #_#\n");
delete(instrfind)
clearvars answer current_serial port s ans i serial_info status
