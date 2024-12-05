package com.tech.helper;

import java.util.Date;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.auth0.jwt.interfaces.JWTVerifier;

public class JwtHelper {

    private static final String SECRET_KEY = System.getenv("JWT_SECRET_KEY") != null 
            ? System.getenv("JWT_SECRET_KEY") 
            : "defaultSecretForTestingOnly";

    // Generate JWT Token with Role
    public static String generateToken(String username, String role) {
        Algorithm algorithm = Algorithm.HMAC256(SECRET_KEY);
        return JWT.create()
                .withSubject(username)
                .withClaim("role", role)
                .withIssuedAt(new Date())
                .withExpiresAt(new Date(System.currentTimeMillis() + 3600000)) // 1-hour expiry
                .sign(algorithm);
    }

    // Validate and Decode JWT
    public static DecodedJWT validateToken(String token) throws JWTVerificationException {
        Algorithm algorithm = Algorithm.HMAC256(SECRET_KEY);
        JWTVerifier verifier = JWT.require(algorithm).build();
        return verifier.verify(token);
    }
}
