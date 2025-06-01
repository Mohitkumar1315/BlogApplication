# Use official Tomcat image
FROM tomcat:9.0

# Remove default web apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file to Tomcat webapps folder
COPY tech-blog.war /usr/local/tomcat/webapps/ROOT.war
