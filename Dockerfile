# Sử dụng Tomcat 11 với JDK 21 (Ổn định, không cần tải Tomcat thủ công)
FROM tomcat:11-jdk21

# Đặt thư mục làm việc
WORKDIR /usr/local/tomcat

# Xóa ứng dụng mặc định của Tomcat
RUN rm -rf webapps/ROOT webapps/ROOT.war

# Sao chép ứng dụng WAR vào thư mục webapps
COPY target/*.war webapps/ROOT.war

# Mở cổng 8080
EXPOSE 8080

# Chạy Tomcat
CMD ["catalina.sh", "run"]
