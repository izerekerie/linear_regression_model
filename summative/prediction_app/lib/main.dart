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
          filled: true,
          fillColor: Colors.grey.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
        title: Text(
          'AgroInvest', 
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          )
        ),
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
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFF2E7D32).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.agriculture,
                      size: 48,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Smart Crop Yield Prediction',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Get accurate yield predictions for better farming decisions',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            
            // Action buttons
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF2E7D32).withOpacity(0.3),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PredictionPage()),
                  );
                },
                icon: Icon(Icons.analytics, color: Colors.white, size: 24),
                label: Text(
                  'Start Prediction',
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            
            // Features section
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Key Features',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                  SizedBox(height: 20),
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
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFF2E7D32).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Color(0xFF2E7D32), size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title, 
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.grey.shade800,
                  )
                ),
                SizedBox(height: 4),
                Text(
                  description, 
                  style: TextStyle(
                    color: Colors.grey.shade600, 
                    fontSize: 14,
                    height: 1.3,
                  )
                ),
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
  
  // Controllers for REQUIRED input fields only
  final TextEditingController _plantingYearController = TextEditingController();
  final TextEditingController _plantingMonthController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _cropProductionSystemController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  
  // Optional fields (removed from UI but kept for future use)
  final TextEditingController _seasonNameController = TextEditingController();
  final TextEditingController _qcFlagController = TextEditingController(text: '1');

  String _predictionResult = '';
  bool _isLoading = false;
  bool _hasError = false;

  // Replace with your actual API endpoint
  final String API_BASE_URL = 'https://crop-yield-prediction-a8ho.onrender.com'; // Change this to your deployed URL
  final String PREDICT_ENDPOINT = '/predict';

  @override
  void initState() {
    super.initState();
    // Set current year as default
    _plantingYearController.text = DateTime.now().year.toString();
  }

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
      // Create request body with only required fields
      final requestData = {
        'planting_year': int.parse(_plantingYearController.text),
        'planting_month': int.parse(_plantingMonthController.text),
        'area': double.parse(_areaController.text),
        'product': _productController.text.trim(),
        'crop_production_system': _cropProductionSystemController.text.trim(),
        'country': _countryController.text.trim(),
      };

      // Only add optional fields if they have values
      if (_seasonNameController.text.trim().isNotEmpty) {
        requestData['season_name'] = _seasonNameController.text.trim();
      }
      if (_qcFlagController.text.trim().isNotEmpty) {
        requestData['qc_flag'] = int.parse(_qcFlagController.text);
      }

      final response = await _dio.post(
        '$API_BASE_URL$PREDICT_ENDPOINT',
        data: requestData,
        options: Options(
          headers: {'Content-Type': 'application/json'},
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true) {
          setState(() {
            _predictionResult = '''
🌾 Predicted Yield: ${data['predicted_yield']} ${data['unit']}
📊 Confidence: ${data['confidence']}
🌱 Crop: ${data['input_summary']['crop']}
📍 Country: ${data['input_summary']['country']}
📏 Area: ${data['input_summary']['area']} hectares
📅 Year: ${data['input_summary']['planting_year']}
📆 Month: ${data['input_summary']['planting_month']}
🚜 System: ${data['input_summary']['production_system']}''';
            _hasError = false;
          });
        } else {
          setState(() {
            _predictionResult = 'Error: ${data['detail'] ?? 'Unknown error occurred'}';
            _hasError = true;
          });
        }
      } else {
        setState(() {
          _predictionResult = 'Server error: ${response.statusCode}\n${response.data}';
          _hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        _predictionResult = 'Network error: Make sure your API is running at $API_BASE_URL\n\nError: ${e.toString()}';
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
        title: Text(
          'Crop Yield Prediction',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFF2E7D32),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Required Fields Section
              Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.star, color: Colors.red.shade600, size: 18),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Required Information',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2E7D32),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    
                    // Country (Required)
                    _buildModernTextField(
                      controller: _countryController,
                      label: 'Country',
                      hint: 'e.g., Kenya, Uganda, Tanzania',
                      icon: Icons.public,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Country is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    
                    // Product/Crop (Required)
                    _buildModernTextField(
                      controller: _productController,
                      label: 'Crop Type',
                      hint: 'e.g., maize, wheat, rice, beans',
                      icon: Icons.grass,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Crop type is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    
                    // Area (Required)
                    _buildModernTextField(
                      controller: _areaController,
                      label: 'Farm Area (hectares)',
                      hint: 'e.g., 2.5, 10.0',
                      icon: Icons.landscape,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Farm area is required';
                        }
                        final area = double.tryParse(value.trim());
                        if (area == null || area <= 0) {
                          return 'Please enter a valid area greater than 0';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    
                    // Planting Year and Month in a row
                    Row(
                      children: [
                        Expanded(
                          child: _buildModernTextField(
                            controller: _plantingYearController,
                            label: 'Planting Year',
                            hint: DateTime.now().year.toString(),
                            icon: Icons.calendar_today,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Year is required';
                              }
                              final year = int.tryParse(value.trim());
                              if (year == null || year < 1990 || year > 2030) {
                                return 'Valid year (1990-2030)';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: _buildModernTextField(
                            controller: _plantingMonthController,
                            label: 'Planting Month',
                            hint: '1-12',
                            icon: Icons.event,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Month required';
                              }
                              final month = int.tryParse(value.trim());
                              if (month == null || month < 1 || month > 12) {
                                return 'Valid month (1-12)';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    
                    // Crop Production System (Required)
                    _buildModernTextField(
                      controller: _cropProductionSystemController,
                      label: 'Production System',
                      hint: 'e.g., rainfed, irrigated',
                      icon: Icons.water_drop,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Production system is required';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              
              // Predict Button
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [Color(0xFF2E7D32), Color(0xFF4CAF50)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF2E7D32).withOpacity(0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _makePrediction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: _isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                            SizedBox(width: 16),
                            Text(
                              'Analyzing...',
                              style: TextStyle(
                                fontSize: 18, 
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          'Get Prediction',
                          style: TextStyle(
                            fontSize: 18, 
                            color: Colors.white, 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              SizedBox(height: 24),
              
              // Results Display
              if (_predictionResult.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: _hasError ? Colors.red.shade50 : Colors.green.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _hasError ? Colors.red.shade200 : Colors.green.shade200,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (_hasError ? Colors.red : Colors.green).withOpacity(0.1),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: _hasError ? Colors.red.shade100 : Colors.green.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              _hasError ? Icons.error : Icons.check_circle,
                              color: _hasError ? Colors.red.shade600 : Colors.green.shade600,
                              size: 24,
                            ),
                          ),
                          SizedBox(width: 16),
                          Text(
                            _hasError ? 'Error' : 'Prediction Result',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: _hasError ? Colors.red.shade700 : Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                                            Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _predictionResult,
                          style: TextStyle(
                            fontSize: 15,
                            color: _hasError ? Colors.red.shade700 : Colors.green.shade700,
                            height: 1.6,
                            fontWeight: FontWeight.w500,
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

  Widget _buildModernTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontWeight: FontWeight.normal,
            ),
            prefixIcon: Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFF2E7D32).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon, 
                color: Color(0xFF2E7D32), 
                size: 20,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFF2E7D32), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red.shade400, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red.shade400, width: 2),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}