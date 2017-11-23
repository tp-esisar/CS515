with AbstractFilter; use AbstractFilter;

package filterBoeing is
   
   type T_FilterBoeing is new T_AbstractFilter with private;
   type T_FilterBoeing_Access is access all T_FilterBoeing'Class;
   
   overriding function filter(this: access T_FilterBoeing;
                   pressure: in Float) return Float;
   
private
   type T_FilterBoeing is new T_AbstractFilter with record
      oldValue: Float := -42.0;
   end record;

end filterBoeing;
