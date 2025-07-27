# 🌾 AI-Powered Crop Yield Prediction System

## 🎯 Mission
Developing an AI-powered linear regression model to predict optimal crop yields across different regions in Africa and globally, enabling farmers and agricultural investors to make data-driven decisions about which crops to plant in specific areas based on geographic, seasonal, and production system factors. This model will help reduce agricultural investment risks, improve food security, and guide sustainable farming practices by predicting crop performance before planting.

## 📊 Data Source
**Dataset**: HarvestStat Africa – Harmonized Subnational Crop Statistics for Sub-Saharan Africa (hvstat_africa_data_v1.0.csv)  
**Source**: Scientific dataset published in *Scientific Data* journal by multiple international research institutions  
**Citation**: D. Lee, W. Anderson, X. Chen, et al. (2025), HarvestStat Africa – Harmonized Subnational Crop Statistics for Sub-Saharan Africa. *Scientific Data*, https://doi.org/10.1038/s41597-025-05001-z  
**Coverage**: 574,204 records across 33 Sub-Saharan African countries with subnational crop statistics  
**Data Columns**: 16 features including fnid, country, admin regions, crop products, seasonal data, production systems, area, production, and yield measurements

### Key Dataset Features:
| Column | Description |
|--------|-------------|
| `fnid` | FEWS NET's unique geographic unit identifier |
| `country` | Country name |
| `product` | Crop type (maize, wheat, rice, cassava, etc.) |
| `season_name` | Growing season name |
| `planting_year` | Year when planting begins |
| `planting_month` | Month when planting begins |
| `crop_production_system` | Production system (irrigated, rainfed, etc.) |
| `qc_flag` | Quality control flag (0=no flag, 1=outlier, 2=low variance) |
| `area` | Cropped area (hectares) |
| `production` | Crop quantity produced (metric tonnes) |
| `yield` | **Target Variable** - Crop yield (mt/ha) |

## 📱 API Testing & Usage

### Live Prediction API
**URL**: [https://crop-yield-prediction-a8ho.onrender.com/docs](https://crop-yield-prediction-a8ho.onrender.com/docs#/default/predict_predict_post)

**Method**: POST `/predict`

**Interactive Testing**: Use Swagger UI at the above URL for direct API testing

### Required Input Fields:
```json
{
  "planting_year": 2024,        // Year (2000-2024)
  "planting_month": 4,          // Month (1-12)
  "area": 5.0,                  // Farm area in hectares
  "product": "maize",           // Crop type (maize, wheat, rice, etc.)
  "crop_production_system": "rainfed",  // rainfed/irrigated
  "country": "kenya",           // African country name
  "season_name": "main_season", // Optional: season identifier
  "qc_flag": 1                  // Optional: quality flag (0-2)
}
```

### Expected Response:
```json
{
  "success": true,
  "predicted_yield": 2.456,     // Predicted yield in mt/ha
  "unit": "mt/ha",
  "confidence": "Medium",       // Low/Medium/High confidence
  "input_summary": {
    "crop": "maize",
    "area": 5.0,
    "country": "kenya",
    "planting_year": 2024,
    "planting_month": 4
  }
}
```

## 🎥 Demo Video
**YouTube Demo**: [5-Minute System Demonstration](https://youtube.com/your-demo-video)
- Model training process walkthrough
- API testing with real agricultural scenarios
- Mobile app functionality demonstration
- Real-world use cases for farmers and investors

## 📈 Key Features & Impact
- ✅ **Multi-crop prediction**: 15+ crop types (maize, wheat, rice, cassava, sorghum, etc.)
- ✅ **Seasonal optimization**: Best planting month recommendations per region
- ✅ **Production system analysis**: Rainfed vs irrigated yield comparisons  
- ✅ **Geographic coverage**: 33 Sub-Saharan African countries
- ✅ **Risk assessment**: Confidence scoring with prediction intervals
- ✅ **Real-time API**: Sub-second prediction response times

### Agricultural Impact:
This AI system enables data-driven agricultural decisions, potentially **increasing crop yields by 15-25%** through optimized planting strategies. It reduces investment risks for smallholder farmers and supports food security planning across Africa by providing actionable yield predictions before planting seasons.

## 🔧 Model Performance & Technical Details

### Algorithm Implementation:
- **Custom Gradient Descent Linear Regression** (built from scratch)
- **Ensemble Methods**: Random Forest, Decision Tree comparison
- **Feature Engineering**: 12 engineered features including:
  - Seasonal categorization (dry, early_rains, peak_rains, late_rains)
  - Farm size classification (small ≤2ha, medium 2-10ha, large >10ha)
  - Modern era indicator (post-2010 agricultural practices)
  - Log-transformed area values for better distribution
  - Categorical encoding for countries, crops, and production systems

### Model Training Results:
```
Custom Linear Regression:    Test R² = 0.1168 (11.68% accuracy)
Random Forest:              Test R² = 0.7+ (70%+ accuracy)
Decision Tree:              Test R² = 0.6+ (60%+ accuracy)
```

### Data Preprocessing:
- **Outlier Removal**: Eliminated extreme yield outliers (>99.5th percentile)
- **Data Leakage Prevention**: Removed production and harvest date features
- **Feature Standardization**: StandardScaler applied to all numerical features
- **Missing Value Handling**: Strategic imputation and unknown category encoding
- **Train/Test Split**: 80/20 split with stratification

## 🔍 Code Structure & Implementation

### Core Components:
1. **Data Pipeline** (`hvstat_africa_data_v1.0.csv` processing)
   - Comprehensive EDA with 6-panel visualization suite
   - Correlation analysis and feature relationship mapping
   - Missing value analysis and quality assessment

2. **Feature Engineering**
   - Temporal features: planting_season categorization
   - Area transformations: log scaling and size binning  
   - Technology indicators: modern_era (post-2010) farming
   - Category grouping: rare category consolidation (min_count=50)

3. **Custom Machine Learning Implementation**
   ```python
   class CustomLinearRegression:
       def __init__(self, learning_rate=0.01, max_iterations=2000)
       def fit(self, X_train, y_train, X_test, y_test)
       def predict(self, X)
   ```

4. **Model Comparison Framework**
   - Custom Gradient Descent vs Scikit-learn implementations
   - Performance metrics: R², RMSE, MAE, overfitting analysis
   - Visualization: loss curves, prediction scatter plots

5. **Production Deployment**
   - Model serialization with joblib (best_model.pkl, scaler.pkl, encoders.pkl)
   - FastAPI endpoint with error handling and validation
   - Confidence scoring and prediction interpretation

---
**🌍 Developed for Food Security & Sustainable Agriculture**  
*Empowering African farmers with AI-driven crop yield predictions*  


