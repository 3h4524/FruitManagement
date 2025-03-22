# Sử dụng image Tomcat chính thức
FROM tomcat:10.1

# Copy file WAR vào thư mục webapps của Tomcat
COPY target/E-CommerceProject-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080 (Render sẽ tự map cổng này)
EXPOSE 8080

# Chạy Tomcat
CMD ["catalina.sh", "run", "-Dserver.port=8080"]
