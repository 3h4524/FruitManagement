package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;

@WebServlet(name = "productServlet", value = "/products")
public class ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    private void processError(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Throwable throwable = (Throwable) request.getAttribute("javax.servlet.error.exception");
    }
}
