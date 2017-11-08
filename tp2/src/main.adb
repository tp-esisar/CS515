with AbstractPressureSensor; use AbstractPressureSensor;
with PressureSensor; use PressureSensor;
With Ada.Text_IO; use Ada.Text_IO;

procedure Main is
   test: T_AbstractPressureSensor_Access;
begin
   --  Insert code here.
   test := T_AbstractPressureSensor_Access(PressureSensor.Constructor.Initialize(true, 42.42));
   put_line("----- Debut -----");
end Main;
