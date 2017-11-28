# CS 515 - TP4: Pattern Chaine de responsabilité

> Alexis BERTRAND
>
> Guillaume BRUCHON

Logiciel permettant d'estimer la meilleur vitesse en fonction des vitesses reçues des divers équipements.

## Diagramme UML

![Diagramme de Classe](ClassDiagram1.png)

Etant donné que les objets `Adm`, `Irs`et `Gps`sont figés et qu'ils ne corespondent pas à notre abstraction `AbstractVitesse`, nous avons défini des **adapteur**s qui permettent d'adapter l'interface de ces objets à la nôtre.

On retrouve aussi le pattern **chaine de responsabilité** avec le `SpeedSelector` : chaque maillon de la chaine à pour objectif de déterminer s'il est en mesure de donner l'information de vitesse (en utilisant l'`AbstractVitesse` auquel il est lié), ou le cas échant demande au maillon suivant.

L'`Acpos`contient deux listes de `SpeedSelector`: Une pour le *IRS_FIRST*, l'autre pour le *ADM_FISRT* qui sont construit en même temps l'objet lui-même.



## Code source

### Classes figées : Adm, Irs, Gps

Introduction

```Ada
package Adm is
   
   type T_Adm is tagged private;
   type T_Adm_Access is access all T_Adm;
   
   procedure setState(this: access T_Adm; v: in Float; b: in Boolean);
   function getValue(this: access T_Adm) return Float
     with Post => getValue'Result >= 0.0 and getValue'Result <= 1300.0;
   function getStatus(this: access T_Adm) return Boolean;
      
private
   type T_Adm is tagged record
      value: Float;
      status: Boolean;
   end record;
end Adm;
```

> adm.ads

```Ada
package body Adm is

   procedure setState (this: access T_Adm; v: in Float; b: in Boolean) is
   begin
      this.value := v;
      this.status := b;
   end setState;

   function getValue (this: access T_Adm) return Float is
   begin
      return this.value;
   end getValue;

   function getStatus (this: access T_Adm) return Boolean is
   begin
      return this.status;
   end getStatus;

end Adm;
```

> adm.adb

```Ada
package Gps is

   type T_Gps is tagged private;
   type T_Gps_Access is access all T_Gps;
   
   procedure setValue(this: access T_Gps; v: in Float);
   function gpsSpeed(this: access T_Gps) return Float
     with Post => gpsSpeed'Result >= 0.0 and gpsSpeed'Result <= 1000.0;
   
private
   
   type T_Gps is tagged record
      value: Float;
   end record;
end Gps;
```

> gps.ads

```Ada
package body Gps is

   procedure setValue (this: access T_Gps; v: in Float) is
   begin
      this.value := v;
   end setValue;

   function gpsSpeed (this: access T_Gps) return Float is
   begin
      return this.value;
   end gpsSpeed;

end Gps;
```

> gps.adb



Bilan des contrats

with Post => getValue'Result >= 0.0 and getValue'Result <= 1300.0;

with Post => gpsSpeed'Result >= 0.0 and gpsSpeed'Result <= 1000.0;



### Adapters : AdmAdapter, IrsAdapter, GpsAdapter 



### AbstractVitesse



### SpeedSelector



### Acpos





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
