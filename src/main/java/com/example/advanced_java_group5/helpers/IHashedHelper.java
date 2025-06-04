package com.example.advanced_java_group5.helpers;

public interface IHashedHelper {
    boolean isPasswordValid(String password, String hashedPassword);
    String hashPassword(String password);
}
