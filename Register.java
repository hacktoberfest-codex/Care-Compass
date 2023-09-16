package com.example.loginpage;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.text.SpannableString;
import android.text.Spanned;
import android.text.style.UnderlineSpan;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;
import android.widget.Toast;

public class Register extends AppCompatActivity {

    EditText edUsername,edEmail, edPassword, edConfirmPassword;
    Button button;
    TextView tv;
    RadioGroup edradioGroup;
    RadioButton edChoose;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);

        edUsername = findViewById(R.id.editTextText);
        edPassword = findViewById(R.id.editTextText2);
        edEmail = findViewById(R.id.editTextText3);
        edConfirmPassword = findViewById(R.id.editTextText4);
        button = findViewById(R.id.button);
        tv = findViewById(R.id.textView3);
        edradioGroup = findViewById(R.id.radiogroup);

        //underline
        String text = "Already have an account? Login";
        SpannableString ss = new SpannableString(text);
        UnderlineSpan u = new UnderlineSpan();
        ss.setSpan(u,25,30, Spanned.SPAN_EXCLUSIVE_INCLUSIVE);
        tv.setText(ss);

        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                int radioId = edradioGroup.getCheckedRadioButtonId();  //gives id of radio button we checked
                edChoose = findViewById(radioId);
                String username = edUsername.getText().toString();
                String Email = edEmail.getText().toString();
                String password = edPassword.getText().toString();
                String ConfirmPassword = edConfirmPassword.getText().toString();
                if(username.length()==0||password.length()==0||Email.length()==0||ConfirmPassword.length()==0)
                    Toast.makeText(getApplicationContext(), "Please fill All details", Toast.LENGTH_SHORT).show();
                else
                {
                    Toast.makeText(getApplicationContext(), "Registration Successful", Toast.LENGTH_SHORT).show();
                }
            }
        });

        tv.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                startActivity(new Intent(Register.this, LoginActivity.class));
            }
        });
    }
    public void checkButton(View view)
    {
        int radioId = edradioGroup.getCheckedRadioButtonId();  //gives id of radio button we checked
        edChoose = findViewById(radioId);
        String t =edChoose.getText().toString();
        if(t.equals("Doctor"))
            Toast.makeText(this,"You choose Doctor",Toast.LENGTH_SHORT).show();
        else if(t.equals("Hospital"))
            Toast.makeText(this,"You choose Hospital",Toast.LENGTH_SHORT).show();
    }
}