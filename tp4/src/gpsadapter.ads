with AbstractVitesse; use AbstractVitesse;
with Gps; use Gps;
with Vitesse; use Vitesse;

package GpsAdapter is

   type T_GpsAdapter is new T_AbstractVitesse with private;
   
   procedure Initialise (this: in out T_GpsAdapter; gps: access T_Gps);
   
   function getSpeed(this: access T_GpsAdapter) return T_Vitesse
     with post => (getSpeed'Result.status and getSpeed'Result.value >= 0.0 and getSpeed'Result.value <= 800.0);
   
private
   type T_GpsAdapter is new T_AbstractVitesse with Record
      gps: access T_Gps;
   end record;

end GpsAdapter;
