with AbstractFilter; use AbstractFilter;

package FilterAirbus is
   
   type T_FilterAirbus is new T_AbstractFilter with private;
   type T_FilterAirbus_Access is access all T_FilterAirbus'Class;
   
   package Constructor is
      function Initialize(a: in Float) return T_FilterAirbus_Access;
   end;
   
   overriding function filter(this: access T_FilterAirbus;
                   pressure: in Float) return Float;
   
   private
   type T_FilterAirbus is new T_AbstractFilter with record
      oldValue: Float := 0.0;
      a: Float;
   end record;

end filterAirbus;

