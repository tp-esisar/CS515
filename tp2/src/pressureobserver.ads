package PressureObserver is
   type T_PressureObserver is abstract tagged with null record;
   type T_PressureObserver_Access is access all T_PressureObserver'Class;

   procedure handleNewPressure(this: access T_PressureObserver; 
                               sensor: access T_AbstractPressureSensor
                              ) is abstract;

end PressureObserver;
