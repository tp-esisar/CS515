# CS 515 - TP4: Pattern Chaine de responsabilité

> Alexis BERTRAND
>
> Guillaume BRUCHON



## Diagramme UML

![Diagramme de Classe](ClassDiagram1.png)

## Code source



## Tests

### Fonction de test

```
with Acpos; use Acpos;

package test is
   
   function testunit (acpos1: access T_Acpos'Class; 
                  acpos2: access T_Acpos'Class; 
                  expectedSpeed1: in Float;
                  expectedSpeed2: in Float) return Boolean;

end test;
```

> test.ads

```
package body test is

   ----------
   -- test --
   ----------

   function testunit
     (acpos1: access T_Acpos'Class;
      acpos2: access T_Acpos'Class;
      expectedSpeed1: in Float;
      expectedSpeed2: in Float)
      return Boolean
   is
      vitesse1: Float;
      vitesse2: Float;
   begin
      vitesse1 := acpos1.getSpeed;
      vitesse2 := acpos2.getSpeed;
      Put_Line("acpos1 : " & Float'Image(vitesse1) & "/" & Float'Image(expectedSpeed1));
      Put_Line("acpos2 : " & Float'Image(vitesse2) & "/" & Float'Image(expectedSpeed2));
      return (Float'Image(expectedSpeed1) /= Float'Image(vitesse1)) or
        (Float'Image(expectedSpeed2) /= Float'Image(vitesse2));

   end testunit;

end test;
```

> test.adb

Cette fonction de test Permet de réaliser un test unitaire, elle prends en paramètre les deux acpos et des vitesses attendues, affiche le résultat du test et retourne un booléen qui true si il y a une erreur.

### Fichier de test



### Exécution des tests

### Analyse
