with Element; use Element;

package Repertoire is
   type T_Repertoire(size: Natural) is new T_Element with private;
   type T_Repertoire_Access is access all T_Repertoire'Class;
   
   package Constructor is
      function Initialize(name: in String; nbElement: in Natural) return T_Repertoire_Access;
   end Constructor;
   
   procedure AddElement(this: access T_Repertoire; e: in T_Element_Access) 
     with pre=> isFull(this);
   function isFull(this: access T_Repertoire) return Boolean;
   overriding procedure Afficher(this: access T_Repertoire; curPath: in String);
   
private
   
   type T_Array is array(Integer range <>) of T_Element_Access;
   
   type T_Repertoire(size: Natural) is new T_Element with record
      nbElem: Natural := 0;
      indice: Natural := 0;
      elems: T_Array(0..size);
   end record;
   
end Repertoire;
