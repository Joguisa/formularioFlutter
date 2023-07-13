import 'package:flutter/material.dart';

class Formulario extends StatefulWidget {
  const Formulario({super.key});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _telefonoController = TextEditingController();
  TextEditingController _edadController = TextEditingController();
  String? _nacionalidadController;
  String _estadoCivilController = '';
  DateTime? _fechaSeleccionada;

  final List<String> _nacionalidades = [
    'Ecuatoriano',
    'Colombiano',
    'Venezolano',
  ];

  final List<String> _estadosCiviles = [
    'Soltero/a',
    'Casado/a',
    'Divorciado/a',
    'Viudo/a',
  ];

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _telefonoController.dispose();
    _edadController.dispose();
    _nacionalidadController = '';
    _estadoCivilController = '';
    super.dispose();
  }

  void _mostrarModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Información del Usuario'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nombre: ${_nombreController.text}'),
              Text('Email: ${_emailController.text}'),
              Text('Teléfono: ${_telefonoController.text}'),
              Text('Edad: ${_edadController.text}'),
              Text('Nacionalidad: $_nacionalidadController.'),
              Text('Estado Civil: $_estadoCivilController'),
              Text('Fecha de Nacimiento: ${_fechaSeleccionada.toString()}'),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _borrarCampos() {
    setState(() {
      _nombreController.clear();
      _emailController.clear();
      _telefonoController.clear();
      _edadController.clear();
      _nacionalidadController = null;
      _estadoCivilController = '';
      _fechaSeleccionada = null;
    });
  }

  bool isValidEmail(String email) {
    String pattern =
        r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)*(\.[a-zA-Z]{2,})$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  bool isNumeric(String value) {
    return double.tryParse(value) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const Row(
                children: [
                  Expanded(
                    child: Image(
                      image: AssetImage('assets/images/christ.jpg'),
                      height: 200,
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  icon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa tu nombre';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _nombreController = newValue as TextEditingController;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  icon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa tu email';
                  } else if (!isValidEmail(value)) {
                    return 'El email no tiene el formato correcto';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _emailController = newValue as TextEditingController;
                },
              ),
              TextFormField(
                controller: _telefonoController,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  icon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa tu teléfono';
                  } else if (value.length < 10) {
                    return 'El teléfono debe tener al menos 10 caracteres';
                  } else if (!isNumeric(value)) {
                    return 'El teléfono solo debe contener números';
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _telefonoController = newValue as TextEditingController;
                },
              ),
              TextFormField(
                controller: _edadController,
                decoration: const InputDecoration(
                  labelText: 'Edad',
                  icon: Icon(Icons.cake),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, ingresa tu edad';
                  } else if (!isNumeric(value)) {
                    return 'La edad solo debe contener números';
                  }

                  return null;
                },
                onSaved: (newValue) {
                  _edadController = newValue as TextEditingController;
                },
              ),
              const SizedBox(height: 16.0),
              ListTile(
                title: const Text('Fecha de Nacimiento'),
                subtitle: Text(_fechaSeleccionada != null
                    ? _fechaSeleccionada.toString()
                    : 'Seleccione una fecha'),
                leading: const Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _fechaSeleccionada = selectedDate;
                    });
                  }
                },
              ),
              const SizedBox(height: 6.0),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Nacionalidad',
                  icon: Icon(Icons.flag),
                ),
                value: _nacionalidadController,
                items: _nacionalidades.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _nacionalidadController = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, selecciona tu nacionalidad';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              const Text('Estado Civil'),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 6.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: 4.0,
                  padding: EdgeInsets.zero,
                  children: _estadosCiviles.map((String estado) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Padding(
                        padding: const EdgeInsets.only(left: 1.0),
                        child: Text(
                          estado,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ),
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      leading: Radio<String>(
                        value: estado,
                        groupValue: _estadoCivilController,
                        onChanged: (String? value) {
                          setState(() {
                            _estadoCivilController = value!;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: SizedBox(
                        height: 40.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _mostrarModal();
                            }
                          },
                          child: const Text('Aceptar'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: SizedBox(
                        height: 40.0,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: _borrarCampos,
                          child: const Text('Borrar'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
