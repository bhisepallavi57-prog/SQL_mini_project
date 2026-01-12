import streamlit as st
import numpy as np
#import pickle
import joblib


# Load the model
# with open('random_forest_classifier.pkl', 'rb') as f:
#     #model = pickle.load(f)
model = joblib.load("random_forest_classifier.joblib")

# Streamlit UI
st.title("Cancer Prediction Web App")
st.write("🔍 This app uses a Random Forest Classifier to predict type of cancer.")

# Collect user input
age = st.number_input("Age", min_value=0, max_value=120, value=30)
gender = st.selectbox("Gender", options={0: "Female", 1: "Male"})
tumor_size = st.number_input("Tumor Size (in cm)", min_value=0.0, value=2.5)
location = st.selectbox("Tumor Location", options={0: "Frontal", 1: "Occipital", 2: "Parietal", 3: "Temporal"})  # Update as per your values
histology = st.selectbox("Histology Type", options={0: "Astrocytoma", 1: "Glioblastoma", 2: "Medulloblastoma", 3: "Meningioma"})          # Update as per your values
stage = st.selectbox("Cancer Stage", options={0: "Stage 0", 1: "Stage 1", 2: "Stage 2", 3: "Stage 3", 4: "Stage 4"})

symptom_1 = st.selectbox("Symptom 1", options=[0, 1, 2, 3])
symptom_2 = st.selectbox("Symptom 2", options=[0, 1, 2, 3])
symptom_3 = st.selectbox("Symptom 3", options=[0, 1, 2, 3])
radiation = st.selectbox("Radiation Treatment Received", options=[0, 1])
surgery = st.selectbox("Surgery Performed", options=[0, 1])
chemo = st.selectbox("Chemotherapy Received", options=[0, 1])

survival_rate = st.number_input("Survival Rate (%)", min_value=0.0, max_value=100.0, value=75.0)
tumor_growth_rate = st.number_input("Tumor Growth Rate", min_value=0.0, value=1.2)

family_history = st.selectbox("Family History of Cancer", options=[0, 1])
mri_result = st.selectbox("MRI Result Abnormality", options=[0, 1])
follow_up = st.selectbox("Follow-Up Required?", options=[0, 1])

# Button to predict
if st.button("Predict the Type Of Cancer"):
    input_data = np.array([[
        age,
        0 if gender == "Female" else 1,
        tumor_size,
        location,
        histology,
        stage,
        symptom_1,
        symptom_2,
        symptom_3,
        radiation,
        surgery,
        chemo,
        survival_rate,
        tumor_growth_rate,
        family_history,
        mri_result, 
        follow_up
    ]])

    # Prediction
    prediction = model.predict(input_data)[0]

    if prediction == 1:
        st.error("🔴 Malignant Cancer !!!")
    else:
        st.success("🟢 Benign Cancer !!!")

