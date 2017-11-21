package body filterBoeing is

   function filter
     (this: access T_FilterBoeing;
      pressure: in Float)
      return Float
   is
   begin
      if this.oldValue = 0.0
      then
         this.oldValue := pressure;
      else
         this.oldValue := (pressure + this.oldValue)/2.0;
      end if;

      return this.oldValue;
   end filter;

end filterBoeing;
