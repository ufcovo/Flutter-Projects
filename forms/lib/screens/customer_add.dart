import 'package:flutter/material.dart';
import 'package:forms/mixins/validation_mixin.dart';
import 'package:forms/models/customer.dart';

class CustomerAdd extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CustomerAddState();
}

class CustomerAddState extends State with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  final customer = Customer();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(25.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            firstNameField(),
            lastNameField(),
            emailField(),
            passwordField(),
            submitButton()
          ],
        ),
      ),
    );
  }

  Widget firstNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "First Name", hintText: "Mert"),
      validator: validateFirstName,
      onSaved: (String? value) {
        customer.firstName = value;
      },
    );
  }

  Widget lastNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Last Name", hintText: "Bulut"),
      validator: validateLastName,
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration:
          InputDecoration(labelText: "Email", hintText: "mail@mail.com"),
      validator: validateEmail,
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(labelText: "Şifre", hintText: "şifre"),
    );
  }

  Widget submitButton() {
    return RaisedButton(
      child: Text("Kaydet"),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          saveCustomer(customer);
        }
      },
    );
  }

  void saveCustomer(Customer customer) {
    print(customer.firstName);
  }
}
