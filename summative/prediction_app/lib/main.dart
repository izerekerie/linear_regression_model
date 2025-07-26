import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(AgroInvestApp());
}

class AgroInvestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroInvest',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Color(0xFF2E7D32),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: Text('AgroInvest', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF2E7D32),
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header section
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.agriculture,
                    size: 64,
                    color: Color(0xFF2E7D32),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Smart Crop Yield Prediction',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Get accurate yield predictions for better farming decisions',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PredictionPage()),
                      );
                    },
                    icon: Icon(Icons.analytics, color: Colors.white),
                    label: Text(
                      'Start Prediction',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2E7D32),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            
            // Features section
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Key Features',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildFeatureItem(Icons.speed, 'Fast & Accurate', 'AI-powered predictions in seconds'),
                  _buildFeatureItem(Icons.eco, 'Multi-Crop Support', 'Supports various crop types'),
                  _buildFeatureItem(Icons.location_on, 'Location-Based', 'Country-specific analysis'),
                  _buildFeatureItem(Icons.schedule, 'Seasonal Insights', 'Optimal planting time recommendations'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Color(0xFF2E7D32), size: 20),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
                Text(description, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PredictionPage extends StatefulWidget {
  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  final _formKey = GlobalKey<FormState>();
  final Dio _dio = Dio();
  
  // Controllers for input fields
  final TextEditingController _plantingYearController = TextEditingController();
  final TextEditingController _plantingMonthController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _cropProductionSystemController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _seasonNameController = TextEditingController();
  final TextEditingController _qcFlagController = TextEditingController(text: '1');

  String _predictionResult = '';
  bool _isLoading = false;
  bool _hasError = false;

  // Replace with your actual API endpoint
  final String API_BASE_URL = 'http://your-backend-url.com';
  final String PREDICT_ENDPOINT = '/predict';

  @override
  void dispose() {
    _plantingYearController.dispose();
    _plantingMonthController.dispose();
    _areaController.dispose();
    _productController.dispose();
    _cropProductionSystemController.dispose();
    _countryController.dispose();
    _seasonNameController.dispose();
    _qcFlagController.dispose();
    super.dispose();
  }

  Future<void> _makePrediction() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _hasError = false;
      _predictionResult = '';
    });

    try {
      final response = await _dio.post(
        '$API_BASE_URL$PREDICT_ENDPOINT',
        data: {
          'planting_year': int.parse(_plantingYearController.text),
          'planting_month': int.parse(_plantingMonthController.text),
          'area': double.parse(_areaController.text),
          'product': _productController.text,
          'crop_production_system': _cropProductionSystemController.text,
          'country': _countryController.text,
          'season_name': _seasonNameController.text.isEmpty ? 'unknown' : _seasonNameController.text,
          'qc_flag': int.parse(_qcFlagController.text),
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true) {
          setState(() {
            _predictionResult = 'Predicted Yield: ${data['predicted_yield']} ${data['unit']}\n'
                               'Confidence: ${data['confidence']}\n'
                               'Crop: ${data['input_summary']['crop']}';
            _hasError = false;
          });
        } else {
          setState(() {
            _predictionResult = 'Error: ${data['error'] ?? 'Unknown error occurred'}';
            _hasError = true;
          });
        }
      } else {
        setState(() {
          _predictionResult = 'Server error: ${response.statusCode}';
          _hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        _predictionResult = 'Network error: ${e.toString()}';
        _hasError = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: Text('Crop Yield Prediction'),
        backgroundColor: Color(0xFF2E7D32),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Farm Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    SizedBox(height: 16),
                    
                    // Planting Year
                    TextFormField(
                      controller: _plantingYearController,
                      decoration: InputDecoration(
                        labelText: 'Planting Year',
                        hintText: 'e.g., 2024',
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter planting year';
                        }
                        final year = int.tryParse(value);
                        if (year == null || year < 1990 || year > 2030) {
                          return 'Please enter a valid year (1990-2030)';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    
                    // Planting Month
                    TextFormField(
                      controller: _plantingMonthController,
                      decoration: InputDecoration(
                        labelText: 'Planting Month',
                        hintText: '1-12',
                        prefixIcon: Icon(Icons.event),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter planting month';
                        }
                        final month = int.tryParse(value);
                        if (month == null || month < 1 || month > 12) {
                          return 'Please enter a valid month (1-12)';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    
                    // Area
                    TextFormField(
                      controller: _areaController,
                      decoration: InputDecoration(
                        labelText: 'Area (hectares)',
                        hintText: 'e.g., 5.0',
                        prefixIcon: Icon(Icons.landscape),
                      ),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter area';
                        }
                        final area = double.tryParse(value);
                        if (area == null || area <= 0) {
                          return 'Please enter a valid area';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    
                    // Product
                    TextFormField(
                      controller: _productController,
                      decoration: InputDecoration(
                        labelText: 'Crop Type',
                        hintText: 'e.g., maize, wheat, rice',
                        prefixIcon: Icon(Icons.grass),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter crop type';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    
                    // Crop Production System
                    TextFormField(
                      controller: _cropProductionSystemController,
                      decoration: InputDecoration(
                        labelText: 'Production System',
                        hintText: 'e.g., rainfed, irrigated',
                        prefixIcon: Icon(Icons.water_drop),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter production system';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    
                    // Country
                    TextFormField(
                      controller: _countryController,
                      decoration: InputDecoration(
                        labelText: 'Country',
                        hintText: 'e.g., Kenya, Uganda',
                        prefixIcon: Icon(Icons.public),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter country';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    
                    // Season Name (Optional)
                    TextFormField(
                      controller: _seasonNameController,
                      decoration: InputDecoration(
                        labelText: 'Season Name (Optional)',
                        hintText: 'e.g., rainy season',
                        prefixIcon: Icon(Icons.wb_sunny),
                      ),
                    ),
                    SizedBox(height: 16),
                    
                    // QC Flag
                    TextFormField(
                      controller: _qcFlagController,
                      decoration: InputDecoration(
                        labelText: 'Quality Control Flag',
                        hintText: '1 or 0',
                        prefixIcon: Icon(Icons.flag),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter QC flag';
                        }
                        final flag = int.tryParse(value);
                        if (flag == null || (flag != 0 && flag != 1)) {
                          return 'Please enter 0 or 1';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              
              // Predict Button
              ElevatedButton(
                onPressed: _isLoading ? null : _makePrediction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2E7D32),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            'Predicting...',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      )
                    : Text(
                        'Predict',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
              SizedBox(height: 24),
              
              // Results Display
              if (_predictionResult.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _hasError ? Colors.red.shade50 : Colors.green.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _hasError ? Colors.red.shade200 : Colors.green.shade200,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            _hasError ? Icons.error : Icons.check_circle,
                            color: _hasError ? Colors.red : Colors.green,
                            size: 24,
                          ),
                          SizedBox(width: 12),
                          Text(
                            _hasError ? 'Error' : 'Prediction Result',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _hasError ? Colors.red.shade700 : Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        _predictionResult,
                        style: TextStyle(
                          fontSize: 16,
                          color: _hasError ? Colors.red.shade600 : Colors.green.shade600,
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