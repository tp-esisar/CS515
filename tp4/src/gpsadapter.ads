with AbstractVitesse; use AbstractVitesse;
with Gps; use Gps;

package GpsAdapter is

   type T_GpsAdapter is new T_AbstractVitesse with private;
   
   procedure Initialise (this: in out T_GpsAdapter; adm: access T_Gps);
   
   function getSpeed(this: access T_GpsAdapter) return Float;
   
private
   type T_GpsAdapter is new T_AbstractVitesse with Record
      gps: access T_Gps;
   end record;

end GpsAdapter;
