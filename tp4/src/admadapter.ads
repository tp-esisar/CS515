with AbstractVitesse; use AbstractVitesse;
with Adm; use Adm;
with Vitesse; use Vitesse;

package AdmAdapter is
   
   type T_AdmAdapter is new T_AbstractVitesse with private;
   type T_AdmAdapter_Access is access T_AdmAdapter'Class;
   
   procedure Initialise (this: in out T_AdmAdapter; adm: access T_Adm);
   
   function getSpeed(this: access T_AdmAdapter) return T_Vitesse
     with post => (not getSpeed'Result.status) or 
     (getSpeed'Result.status and getSpeed'Result.value >= 0.0 and getSpeed'Result.value <= 668.2);
   
   ktsToms : constant Float := 0.514;
   
private
   type T_AdmAdapter is new T_AbstractVitesse with Record
      adm: access T_Adm;
   end record;

end AdmAdapter;
