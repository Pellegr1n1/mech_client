import 'package:flutter/material.dart';
import 'package:mech_client/screens/register_vehicle_screen.dart';
import 'package:mech_client/models/vehicle.dart';
import 'package:mech_client/services/vehicle_services.dart';

class VehiclePage extends StatelessWidget {
  const VehiclePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: RegisterVehicle(),
        ),
      ),
    );
  }
}

class RegisterVehicle extends StatefulWidget {
  const RegisterVehicle({Key? key}) : super(key: key);

  @override
  _RegisterVehicleState createState() => _RegisterVehicleState();
}

class _RegisterVehicleState extends State<RegisterVehicle> {
  //List<String> vehicles = []; // Lista de veículos do usuário
  static double padding = 3;
  Vehicle vehicle = Vehicle();
  VehicleServices vehicleServices = VehicleServices();

  @override
  void initState() {
    vehicleServices.getVehicle(vehicle);

    super.initState();
    // Chamada para buscar a lista de veículos do usuário
    //fetchUserVehicles();
  }

  /*Future<void> fetchUserVehicles() async {
    try {
      await Firebase.initializeApp();

      var userVehiclesCollection =
          FirebaseFirestore.instance.collection('Vehicles');

      var querySnapshot = await userVehiclesCollection.get();

      print(querySnapshot);

      setState(() {
        vehicles =
            querySnapshot.docs.map((doc) => doc['name'] as String).toList();
      });
    } catch (e) {
      print('Erro ao buscar veículos: $e');
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Column(
                children: [
                  Icon(
                    Icons.directions_car_filled_outlined,
                    size: 50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Veículo',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFF5C00)),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 15, right: 30, top: 5, bottom: 20),
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                        spreadRadius: 1,
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(3, 1)),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: padding, bottom: padding),
                            child: TextFormField(
                              controller: vehicle.plate,
                              decoration:
                                  const InputDecoration(labelText: "Placa"),
                              enabled: false,
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: padding, bottom: padding),
                            child: TextFormField(
                              controller: vehicle.model,
                              decoration:
                                  const InputDecoration(labelText: "Modelo"),
                              enabled: false,
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: padding, bottom: padding),
                            child: TextFormField(
                              controller: vehicle.brand,
                              decoration:
                                  const InputDecoration(labelText: "Marca"),
                              enabled: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: padding, bottom: padding),
                            child: TextFormField(
                              controller: vehicle.yearFabrication,
                              decoration:
                                  const InputDecoration(labelText: "Ano"),
                              enabled: false,
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: padding, bottom: padding),
                            child: TextFormField(
                              controller: vehicle.color,
                              decoration:
                                  const InputDecoration(labelText: "Cor"),
                              enabled: false,
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: padding, bottom: padding),
                            child: TextFormField(
                              controller: vehicle.gearShift,
                              decoration:
                                  const InputDecoration(labelText: "Câmbio"),
                              enabled: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Add another card below this one
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => RegisterVehiclePage()),
                  );
                  // Coloque a ação que você deseja realizar ao tocar no card aqui
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 120, right: 120, top: 5, bottom: 20),
                  margin: const EdgeInsets.only(
                      left: 20, right: 20, top: 20, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        spreadRadius: 1,
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(3, 1),
                      ),
                    ],
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.add_circle_rounded,
                          size: 48.0, color: Color(0xFFFF5C00)),
                      SizedBox(height: 8.0),
                      Text('Adicionar Veículo', textAlign: TextAlign.center),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
