package com.servlets;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.tech.helper.JwtHelper;
///IT is testing class for checking JWt i workin or not : it not the part of the Project 
//@WebFilter("/*")
public class JwtFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Extract the JWT from the Authorization header
        String token = httpRequest.getHeader("Authorization");
        System.out.println("Token in JWTFilter:"+token);
        if (token != null && token.startsWith("Bearer ")) {
            try {
                // Remove "Bearer " from the token
                token = token.substring(7);

                // Validate the token
                DecodedJWT decodedJWT = JwtHelper.validateToken(token);
                
                // Optionally, add claims to the request for later use (e.g., user info)
                httpRequest.setAttribute("user", decodedJWT.getSubject());
                chain.doFilter(request, response);
            } catch (JWTVerificationException e) {
                httpResponse.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid or expired token.");
            }
        } else {
            httpResponse.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Authorization header missing or malformed.");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void destroy() {
    }
}
