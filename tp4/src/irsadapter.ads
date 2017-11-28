with AbstractVitesse; use AbstractVitesse;
with Irs; use Irs;
with Vitesse; use Vitesse;

package IrsAdapter is

   type T_IrsAdapter is new T_AbstractVitesse with private;
   type T_IrsAdapter_Access is access T_IrsAdapter'Class;
   
   procedure Initialise (this: in out T_IrsAdapter; irs: access T_Irs);
   
   function getSpeed(this: access T_IrsAdapter) return T_Vitesse;
   
private
   type T_IrsAdapter is new T_AbstractVitesse with Record
      irs: access T_Irs;
   end record;
   
end IrsAdapter;
