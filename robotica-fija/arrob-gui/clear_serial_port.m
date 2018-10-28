serial_info = instrfind;
s = size(serial_info);
s = s(1,2);

if s ~= 0
    for i = 1:1:s
        current_serial = serial_info(i);
        status = current_serial.Status;
    
        if status == "open"
            port = current_serial.Port;
            fprintf("  %s is currently open\n",port);   
                %answer = input('Would you like to close it? \n-[Y]es or [N]o\n','s');
                question = sprintf("%s is currently open\n Would you like to close it?",port);
                answer = questdlg(char(question),'Ooops COM port opened','Yes','No','Yes');
                if string(answer) == 'Yes'
                    fprintf("Closing %s...\n",port);
                    fclose(current_serial);
                    delete(instrfind)
                    fprintf("Done :)\n");
                else
                    fprintf("Ok.. Bye :c\n");
                end       
            clearvars answer current_serial port s ans i serial_info status
            return;
        end  
    end
end

fprintf("Any port is open #_#\n");
delete(instrfind)
clearvars answer current_serial port s ans i serial_info status
