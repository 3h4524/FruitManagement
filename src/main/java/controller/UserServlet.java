package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Customer;
import service.CustomerService;
import service.Utils;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "userServlet", value = "/users")
public class UserServlet extends HttpServlet {
    private CustomerService customerService = new CustomerService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action == null){
            action = "";
        }
        switch(action){
            case "create":
                response.sendRedirect("/user/UserCreate.jsp");
                break;
            case "search":
                searchCustomer(request, response);
                break;
            case "update":
                updateCustomer(request, response);
                break;
            case "delete":
                deleteCustomer(request, response);
                break;
                default:
                customerList(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action == null){
            action = "";
        }
        switch(action){
            case "create":
                createUser(request, response);
                break;
            case "update":
                break;
        }
    }
    public void customerList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Customer> customers = customerService.getAllCustomer();
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("UserList.jsp").forward(request, response);
    }
    public void createUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");

        if (customer == null) {
            request.setAttribute("error", "Dữ liệu không hợp lệ!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        String name = customer.getName() != null ? customer.getName().trim() : "";
        String email = customer.getEmail() != null ? customer.getEmail().trim() : "";
        String password = customer.getPasswordHash() != null ? customer.getPasswordHash().trim() : "";

        // Kiểm tra thông tin có đầy đủ không
        if (name.isEmpty() || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra tên đăng nhập đã tồn tại chưa
        if (customerService.checkExistUserName(name) != null) {
            request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Mã hóa mật khẩu và cập nhật lại cho Customer
        customer.setPasswordHash(Utils.hashPassword(password));

        // Lưu vào database
        if (customerService.addCustomer(customer)) {
            request.setAttribute("success", "Đăng ký thành công!");
        } else {
            request.setAttribute("error", "Đăng ký không thành công. Vui lòng thử lại!");
        }

        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    public void deleteCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        boolean success = customerService.deleteCustomer(id);
        if (success) {
            request.setAttribute("success", "Xóa người dùng thành công!");
        } else {
            request.setAttribute("error", "Xóa người dùng thất bại!");
        }
        request.getRequestDispatcher("UserList.jsp").forward(request, response);
    }
    public void searchCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Customer customer = customerService.getCustomerById(id);
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("UserList.jsp").forward(request, response);
    }
    public void updateCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Customer customer = customerService.getCustomerById(id);
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("UserUpdate.jsp").forward(request, response);
    }
    public void saveUpdateCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        if (customer.getName() == null || customer.getPasswordHash() == null || customer.getEmail() == null || customer.getName().isEmpty() || customer.getPasswordHash().isEmpty() || customer.getEmail().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin!");
            request.getRequestDispatcher("UserUpdate.jsp").forward(request, response);
            return;
        }
        boolean success = customerService.updateCustomer(customer);
        if(success){
            request.setAttribute("success", "Cập nhật thông thành công");
        }else{
            request.setAttribute("error", "Cập nhật thất bại");
        }
        request.getRequestDispatcher("UserUpdate.jsp").forward(request, response);
    }
    public void changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String oldPassword = request.getParameter("oldPassword");
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        boolean isMatch = Utils.checkPassword(oldPassword, customer.getPasswordHash());
        if (isMatch) {
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            if(newPassword.equals(confirmPassword)){
                newPassword = Utils.hashPassword(newPassword);
                customer.setPasswordHash(newPassword);
                request.setAttribute("success", "Cập nhật mật khẩu mới thành công");
            }else{
                request.setAttribute("error", "Mật khẩu nhập lại không khớp với mật khẩu đã nhập");
            }
        }else{
            request.setAttribute("error", "Mật khẩu cũ không đúng");
        }
        request.getRequestDispatcher("UserChangePassword.jsp").forward(request, response);
    }

}
