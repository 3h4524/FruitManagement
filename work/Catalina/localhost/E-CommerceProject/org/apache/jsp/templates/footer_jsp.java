/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/10.1.34
 * Generated at: 2025-03-23 01:17:58 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.templates;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.jsp.*;

public final class footer_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports,
                 org.apache.jasper.runtime.JspSourceDirectives {

  private static final jakarta.servlet.jsp.JspFactory _jspxFactory =
          jakarta.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.LinkedHashSet<>(4);
    _jspx_imports_packages.add("jakarta.servlet");
    _jspx_imports_packages.add("jakarta.servlet.http");
    _jspx_imports_packages.add("jakarta.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private volatile jakarta.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public boolean getErrorOnELNotFound() {
    return false;
  }

  public jakarta.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final jakarta.servlet.http.HttpServletRequest request, final jakarta.servlet.http.HttpServletResponse response)
      throws java.io.IOException, jakarta.servlet.ServletException {

    if (!jakarta.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
      final java.lang.String _jspx_method = request.getMethod();
      if ("OPTIONS".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        return;
      }
      if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method)) {
        response.setHeader("Allow","GET, HEAD, POST, OPTIONS");
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET, POST or HEAD. Jasper also permits OPTIONS");
        return;
      }
    }

    final jakarta.servlet.jsp.PageContext pageContext;
    jakarta.servlet.http.HttpSession session = null;
    final jakarta.servlet.ServletContext application;
    final jakarta.servlet.ServletConfig config;
    jakarta.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    jakarta.servlet.jsp.JspWriter _jspx_out = null;
    jakarta.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n");
      out.write("  <title>JSP Page</title>\r\n");
      out.write("  <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css\">\r\n");
      out.write("  <style>\r\n");
      out.write("    /* Footer styling */\r\n");
      out.write("    .footer {\r\n");
      out.write("      background-color: #f8f9fa;\r\n");
      out.write("      color: #333;\r\n");
      out.write("      font-family: 'Segoe UI', Roboto, 'Helvetica Neue', sans-serif;\r\n");
      out.write("      padding: 40px 0 20px;\r\n");
      out.write("      margin-top: 50px;\r\n");
      out.write("      border-top: 1px solid rgba(46, 139, 87, 0.1);\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .footer-container {\r\n");
      out.write("      max-width: 1200px;\r\n");
      out.write("      margin: 0 auto;\r\n");
      out.write("      display: grid;\r\n");
      out.write("      grid-template-columns: repeat(4, 1fr);\r\n");
      out.write("      gap: 30px;\r\n");
      out.write("      padding: 0 20px;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .footer h2 {\r\n");
      out.write("      color: #2e8b57;\r\n");
      out.write("      font-weight: 600;\r\n");
      out.write("      font-size: 1.3rem;\r\n");
      out.write("      margin-bottom: 20px;\r\n");
      out.write("      position: relative;\r\n");
      out.write("      padding-bottom: 10px;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .footer h2:after {\r\n");
      out.write("      content: '';\r\n");
      out.write("      position: absolute;\r\n");
      out.write("      left: 0;\r\n");
      out.write("      bottom: 0;\r\n");
      out.write("      width: 50px;\r\n");
      out.write("      height: 2px;\r\n");
      out.write("      background-color: #3c9d74;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .footer p {\r\n");
      out.write("      color: #555;\r\n");
      out.write("      line-height: 1.6;\r\n");
      out.write("      margin-bottom: 10px;\r\n");
      out.write("      font-size: 0.95rem;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .Logo-footer img {\r\n");
      out.write("      max-width: 150px;\r\n");
      out.write("      height: auto;\r\n");
      out.write("      margin-bottom: 15px;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .gioithieu p {\r\n");
      out.write("      margin-bottom: 15px;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .Bct img {\r\n");
      out.write("      max-width: 120px;\r\n");
      out.write("      height: auto;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .social-links a {\r\n");
      out.write("      margin-right: 15px;\r\n");
      out.write("      transition: transform 0.3s ease;\r\n");
      out.write("      display: inline-block;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .social-links a:hover {\r\n");
      out.write("      transform: translateY(-5px);\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .footer-bottom {\r\n");
      out.write("      text-align: center;\r\n");
      out.write("      margin-top: 30px;\r\n");
      out.write("      padding-top: 20px;\r\n");
      out.write("      border-top: 1px solid rgba(46, 139, 87, 0.1);\r\n");
      out.write("      font-size: 0.9rem;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .footer-bottom span {\r\n");
      out.write("      color: #3c9d74;\r\n");
      out.write("      font-weight: 600;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    /* Responsive adjustments */\r\n");
      out.write("    @media (max-width: 768px) {\r\n");
      out.write("      .footer-container {\r\n");
      out.write("        grid-template-columns: repeat(2, 1fr);\r\n");
      out.write("      }\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    @media (max-width: 480px) {\r\n");
      out.write("      .footer-container {\r\n");
      out.write("        grid-template-columns: 1fr;\r\n");
      out.write("      }\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    /* Animation for links */\r\n");
      out.write("    .footer a {\r\n");
      out.write("      transition: all 0.2s ease;\r\n");
      out.write("      text-decoration: none;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .footer a:hover {\r\n");
      out.write("      color: #3c9d74;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    /* Customer care styling */\r\n");
      out.write("    .customer-care p {\r\n");
      out.write("      display: flex;\r\n");
      out.write("      align-items: center;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .customer-care i {\r\n");
      out.write("      margin-right: 10px;\r\n");
      out.write("      color: #3c9d74;\r\n");
      out.write("    }\r\n");
      out.write("  </style>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("<div class=\"footer\">\r\n");
      out.write("  <div class=\"footer-container\">\r\n");
      out.write("    <div class=\"Logo-footer\">\r\n");
      out.write("      <a href=\"#\"><img src=\"images/Logo.png\" alt=\"Fruitiverse Logo\"></a>\r\n");
      out.write("      <p>Trái cây tươi ngon mỗi ngày</p>\r\n");
      out.write("    </div>\r\n");
      out.write("\r\n");
      out.write("    <div class=\"gioithieu\">\r\n");
      out.write("      <h2>Giới Thiệu</h2>\r\n");
      out.write("      <p>Fruitiverse là shop Trái cây tươi ngon mỗi ngày! Chúng tôi cung cấp đa dạng các loại trái cây chất lượng cao, đảm bảo an toàn và giàu dinh dưỡng.</p>\r\n");
      out.write("      <div class=\"Bct\">\r\n");
      out.write("        <a href=\"#\"><img src=\"images/chungnhan.png\" alt=\"Chứng nhận Bộ Công Thương\"></a>\r\n");
      out.write("      </div>\r\n");
      out.write("    </div>\r\n");
      out.write("\r\n");
      out.write("    <div class=\"customer-care\">\r\n");
      out.write("      <h2>Chăm sóc khách hàng</h2>\r\n");
      out.write("      <p><i class=\"fas fa-home\"></i> Đại Học FPT Đà Nẵng</p>\r\n");
      out.write("      <p><i class=\"fas fa-phone\"></i> 0938 706 66 46</p>\r\n");
      out.write("      <p><i class=\"fas fa-envelope\"></i> fruitiverse@gmail.com</p>\r\n");
      out.write("    </div>\r\n");
      out.write("\r\n");
      out.write("    <div>\r\n");
      out.write("      <h2>Follow US</h2>\r\n");
      out.write("      <div class=\"social-links\">\r\n");
      out.write("        <a href=\"#\"><i class=\"fab fa-facebook fa-2x\" style=\"color: #1877F2;\"></i></a>\r\n");
      out.write("        <a href=\"#\"><i class=\"fab fa-instagram fa-2x\" style=\"color: #E1306C;\"></i></a>\r\n");
      out.write("        <a href=\"#\"><i class=\"fab fa-tiktok fa-2x\" style=\"color: #000;\"></i></a>\r\n");
      out.write("      </div>\r\n");
      out.write("    </div>\r\n");
      out.write("  </div>\r\n");
      out.write("\r\n");
      out.write("  <div class=\"footer-bottom\">\r\n");
      out.write("    <h5>&copy; Copyright 2025 <span>Fruitiverse.com</span></h5>\r\n");
      out.write("  </div>\r\n");
      out.write("</div>\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof jakarta.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
