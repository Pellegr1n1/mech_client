import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:mech_client/models/vehicle_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mech_client/utils/feedback_utils.dart';

class VehicleServices {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> registerVehicle(Vehicle vehicle, context) async {
    try {
      final User? user = firebaseAuth.currentUser;

      if (user != null) {
        // consulta a lista de veículos do usuário
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get();

        // verifica se os dados existem e são do tipo Map
        if (userSnapshot.exists &&
            userSnapshot.data() is Map<String, dynamic>) {
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;

          List<dynamic> userVehicles = userData['vehicles'] ?? [];

          // verifica se o usuário já possui 3 ou mais veículos
          if (userVehicles.length >= 3) {
            FeedbackUtils.showErrorSnackBar(context,
                "Limite de veículos atingido. Não é possível cadastrar mais veículos.");
            return;
          }

          // verifica se a placa já está em uso
          bool plateExists = await checkIfPlateExists(vehicle.plate.text);

          if (plateExists) {
            FeedbackUtils.showErrorSnackBar(
              context,
              "Já existe um veículo cadastrado com esta placa.",
            );
            return;
          }
        }

        // armazena os dados do veículo
        Map<String, dynamic> vehicleData = {
          'id': user.uid,
          'plate': vehicle.plate.text,
          'model': vehicle.model.text,
          'color': vehicle.color.text,
          'brand': vehicle.brand.text,
          'gearShift': vehicle.gearShift.text,
          'yearFabrication': vehicle.yearFabrication.text,
        };

        // insere dados na colecao veiculo
        await FirebaseFirestore.instance
            .collection('Vehicles')
            .doc(vehicle.plate.text)
            .set(vehicleData);

        // adiciona a placa à lista de veículos do usuário array
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .update({
          'vehicles': FieldValue.arrayUnion([vehicle.plate.text]),
        });

        FeedbackUtils.showSuccessSnackBar(
            context, "Cadastro efetuado com sucesso!");
        Navigator.of(context).pop();
      }
    } catch (e) {
      print('Erro ao registrar as informações do veículo: $e');
    }
  }

  Future<bool> checkIfPlateExists(String plate) async {
    try {
      DocumentSnapshot plateSnapshot = await FirebaseFirestore.instance
          .collection('Vehicles')
          .doc(plate)
          .get();

      return plateSnapshot.exists;
    } catch (e) {
      print('Erro ao verificar se a placa já existe: $e');
      return false;
    }
  }

  Future<List<Vehicle>> getVehiclesForUser() async {
    try {
      User? user = firebaseAuth.currentUser;

      if (user != null) {
        var collection = FirebaseFirestore.instance.collection('Vehicles');

        // Consulta os veículos associados ao usuário pelo user.uid
        QuerySnapshot querySnapshot =
            await collection.where('id', isEqualTo: user.uid).get();

        List<Vehicle> vehicles = [];

        // Itera sobre os documentos encontrados na consulta
        for (QueryDocumentSnapshot snapshot in querySnapshot.docs) {
          Vehicle vehicle = Vehicle();

          // Preenche os controladores do objeto Vehicle com os dados obtidos.
          vehicle.brand.text = snapshot['brand'] ?? 'campo vazio';
          vehicle.color.text = snapshot['color'] ?? 'campo vazio';
          vehicle.model.text = snapshot['model'] ?? 'campo vazio';
          vehicle.gearShift.text = snapshot['gearShift'] ?? 'campo vazio';
          vehicle.yearFabrication.text =
              snapshot['yearFabrication'] ?? 'campo vazio';
          vehicle.plate.text = snapshot['plate'] ?? 'campo vazio';

          vehicles.add(vehicle);
        }

        return vehicles;
      }

      return [];
    } catch (e) {
      print('Erro ao obter informações dos veículos: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>?> getVehicleByPlate(String plate) async {
    try {
      User? user = firebaseAuth.currentUser;

      if (user != null) {
        var collection = FirebaseFirestore.instance.collection('Vehicles');

        QuerySnapshot<Map<String, dynamic>> querySnapshot = await collection
            .where('id', isEqualTo: user.uid)
            .where('plate', isEqualTo: plate)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // Se houver documentos correspondentes, retorna os dados do primeiro (assumindo que a placa é única)
          return querySnapshot.docs.first.data();
        } else {
          print("Nenhum carro");
          return null;
        }
      }

      return null;
    } catch (e) {
      print('Erro ao verificar a existência do veículo: $e');
      throw e;
    }
  }
}
