package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.logging.Logger;

@WebServlet(name = "ErrorHandlerServlet", value = "/errorhandler")
public class ErrorHandlerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processError(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processError(request, response);
    }

    private void processError(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Throwable throwable = (Throwable) request.getAttribute("jakarta.servlet.error.exception");
        Integer statusCode = (Integer) request.getAttribute("jakarta.servlet.error.status_code");
        String requestUri = (String) request.getAttribute("jakarta.servlet.error.request_uri");

        request.setAttribute("errorMessage", (throwable != null) ? throwable.getMessage() : "Unknown error");
        request.setAttribute("errorType", (throwable != null) ? throwable.getClass().getName() : "N/A");
        request.setAttribute("statusCode", (statusCode != null) ? statusCode : 500);
        request.setAttribute("requestUri", (requestUri != null) ? requestUri : "N/A");
        request.getRequestDispatcher("error/ErrorPage.jsp").forward(request,response);
    }
}
