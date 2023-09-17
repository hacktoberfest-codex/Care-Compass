package com.example.loginpage;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class StartPage extends AppCompatActivity {
Button doctor,patient;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_start_page);
        doctor = findViewById(R.id.button);
        patient = findViewById(R.id.button2);
        doctor.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivity(new Intent(StartPage.this, DoctorLogin.class));
            }
        });
        patient.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivity(new Intent(StartPage.this, LoginActivity.class));
            }
        });
    }
}