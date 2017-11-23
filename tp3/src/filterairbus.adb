package body FilterAirbus is

   package body Constructor is
      function Initialize (a: in Float) return T_FilterAirbus_Access
      is
         Temp_Ptr : T_FilterAirbus_Access;
      begin
         Temp_Ptr := new T_FilterAirbus;
         Temp_Ptr.a := a;
         return Temp_Ptr;
      end Initialize;
   end Constructor;

   function filter (this: access T_FilterAirbus; pressure: in Float)
      return Float
   is
   begin
      if this.oldValue < 0.0
      then
         this.oldValue := pressure;
      else
         this.oldValue := pressure + this.a * this.oldValue;
      end if;
      return this.oldValue;

   end filter;

end FilterAirbus;
