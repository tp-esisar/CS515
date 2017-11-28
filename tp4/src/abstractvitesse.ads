with Vitesse; use Vitesse;
package AbstractVitesse is
   
   type T_AbstractVitesse is abstract tagged null record;
   
   function getSpeed(this: access T_AbstractVitesse) return T_Vitesse is abstract;   

end AbstractVitesse;
