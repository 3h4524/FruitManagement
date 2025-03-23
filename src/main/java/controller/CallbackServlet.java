package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.User;
import service.UserService;
import service.Utils;
import org.json.JSONObject;

import java.io.IOException;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;

@WebServlet(name = "CallbackServlet", value = "/callback")
public class CallbackServlet extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(); // Lấy session

        // Lấy code từ request
        String code = request.getParameter("code");
        if (code == null || code.isEmpty()) {
            System.out.println("Authorization code is missing!");
            session.setAttribute("error", "Authorization code is missing!");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        System.out.println("Authorization Code: " + code);

        // Lấy thông tin OAuth từ properties
        String clientId = Utils.getProperty("google.clientId");
        String clientSecret = Utils.getProperty("google.clientSecret");
        String redirectUri = Utils.getProperty("google.redirectUri");

        System.out.println("Client ID: " + clientId);
        System.out.println("Client Secret: " + clientSecret);
        System.out.println("Redirect URI: " + redirectUri);

        // Kiểm tra xem có thiếu thông tin nào không
        if (clientId == null || clientSecret == null || redirectUri == null) {
            session.setAttribute("error", "OAuth configuration is missing!");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Gửi yêu cầu lấy access token
        String tokenEndpoint = "https://oauth2.googleapis.com/token";
        String params = "code=" + code +
                "&client_id=" + clientId +
                "&client_secret=" + clientSecret +
                "&redirect_uri=" + redirectUri +
                "&grant_type=authorization_code";

        String tokenResponse = getTokenResponse(tokenEndpoint, params);
        if (tokenResponse == null || tokenResponse.isEmpty()) {
            System.out.println("Failed to retrieve access token!");
            session.setAttribute("error", "Failed to retrieve access token!");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        System.out.println("Token Response: " + tokenResponse);

        // Lấy access token từ JSON response
        String accessToken = extractAccessToken(tokenResponse);
        if (accessToken == null || accessToken.isEmpty()) {
            System.out.println("Invalid access token response!");
            session.setAttribute("error", "Invalid access token response!");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        System.out.println("Access Token: " + accessToken);

        // Lấy thông tin user từ Google API
        String userInfoJson = getUserInfo(accessToken);
        if (userInfoJson == null || userInfoJson.isEmpty()) {
            System.out.println("Failed to retrieve user information!");
            session.setAttribute("error", "Failed to retrieve user information!");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        System.out.println("User Info JSON: " + userInfoJson);

        // Xử lý thông tin user
        User user = userService.processGoogleUserInfo(userInfoJson);
        if (user == null) {
            System.out.println("User processing failed!");
            session.setAttribute("error", "Failed to process user account!");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        System.out.println("User Created: " + user.getEmail());

        // Lấy URL ảnh đại diện từ Google
        String pictureUrl = "";
        try {
            JSONObject userInfo = new JSONObject(userInfoJson);
            pictureUrl = userInfo.optString("picture", "");
        } catch (Exception e) {
            System.out.println("Failed to parse picture URL");
        }

        // Thiết lập session và cookie cho người dùng
        userService.setupGoogleUserSession(request, response, user, pictureUrl);

        // Chuyển hướng đến trang chính sau khi đăng nhập thành công
        session.setAttribute("success", "Successfully logged in with Google!");
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }

    private String getTokenResponse(String tokenEndpoint, String params) {
        try {
            URL url = new URL(tokenEndpoint);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
            conn.setDoOutput(true);

            try (OutputStream os = conn.getOutputStream()) {
                os.write(params.getBytes());
                os.flush();
            }

            int responseCode = conn.getResponseCode();
            System.out.println("Token API Response Code: " + responseCode);

            if (responseCode != 200) {
                return null;
            }

            try (Scanner scanner = new Scanner(conn.getInputStream())) {
                return scanner.useDelimiter("\\A").hasNext() ? scanner.next() : null;
            }
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    private String extractAccessToken(String jsonResponse) {
        try {
            JSONObject json = new JSONObject(jsonResponse);
            return json.optString("access_token", null);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    private String getUserInfo(String accessToken) {
        try {
            URL url = new URL("https://www.googleapis.com/oauth2/v3/userinfo");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Authorization", "Bearer " + accessToken);

            int responseCode = conn.getResponseCode();
            System.out.println("User Info API Response Code: " + responseCode);

            if (responseCode != 200) {
                return null;
            }

            try (Scanner scanner = new Scanner(conn.getInputStream())) {
                return scanner.useDelimiter("\\A").hasNext() ? scanner.next() : null;
            }
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}
