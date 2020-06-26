import 'package:flutter/material.dart';

class StepperDemo extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StepperDemo'),
        elevation: 0.0,
      ),
      body: Container(
        padding: EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Theme(
              data: Theme.of(context).copyWith(
                primaryColor: Colors.black,
              ),
              child: Stepper(
                currentStep: _currentStep,
                onStepTapped: (int value) {
                  setState(() {
                    _currentStep = value;
                  });
                },
                onStepContinue: () {
                  setState(() {
                    _currentStep < 2 ? _currentStep += 1 : _currentStep = 0;
                  });
                },
                onStepCancel: () {
                  setState(() {
                    _currentStep > 0 ? _currentStep -= 1 : _currentStep = 0;
                  });
                },
                steps: [
                  Step(
                    title: Text('Login'),
                    subtitle: Text("Login first"),
                    content: Text(
                        'Consectetur aliquip cillum laboris commodo anim velit voluptate consequat esse culpa ipsum dolor.'),
                    isActive: _currentStep == 0,
                  ),
                  Step(
                    title: Text('Choice Plan'),
                    subtitle: Text("choic your plan"),
                    content: Text(
                        'Labore quis dolor quis nisi enim eiusmod et sit.'),
                    isActive: _currentStep == 1,
                  ),
                  Step(
                    title: Text('Confirm payment'),
                    subtitle: Text("Comfirm your payment method"),
                    content: Text(
                        'Nostrud dolor ipsum cillum id ullamco occaecat excepteur enim.'),
                    isActive: _currentStep == 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
