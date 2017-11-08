With Ada.Text_IO; use Ada.Text_IO;
with Element; use Element;
with Fichier;
with Raccourci;
with Repertoire; use Repertoire;

procedure Main is
   rep1: T_Repertoire_Access;
   rep2: T_Repertoire_Access;
   rep1a: T_Element_Access;
   rep2a: T_Element_Access;
   file1: T_Element_Access;
   file2: T_Element_Access;
   file3: T_Element_Access;
   link4: T_Element_Access;

begin
   rep1 := Repertoire.Constructor.Initialize("repertoire1", 10);
   rep2 := Repertoire.Constructor.Initialize("repertoire2", 10);
   rep1a := T_Element_Access(rep1);
   rep2a := T_Element_Access(rep2);
   file1 := Fichier.Constructor.Initialize("fichier1   ");
   file2 := Fichier.Constructor.Initialize("fichier2   ");
   file3 := Fichier.Constructor.Initialize("fichier3   ");
   link4 := Raccourci.Constructor.Initialize("lien4      ", file1);

   Repertoire.AddElement(rep1, file1);
   Repertoire.AddElement(rep1, file2);
   Repertoire.AddElement(rep1, rep2a);
   Repertoire.AddElement(rep2, file3);
   Repertoire.AddElement(rep2, Raccourci.Constructor.Initialize("lien2      ", rep1a));
   Repertoire.AddElement(rep2, Raccourci.Constructor.Initialize("lien3      ", link4));
   Repertoire.AddElement(rep2, link4);
   Repertoire.AddElement(rep1, Raccourci.Constructor.Initialize("lien1      ", file2));


   put_line("----- Debut -----");
   Afficher(T_Element_Access(rep1), "\");
   put_line("----- Fin -----");
end Main;
