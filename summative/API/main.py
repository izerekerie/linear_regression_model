# main.py - Simple FastAPI Backend for Crop Yield Prediction
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import joblib
import pandas as pd
import numpy as np
import os

# Initialize FastAPI app
app = FastAPI(title="Crop Yield Prediction API")

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Request model
class PredictionRequest(BaseModel):
    planting_year: int
    planting_month: int
    area: float
    product: str
    crop_production_system: str
    country: str
    season_name: str = "unknown"
    qc_flag: int = 1

# Global variables for model components
model = None
scaler = None
encoders = None
feature_columns = None

def load_model():
    """Load model components"""
    global model, scaler, encoders, feature_columns
    
    try:
        # Path to saved_models folder (one level up from API folder, then into linear_regression)
        model_dir = '../linear_regression/saved_models'
        model = joblib.load(f'{model_dir}/best_crop_yield_model.pkl')
        scaler = joblib.load(f'{model_dir}/scaler.pkl')
        encoders = joblib.load(f'{model_dir}/label_encoders.pkl')
        feature_columns = joblib.load(f'{model_dir}/feature_columns.pkl')
        print("✅ Model loaded successfully")
        print(f"📁 Loaded from: {model_dir}")
    except Exception as e:
        print(f"❌ Error loading model: {e}")
        print(f"📁 Tried to load from: {model_dir}")
        raise

@app.on_event("startup")
async def startup():
    """Load model on startup"""
    load_model()

@app.get("/")
async def root():
    """Root endpoint"""
    return {"message": "Crop Yield Prediction API", "status": "running"}

@app.get("/health")
async def health():
    """Health check"""
    return {"status": "healthy", "model_loaded": model is not None}

@app.post("/predict")
async def predict(request: PredictionRequest):
    """Predict crop yield"""
    
    if model is None:
        raise HTTPException(status_code=500, detail="Model not loaded")
    
    try:
        # Create input dataframe
        input_data = pd.DataFrame({
            'planting_year': [request.planting_year],
            'planting_month': [request.planting_month],
            'area': [request.area],
            'area_log': [np.log1p(request.area)],
            'qc_flag': [request.qc_flag],
            'modern_era': [1 if request.planting_year >= 2010 else 0],
            'product': [request.product.lower()],
            'crop_production_system': [request.crop_production_system.lower()],
            'country': [request.country.lower()],
            'season_name': [request.season_name.lower()]
        })
        
        # Add planting season
        season_map = {
            12: 'dry', 1: 'dry', 2: 'dry',
            3: 'early_rains', 4: 'early_rains', 5: 'early_rains',
            6: 'peak_rains', 7: 'peak_rains', 8: 'peak_rains',
            9: 'late_rains', 10: 'late_rains', 11: 'late_rains'
        }
        input_data['planting_season'] = season_map.get(request.planting_month, 'unknown')
        
        # Add farm size
        if request.area <= 2.0:
            farm_size = 'small'
        elif request.area <= 10.0:
            farm_size = 'medium'
        else:
            farm_size = 'large'
        input_data['farm_size'] = farm_size
        
        # Encode categorical variables
        categorical_cols = ['product', 'crop_production_system', 'country', 'season_name', 'planting_season', 'farm_size']
        
        for col in categorical_cols:
            if col in encoders:
                try:
                    value = input_data[col].iloc[0]
                    if value in encoders[col].classes_:
                        input_data[f'{col}_encoded'] = encoders[col].transform([value])
                    else:
                        input_data[f'{col}_encoded'] = [0]  # Default value
                except:
                    input_data[f'{col}_encoded'] = [0]
        
        # Select features
        X_input = input_data[feature_columns].fillna(0)
        
        # Scale features
        X_scaled = scaler.transform(X_input)
        
        # Make prediction
        prediction = model.predict(X_scaled)[0]
        
        return {
            'success': True,
            'predicted_yield': round(float(prediction), 3),
            'unit': 'mt/ha',
            'confidence': 'Medium',
            'input_summary': {
                'crop': request.product,
                'area': request.area,
                'country': request.country,
                'planting_year': request.planting_year,
                'planting_month': request.planting_month
            }
        }
        
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Prediction error: {str(e)}")

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)