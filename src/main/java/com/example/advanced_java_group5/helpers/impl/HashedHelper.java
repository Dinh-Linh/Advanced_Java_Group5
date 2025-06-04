package com.example.advanced_java_group5.helpers.impl;

import com.example.advanced_java_group5.helpers.IHashedHelper;
import org.springframework.security.crypto.bcrypt.BCrypt;

public class HashedHelper implements IHashedHelper {
    @Override
    public boolean isPasswordValid(String password, String hashedPassword) {
        return BCrypt.checkpw(password, hashedPassword);
    }

    @Override
    public String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }
}
