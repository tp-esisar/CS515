with Element; use Element;

package Raccourci is
   type T_Raccourci is new T_Element with private;
   type T_Raccourci_Access is access all T_Raccourci'Class;

   package Constructor is
      function Initialize(n: in String; e: in Element.T_Element_Access) return T_Element_Access;
   end Constructor;
   
   overriding procedure Afficher(this: access T_Raccourci; curPath: in String);
   procedure SetElement(this: access T_Raccourci; e: in Element.T_Element_Access)
     with pre=> this.GetName /= e.GetName;

private

   type T_Raccourci is new Element.T_Element with record
      link: Element.T_Element_Access;
   end record;
   

end Raccourci;
