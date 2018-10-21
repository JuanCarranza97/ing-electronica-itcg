controllerLibrary = NET.addAssembly([pwd '\SharpDX.XInput.dll']);
global myController
myController = SharpDX.XInput.Controller(SharpDX.XInput.UserIndex.One);
VibrationLevel = SharpDX.XInput.Vibration;
t = timer('TimerFcn',@my_callback_fcn,'Period',.01,'StartDelay',.5,'ExecutionMode','fixedRate');
start(t);

fprintf("You pressed %d buttons\n",num);
pause(5);
stop(t);
VibrationLevel.LeftMotorSpeed=0;
myController.SetVibration(VibrationLevel);

function my_callback_fcn(obj, event)
global myController
State = myController.GetState();
VibrationLevel = SharpDX.XInput.Vibration;
VibrationLevel.LeftMotorSpeed = double(State.Gamepad.LeftTrigger)*255;
myController.SetVibration(VibrationLevel);
ButtonStates = ButtonStateParser(State.Gamepad.Buttons);
buttons = struct2array(ButtonStates);
num = 0;
for i = buttons
    if i
        num=num+1;
    end        
end
clc
fprintf("Presionaste %d botones, Left = %d\n",num,State.Gamepad.LeftThumbX);
end
