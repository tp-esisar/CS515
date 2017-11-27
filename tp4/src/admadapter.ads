with AbstractVitesse; use AbstractVitesse;
with Adm; use Adm;

package AdmAdapter is
   
   type T_AdmAdapter is new T_AbstractVitesse with private;
   
   procedure Initialise (this: in out T_AdmAdapter; adm: access T_Adm);
   
   function getSpeed(this: access T_AdmAdapter) return Float;
   
private
   type T_AdmAdapter is new T_AbstractVitesse with Record
      adm: access T_Adm;
   end record;

end AdmAdapter;
