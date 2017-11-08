package Element is
   type T_Element is abstract tagged private;
   type T_Element_Access is access all T_Element'Class;

   package Constructor is
      procedure Initialize(this: access T_Element; name: in String);
   end Constructor;

   procedure Afficher(this: access T_Element; curPath: in String) is abstract;
   procedure SetName(this: access T_Element; n: in String);
   function GetName(this: access T_Element) return String;

private
   type T_Element is abstract tagged record
      name: String(1..11);
   end record;

end Element;
