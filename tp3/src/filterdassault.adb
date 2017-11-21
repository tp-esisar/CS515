package body FilterDassault is

   function filter
     (this: access T_FilterDassault;
      pressure: in Float)
      return Float
   is
   begin
      return pressure;
   end filter;

end FilterDassault;
