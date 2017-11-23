with Ada.Text_IO; use Ada.Text_IO;

package body filterBoeing is

   function filter
     (this: access T_FilterBoeing;
      pressure: in Float)
      return Float
   is
      result: Float;
   begin
      if this.oldValue < 0.0
      then
         result := pressure;
      else
         result := (pressure + this.oldValue)/2.0;
      end if;
      this.oldValue := pressure;
      return result;

   end filter;

end filterBoeing;
