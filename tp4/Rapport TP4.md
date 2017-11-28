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

```
with Ada.Text_IO; use Ada.Text_IO;
with Adm; use Adm;
with Irs; use Irs;
with Gps; use Gps;
with AdmAdapter; use AdmAdapter;
with IrsAdapter; use IrsAdapter;
with GpsAdapter; use GpsAdapter;
with Acpos; use Acpos;
with test; use test;
with AbstractVitesse; use AbstractVitesse;


procedure Main is
   adm1: T_Adm_Access;
   adm2: T_Adm_Access;
   adm3: T_Adm_Access;
   irs1: T_Irs_Access;
   irs2: T_Irs_Access;
   gps1: T_Gps_Access;
   gps2: T_Gps_Access;
   adm1Adapter: T_AdmAdapter_Access;
   adm2Adapter: T_AdmAdapter_Access;
   adm3Adapter: T_AdmAdapter_Access;
   irs1Adapter: T_IrsAdapter_Access;
   irs2Adapter: T_IrsAdapter_Access;
   gps1Adapter: T_GpsAdapter_Access;
   gps2Adapter: T_GpsAdapter_Access;

   admList: Acpos.List.Vector;
   irsList: Acpos.List.Vector;
   gpsList: Acpos.List.Vector;

   acpos1: T_Acpos_Access;
   acpos2: T_Acpos_Access;

   error: Boolean := False;
begin
   Put_Line("---------- Initialisation ----------");
   adm1 := new T_Adm;
   adm2 := new T_Adm;
   adm3 := new T_Adm;
   irs1 := new T_Irs;
   irs2 := new T_Irs;
   gps1 := new T_Gps;
   gps2 := new T_Gps;
   adm1Adapter := new T_AdmAdapter;
   adm2Adapter := new T_AdmAdapter;
   adm3Adapter := new T_AdmAdapter;
   irs1Adapter := new T_IrsAdapter;
   irs2Adapter := new T_IrsAdapter;
   gps1Adapter := new T_GpsAdapter;
   gps2Adapter := new T_GpsAdapter;
   adm1Adapter.Initialise(adm1);
   adm2Adapter.Initialise(adm2);
   adm3Adapter.Initialise(adm3);
   irs1Adapter.Initialise(irs1);
   irs2Adapter.Initialise(irs2);
   gps1Adapter.Initialise(gps1);
   gps2Adapter.Initialise(gps2);


   --Init acpos1 et acpos2
   admList.Append(T_AbstractVitesse_Access(adm1Adapter));
   admList.Append(T_AbstractVitesse_Access(adm2Adapter));
   admList.Append(T_AbstractVitesse_Access(adm3Adapter));
   irsList.Append(T_AbstractVitesse_Access(irs1Adapter));
   irsList.Append(T_AbstractVitesse_Access(irs2Adapter));
   gpsList.Append(T_AbstractVitesse_Access(gps2Adapter));
   gpsList.Append(T_AbstractVitesse_Access(gps1Adapter));
   acpos1 := new T_Acpos;
   acpos1.Initialise(admList, irsList, gpsList);
   admList.Reverse_Elements;
   irsList.Reverse_Elements;
   gpsList.Reverse_Elements;
   acpos2 := new T_Acpos;
   acpos2.Initialise(admList, irsList, gpsList);



   Put_Line("---------- Debut des tests ----------");

   Put_Line("===> Test 1");
   adm1.setState(100.0, True);
   adm2.setState(500.0, True);
   adm3.setState(1000.0, True);
   irs1.setValue(850.0);
   irs2.setValue(500.0);
   gps1.setValue(950.0);
   gps2.setValue(10.0);
   error := error or testunit(acpos1, acpos2, 100.0*0.514, 1000.0*0.514);

   Put_Line("===> Test 2");
   adm1.setState(100.0, False);
   adm2.setState(500.0, True);
   adm3.setState(1000.0, False);
   error := error or testunit(acpos1, acpos2, 500.0*0.514, 500.0*0.514);

   Put_Line("===> Test 3");
   adm2.setState(500.0, False);
   error := error or testunit(acpos1, acpos2, 500.0, 500.0);

   Put_Line("===> Test 4");
   irs2.setValue(900.0);
   error := error or testunit(acpos1, acpos2, 10.0, 950.0);

   Put_Line("===> Test 5");
   acpos1.setCommand(IRS_FIRST);
   adm1.setState(100.0, True);
   adm2.setState(500.0, False);
   adm3.setState(1000.0, False);
   irs1.setValue(850.0);
   irs2.setValue(800.0);
   gps1.setValue(950.0);
   gps2.setValue(10.0);
   error := error or testunit(acpos1, acpos2, 800.0, 100.0*0.514);

   Put_Line("===> Test 6");
   adm1.setState(100.0, False);
   irs2.setValue(850.0);
   error := error or testunit(acpos1, acpos2, 10.0, 950.0);

   Put_Line("===> Test 7");
   acpos1.setCommand(ADM_FIRST);
   adm1.setState(100.0, True);
   adm2.setState(500.0, True);
   adm3.setState(1000.0, True);
   irs1.setValue(850.0);
   irs2.setValue(500.0);
   gps1.setValue(950.0);
   gps2.setValue(10.0);
   error := error or testunit(acpos1, acpos2, 100.0*0.514, 1000.0*0.514);

   Put_Line("---------- Resultat des tests ----------");
   if error
   then Put_Line("TESTS FAIL");
   else Put_Line("TESTS OK");
   end if;

--   Put_Line("===> Test du contrat");
--   irs2.setValue(1000.0);

end Main;
```

