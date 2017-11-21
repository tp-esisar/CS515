package body filterBoeing is

   function filter
     (this: access T_FilterBoeing;
      pressure: in Float)
      return Float
   is
   begin
      this.oldValue = (this.oldValue = 0.0 ? pressure : (pressure + this.oldValue)/2.0);
      return this.oldValue;
   end filter;

end filterBoeing;
