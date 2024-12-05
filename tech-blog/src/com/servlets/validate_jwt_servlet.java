package com.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.tech.helper.JwtHelper;

@WebServlet("/validate_jwt")
public class validate_jwt_servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();

        // Extract token from Authorization header
        String authHeader = req.getHeader("Authorization");
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            String token = authHeader.substring(7); // Remove "Bearer " prefix

            try {
                DecodedJWT decodedJWT = JwtHelper.validateToken(token);
                out.write("{\"status\":\"success\",\"message\":\"Token is valid.\", \"user\":\"" + decodedJWT.getSubject() + "\"}");
            } catch (JWTVerificationException e) {
                resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                out.write("{\"status\":\"error\",\"message\":\"Invalid or expired token.\"}");
            }
        } else {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.write("{\"status\":\"error\",\"message\":\"Authorization header missing or malformed.\"}");
        }
    }
}