> main.adb

Ce fichier main permet d'executer les tests. Il y a une première phase d'initialisation où l'on instancie nos objets, puis une phase de tests unitares avec affichage dans le terminal ainsi que tests d'assertion (voir fonction `testunit`)

### Exécution des tests

### Analyse

#### Test 1

Dans ce premier test, nous initialisons tous les capteurs avec des valeurs par défaut et les adm avec des valeurs valides et des états OK. On observe que pour chaque acpos, leur premier adm a été choisis (adm1 pour acpos1 et adm3 pour acpos2) Cela confirme en partie l'exigence no 1, les ADM sont bien choisis en premier par défaut et leur ordre est différent selon l'acpos. Ce test valide aussi l'exigence no 4, la conversion kt -> m/s est réalisé par l'adapteur.

#### Test 2

L'état des adm 1 et 3 passe à KO, on observe bien que les deux acpos choisissent leur deuxième adm (adm2) Cela confirme encore un peu plus l'exigence no 1 car la gestion de la priorité semble fonctionner

#### Test 3

L'adm2 passe aussi à l'état KO, et l'irs1 possède une valeur invalide, on observe que les deux acpos utilise bien l'irs2. Cela valide l'exigence 5

#### Test 4 

Cette fois ci c'est au tour de l'irs2 de fournir une valeur erronée, on observe que les deux acpos passent aux gps 1 et 2, l'acpos1 utilise le gps1 et l'acpos2 utilise le gps2, on observe que le valeur de l'acpos2 est 800 alors que le gps2 indique 950, la saturation de l'exigence 6 fonctionne

#### Test 5

Dans ce test, l'acpos1 reçoit la commande `IRS_FIRST` et l'adm1 retourne une valeur valide. l'acpos1 ignore l'irs1 car la valeur est invalide et retourne donc celle de irs2. Cela prouve l'exigence 2 et confirme encore l'exigence 1

#### Test 6

Test identique au test 4, ce dernier permet de confirmer que le gps est utilisé en dernier recours même avec la commande `IRS_FIRST`

#### Test 7

Cette fois ci, la commande `ADM_FIRST` est envoyé au acpos1 et les adm repassent OK, on observe bien que les acpos 1 et 2 utilisent respectivement les adm 1 et 2. L'exigence 2 est validée

#### Exigence 3

L'Exigence 3 est renforcée par la programmation par contrat et ne doit pas arriver.