with Vitesse; use Vitesse;
package AbstractVitesse is
   
   type T_AbstractVitesse is abstract tagged null record;
   type T_AbstractVitesse_Access is access all T_AbstractVitesse'Class;
   
   function getSpeed(this: access T_AbstractVitesse) return T_Vitesse is abstract;   

end AbstractVitesse;
