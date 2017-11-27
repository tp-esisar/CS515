with AbstractVitesse; use AbstractVitesse;
with Irs; use Irs;

package IrsAdapter is

   type T_IrsAdapter is new T_AbstractVitesse with private;
   
   procedure Initialise (this: in out T_IrsAdapter; adm: access T_Irs);
   
   function getSpeed(this: access T_IrsAdapter) return Float;
   
private
   type T_IrsAdapter is new T_AbstractVitesse with Record
      irs: access T_Irs;
   end record;
   
end IrsAdapter;
