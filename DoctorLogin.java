package com.example.loginpage;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.Spanned;
import android.text.method.LinkMovementMethod;
import android.text.style.ClickableSpan;
import android.text.style.UnderlineSpan;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

public class DoctorLogin extends AppCompatActivity {

    EditText edUsername, edPassword;
    Button button;
    TextView tv;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        edUsername = findViewById(R.id.editTextText);
        edPassword = findViewById(R.id.editTextText2);
        button = findViewById(R.id.button);
        tv = findViewById(R.id.textView3);
        String text = "Don't have an account? Register";
        SpannableString ss = new SpannableString(text);
        UnderlineSpan u = new UnderlineSpan();
        ss.setSpan(u,23,31,Spanned.SPAN_EXCLUSIVE_INCLUSIVE);
        tv.setText(ss);

        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String usernamme = edUsername.getText().toString();
                String password = edPassword.getText().toString();
                DoctorDatabase db = new DoctorDatabase(getApplicationContext(),"Care Compass",null,1);
                if(usernamme.length()==0||password.length()==0)
                {
                    Toast.makeText(getApplicationContext(), "Please fill All details", Toast.LENGTH_SHORT).show();
                }
                else
                {
                    if(db.login(usernamme,password)==1)
                    {
                        Toast.makeText(getApplicationContext(), "Login Successful", Toast.LENGTH_SHORT).show();
                        SharedPreferences sharedPreferences = getSharedPreferences("shared prefs", Context.MODE_PRIVATE);
                        SharedPreferences.Editor editor = sharedPreferences.edit();
                        editor.putString("username",usernamme);
                        //to save data with key and value
                        editor.apply();
                        startActivity(new Intent(DoctorLogin.this, DoctorHome.class));
                    }
                    else {
                        Toast.makeText(getApplicationContext(), "Invalid username and password", Toast.LENGTH_SHORT).show();
                    }
                }
            }
        });

        tv.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivity(new Intent(DoctorLogin.this, DoctorHome.class));
            }
        });
    }
}

//        String text = tv.getText().toString();
//        SpannableString ss = new SpannableString(text);
//
//        ClickableSpan cc = new ClickableSpan() {
//            @Override
//            public void onClick(@NonNull View view) {
//                startActivity(new Intent(LoginActivity.this, Register.class));
//            }
//        };
//        ss.setSpan(cc,23,33, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
//        tv.setText(ss);
//        tv.setMovementMethod(LinkMovementMethod.getInstance());