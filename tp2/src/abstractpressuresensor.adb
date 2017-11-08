package body AbstractPressureSensor is

   --------------------
   -- recordObserver --
   --------------------

   procedure recordObserver
     (this: access T_AbstractPressureSensor;
      observer: access T_PressureObserver)
   is
   begin
      this.observers.Append(observer);
   end recordObserver;



end AbstractPressureSensor;
