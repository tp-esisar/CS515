with AbstractPressureSensor; use AbstractPressureSensor;
with PressureSensor; use PressureSensor;
With Ada.Text_IO; use Ada.Text_IO;
with AdmInt; use AdmInt;
with PressureObserver; use PressureObserver;


procedure Main is
   test: T_AbstractPressureSensor_Access;
   test2: T_AdmInt_Access;
begin
   --  Insert code here.
   test := T_AbstractPressureSensor_Access(PressureSensor.Constructor.Initialize(true, 42.42));
   test2 := new T_AdmInt;
   put_line("----- Debut -----");
end Main;
