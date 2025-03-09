package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Customer;
import service.CustomerService;
import service.Utils;

import java.io.IOException;

@WebServlet(name = "LoginServlet", value = "/login")
public class LoginServlet extends HttpServlet {
    private CustomerService customerService = new CustomerService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String pasword = request.getParameter("password");
        Customer customer = customerService.checkExistUserName(username);
        if(customer != null && Utils.checkPassword(pasword, customer.getPasswordHash())) {
            if(customer.getStatus().equals("INACTIVE")){
                request.setAttribute("message", "Tài khoản này đã bị vô hiệu hóa.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            HttpSession session = request.getSession();
            session.setAttribute("customer", customer);
            response.sendRedirect("index.jsp");
        }else{
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
