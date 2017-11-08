with Element; use Element;

package Fichier is
   type T_Fichier is new T_Element with null record;
   type T_Fichier_Access is access all T_Fichier'Class;

   package Constructor is
      function Initialize(name: in String) return T_Element_Access;
   end Constructor;
   
   overriding procedure Afficher(this: access T_Fichier; curPath: in String);
   
end Fichier;
