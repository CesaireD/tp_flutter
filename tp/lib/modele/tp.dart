import 'dart:io';

class Salle {
  int id = 0;
  String nom = "";
  String statut = "Salle libre";
  Salle(String s) {
    this.nom = s;
    id++;
  }
  update() {
    (this.statut == "Salle libre")
        ? (this.statut = "Salle occupee")
        : (this.statut = "Salle libre");
  }
}

class Materiel {
  int id = 1;
  String nom = "";
  String statut = "Salle libre";
  Materiel(String n) {
    this.nom = n;
    id++;
  }

  update() {
    (this.statut == "Materiel libre")
        ? (this.statut = "Materiel occupe")
        : (this.statut = "Materiel libre");
  }
}

class Reservation {
  int? id;
  DateTime? date;
  Duration? duree;
  var objet;
  Enseignant? enseignant = Enseignant(nom: "Ted Olie");
  Formation? mat = Formation(nom: "Non defini");
  Reservation({required this.objet, required this.date, required this.duree});
}

class Formation {
  int? id;
  String nom = "";
  Duration duree = Duration(hours: 1);
  Enseignant? responsable;
  Formation({required this.nom});
}

class Enseignant {
  int? id;
  String nom = "";
  Enseignant({required this.nom});

  reserverSalle(Reservation r, Planning p) {
    if(p.matiere.length == 0){
      r.enseignant = this;
      p.matiere.add(r);
      print(
          "======= Salle ${r.objet.nom} reservee par ${this.nom} pour son cours de "
              "${r.mat!.nom} le ${r.date!.day}/${r.date!.month}/${r.date!
              .year}\n========== De ${r.date!.hour} a ${r.date!.add(
              r.duree!).hour} ");
    }else {
      for (int i = 0; i < p.matiere.length; i++) {
        if (r.date!.isAfter(p.matiere[i].date!) &&
            r.date!.isBefore(p.matiere[i].date!.add(p.matiere[i].duree!))) {
          print(
              "======= La salle ${r.objet.nom} est occupee par ${p.matiere[i]
                  .enseignant!.nom} de ${p.matiere[i].date!.hour} a ${p
                  .matiere[i].date!.add(p.matiere[i].duree!).hour} ");
          break;
        } else {
          if (i == p.matiere.length - 1) {
            r.enseignant = this;
            p.matiere.add(r);
            print(
                "======= Salle ${r.objet.nom} reservee par ${this
                    .nom} pour le ${r.date!.day}/${r.date!.month}/${r.date!
                    .year}\n========== De ${r.date!.hour} a ${r.date!.add(
                    r.duree!).hour} ");
          }
        }
      }
    }
  }

  reserverMateriel(Reservation r, Planning p) {
    for (int i = 0; i < p.materiel.length; i++) {
      if (r.date!.isAfter(p.materiel[i].date!) &&
          r.date!.isBefore(p.materiel[i].date!.add(p.materiel[i].duree!))) {
        print(
            "======= Le materiel ${r.objet.nom} est occupee par ${p.materiel[i].enseignant!.nom} de"
                " ${p.materiel[i].date!.hour} a ${p.materiel[i].date!.add(p.matiere[i].duree!).hour} ");
        break;
      } else {
        if (i == p.matiere.length -1) {
          r.enseignant = this;
          p.materiel.add(r);
          print(
              "======= Materiel ${r.objet.nom} reserve par "
                  "${this.nom} pour le ${r.date!.day}/${r.date!.month}/${r.date!.year}\n"
                  "========== De ${r.date!.hour} a ${r.date!.add(r.duree!).hour} ");
        }
      }
    }
  }

  consulterPlanning(Planning p) {
    print(p.recapitulatifHoraire());
  }

  consulterRecapHoraire(Planning p) {
    print(p.recapitulatifHoraire());
  }
}

class Etudiant {
  int? id;
  String nom = "";
  consulterPlanning(Planning p) {
    print(p.recapitulatifHoraire());
  }
}

class Planning {
  int? id;
  DateTime? dateDebut;
  DateTime? dateFin;
  List<Reservation> matiere = [];
  List<Reservation> materiel = [];
  String recapitulatifHoraire() {
    String recap = "Recapitulatif\n ******* Salle *******\n";
    for (int i = 0; i < this.matiere.length; i++) {
      recap =
          "${recap} \n${this.matiere[i].objet.nom!} \ "
              "${this.matiere[i].date!.day}/${this.matiere[i].date!.month}/"
              "${this.matiere[i].date!.year}\n\n"
          "${this.matiere[i].date!.hour}h${this.matiere[i].date!.minute}0 -"
              " ${this.matiere[i].date!.add(this.matiere[i].duree!).hour}h"
              "${this.matiere[i].date!.add(this.matiere[i].duree!).minute}0 "
          "${this.matiere[i].mat!.nom} par ${this.matiere[i].enseignant!.nom}\n";
    }
    recap = "${recap}  \n ******* Materiel *******\n";
    for (int i = 0; i < this.materiel.length; i++) {
      recap =
          "${recap} \n ${this.materiel[i].date!.day}/${this.materiel[i].date!.month}"
              "/${this.materiel[i].date!.year}\n\n"
          "${this.materiel[i].date!.hour}h${this.materiel[i].date!.minute} - "
              "${this.materiel[i].date!.add(this.materiel[i].duree!).hour}:"
              "+${this.materiel[i].date!.add(this.materiel[i].duree!).minute} "
          "${this.materiel[i].mat} => ${this.materiel[i].enseignant}\n";
    }
    return recap;
  }
}

void main() {
  Planning planning = Planning();
  planning.dateDebut = DateTime(2023, 01, 16);
  planning.dateFin = DateTime(2023, 01, 21);
  Salle salle;
  Formation formation;
  Reservation reservation;
  print("\nVotre nom : ");
  Enseignant enseignant = Enseignant(nom: stdin.readLineSync()!);
  bool boucle = true;
  while(boucle) {
    print("1. Consulter planning\n2. Reserver salle\n3. Reserver materiel\n5. Quitter");
    switch(int.parse(stdin.readLineSync()!)){
      case 1: {
        //print("${planning.matiere[0].mat.nom}")
        enseignant.consulterPlanning(planning);
      }break;
      case 2: {
        print(
            "Reservation de salle\nListe des salles : IRAN 1 , IRAN 2, Padtice\nEtes-vous un enseignant ?");
        if (stdin.readLineSync()! == "non") {

        } else {
          print("\nQuelle salle voulez-vous reserver ?");
          salle = Salle(stdin.readLineSync()!);
          print("Formation : ");
          formation = Formation(nom: stdin.readLineSync()!);
          print("Duree (en heure) : ");
          formation.duree = Duration(hours: int.parse(stdin.readLineSync()!));
          print("Pour quelle date voulez-vous reserver la salle \nMois: ");
          int m = int.parse(stdin.readLineSync()!);
          print("\nJour: ");
          int j = int.parse(stdin.readLineSync()!);
          print("\nHeure:");
          int h = int.parse(stdin.readLineSync()!);
          print("\nPour combien d'heures: ");
          reservation = Reservation(objet: salle,
              date: DateTime(2023, m, j, h),
              duree: Duration(hours: int.parse(stdin.readLineSync()!)));
          reservation.enseignant = enseignant;
          reservation.mat = formation;
          enseignant.reserverSalle(reservation, planning);
        }
      }break;
      case 5: {
        boucle = false;
      }break;
    }

  }
}
