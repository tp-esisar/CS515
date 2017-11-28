# CS 515 - TP3 : Pattern Stratégie

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

Bilan des contrats

with Post => getValue'Result >= 0.0 and getValue'Result <= 1300.0;



### Adapters : AdmAdapter, IrsAdapter, GpsAdapter 



### AbstractVitesse



### SpeedSelector



### Acpos





## Tests

### Fonction de test

### Fichier de test

### Exécution des tests

### Analyse
