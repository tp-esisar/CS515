package body PressureSensor is

   -----------------
   -- Constructor --
   -----------------

   package body Constructor is

      ----------------
      -- Initialize --
      ----------------

      function Initialize
        (status: in Boolean;
         pressure: in Float)
         return T_PressureSensor_Access
      is
         Temp_Ptr : T_PressureSensor_Access;
      begin
         Temp_Ptr := new T_PressureSensor;
         Temp_Ptr.measure.status := status;
         Temp_Ptr.measure.pressure := pressure;
         return Temp_Ptr;
      end Initialize;

   end Constructor;

   -------------------
   -- simuleMeasure --
   -------------------

   overriding procedure simuleMeasure
     (this: access T_PressureSensor;
      pressure: in Float;
      status: in Boolean)
   is
   begin
      this.measure.pressure := pressure;
      this.measure.status := status;
      for I in this.observers'Range loop
         this.observers(I).handleNewPressure(T_AbstractPressureSensor_Access(this));
      end loop;

   end simuleMeasure;


   overriding function getMeasure(this: access T_PressureSensor) return T_Measure
   is
   begin
      return this.measure;
   end getMeasure;


end PressureSensor;