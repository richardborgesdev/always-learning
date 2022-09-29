import 'package:flutter/material.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Formulário de produto',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          15,
        ),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(
                    _priceFocus,
                  );
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Preço',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                focusNode: _priceFocus,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
