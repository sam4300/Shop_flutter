import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products_provider.dart';

import '../providers/product.dart';

class EditProductsScreen extends StatefulWidget {
  static const routeName = '/edit-product-screen';

  const EditProductsScreen({Key? key}) : super(key: key);

  @override
  _EditProductsScreenState createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
  final _imageUrlController = TextEditingController();
  final _imageFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _newProd = Product(
    id: null,
    title: '',
    imageUrl: '',
    description: '',
    price: 0.0,
  );

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': ''
  };

  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute
          .of(context)!
          .settings
          .arguments as String?;
      if (productId != null) {
        _newProd = Provider.of<Products>(context).findById(productId);
        _initValues = {
          'title': _newProd.title,
          'description': _newProd.description,
          'price': _newProd.price.toString(),
          'imageUrl': '',
        };
        _imageUrlController.text = _newProd.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageFocusNode.removeListener(_updateImageUrl);
    _imageUrlController.dispose();
    _imageFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      // if ((_imageUrlController.text.startsWith('http') &&
      //         _imageUrlController.text.startsWith('https')) ||
      //     (_imageUrlController.text.endsWith('png') &&
      //         _imageUrlController.text.endsWith('jpg') &&
      //         _imageUrlController.text.endsWith('jpeg'))) {
      //   return;
      // }
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    if (_newProd.id != null) {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_newProd.id!, _newProd);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_newProd);
      } catch (error) {
        await showDialog<Null>(
            context: context,
            builder: (ctx) =>
                AlertDialog(
                  title: Text('Error Found'),
                  content: Text('Error is Found'),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text('Ok'))
                  ],
                ));
      }
      setState(() {
        _isLoading = false;
      });

      Navigator.of(context).pop();
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Edit Product'),
      actions: [
        IconButton(
          onPressed: _saveForm,
          icon: Icon(Icons.save),
        )
      ],
    ),
    body: _isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
      padding: const EdgeInsets.all(18.0),
      child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _initValues['title'],
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _newProd = Product(
                      id: _newProd.id,
                      isFavorite: _newProd.isFavorite,
                      title: value!,
                      imageUrl: _newProd.imageUrl,
                      description: _newProd.description,
                      price: _newProd.price);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter a Title';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _initValues['price'],
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Enter price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Price should be greater than 0';
                  }
                  return null;
                },
                onSaved: (value) {
                  _newProd = Product(
                    id: _newProd.id,
                    isFavorite: _newProd.isFavorite,
                    title: _newProd.title,
                    imageUrl: _newProd.imageUrl,
                    description: _newProd.description,
                    price: double.parse(value!),
                  );
                },
              ),
              TextFormField(
                initialValue: _initValues['description'],
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                keyboardType: TextInputType.multiline,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Description is required';
                  }
                  if (value.length < 10) {
                    return 'description should at least be of 10 letters';
                  }
                  return null;
                },
                onSaved: (value) {
                  _newProd = Product(
                      id: _newProd.id,
                      isFavorite: _newProd.isFavorite,
                      title: _newProd.title,
                      imageUrl: _newProd.imageUrl,
                      description: value!,
                      price: _newProd.price);
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 8, right: 10),
                    decoration: BoxDecoration(
                        border:
                        Border.all(width: 1, color: Colors.grey)),
                    child: _imageUrlController.text.isEmpty
                        ? Text(' Enter a URL')
                        : FittedBox(
                      child: Image.network(
                        _imageUrlController.text,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                        decoration: InputDecoration(
                          labelText: ' Input URL',
                        ),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageFocusNode,
                        onFieldSubmitted: (_) {
                          _saveForm();
                          Navigator.of(context).pop();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter url';
                          }
                          // if (!value.startsWith('http') &&
                          //     !value.startsWith('https')) {
                          //   return 'Enter a valid url';
                          // }
                          // if (!value.endsWith('png') &&
                          //     !value.endsWith('jpg') &&
                          //     !value.endsWith('jpeg')) {
                          //   return 'enter a valid URL';
                          // }
                          return null;
                        },
                        onSaved: (value) {
                          _newProd = Product(
                              id: _newProd.id,
                              isFavorite: _newProd.isFavorite,
                              title: _newProd.title,
                              imageUrl: value!,
                              description: _newProd.description,
                              price: _newProd.price);
                        }),
                  ),
                ],
              )
            ],
          )),
    ),
  );
}}
