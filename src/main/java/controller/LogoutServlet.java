package controller; import jakarta.servlet.*; 
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException; 
@WebServlet(name = "LogoutServlet", value = "/logout")
public class LogoutServlet extends HttpServlet { 

@Override protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession();
    session.invalidate(); // Hủy toàn bộ session
    response.sendRedirect("index.jsp");
}
@Override protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

}
}