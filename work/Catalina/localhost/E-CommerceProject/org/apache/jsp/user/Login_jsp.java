/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/10.1.34
 * Generated at: 2025-03-23 01:17:58 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.user;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.jsp.*;

public final class Login_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports,
                 org.apache.jasper.runtime.JspSourceDirectives {

  private static final jakarta.servlet.jsp.JspFactory _jspxFactory =
          jakarta.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  static {
    _jspx_dependants = new java.util.HashMap<java.lang.String,java.lang.Long>(2);
    _jspx_dependants.put("/WEB-INF/lib/jakarta.servlet.jsp.jstl-2.0.0.jar", Long.valueOf(1740052119710L));
    _jspx_dependants.put("jar:file:/C:/Users/LEGION/.m2/repository/org/glassfish/web/jakarta.servlet.jsp.jstl/2.0.0/jakarta.servlet.jsp.jstl-2.0.0.jar!/META-INF/c.tld", Long.valueOf(1602848772000L));
  }

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.LinkedHashSet<>(4);
    _jspx_imports_packages.add("jakarta.servlet");
    _jspx_imports_packages.add("jakarta.servlet.http");
    _jspx_imports_packages.add("jakarta.servlet.jsp");
    _jspx_imports_classes = null;
  }

  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fif_0026_005ftest;
  private org.apache.jasper.runtime.TagHandlerPool _005fjspx_005ftagPool_005fc_005fremove_0026_005fvar_005fscope_005fnobody;

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
    _005fjspx_005ftagPool_005fc_005fif_0026_005ftest = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _005fjspx_005ftagPool_005fc_005fremove_0026_005fvar_005fscope_005fnobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.release();
    _005fjspx_005ftagPool_005fc_005fremove_0026_005fvar_005fscope_005fnobody.release();
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
      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("<head>\r\n");
      out.write("  <link href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (jakarta.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/css/bootstrap/bootstrap.min.css\" rel=\"stylesheet\">\r\n");
      out.write("  <link rel=\"stylesheet\" href=\"https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css\">\r\n");
      out.write("  <title>Đăng nhập</title>\r\n");
      out.write("  <style>\r\n");
      out.write("    :root {\r\n");
      out.write("      --primary-color: #2e8b57;\r\n");
      out.write("      --primary-light: #3c9d74;\r\n");
      out.write("      --primary-dark: #247048;\r\n");
      out.write("      --accent-color: #FFA500;\r\n");
      out.write("      --text-color: #333;\r\n");
      out.write("      --light-gray: #f5f5f5;\r\n");
      out.write("      --white: #fff;\r\n");
      out.write("      --border-color: #e0e0e0;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    body {\r\n");
      out.write("      background-color: var(--light-gray);\r\n");
      out.write("      min-height: 100vh;\r\n");
      out.write("      color: var(--text-color);\r\n");
      out.write("      font-family: Arial, sans-serif;\r\n");
      out.write("      display: flex;\r\n");
      out.write("      flex-direction: column;\r\n");
      out.write("      align-items: center;\r\n");
      out.write("      margin: 0;\r\n");
      out.write("      justify-content: center;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .container {\r\n");
      out.write("      width: 100%;\r\n");
      out.write("      margin-top: 2rem;\r\n");
      out.write("      margin-bottom: 2rem;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .card {\r\n");
      out.write("      border: none;\r\n");
      out.write("      border-radius: 10px;\r\n");
      out.write("      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);\r\n");
      out.write("      overflow: hidden;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .card-header {\r\n");
      out.write("      padding: 1.5rem;\r\n");
      out.write("      background-color: var(--primary-color) !important;\r\n");
      out.write("      border-bottom: none;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .card-body {\r\n");
      out.write("      padding: 2rem;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .form-label {\r\n");
      out.write("      font-weight: 500;\r\n");
      out.write("      color: var(--text-color);\r\n");
      out.write("      margin-bottom: 0.5rem;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .form-control {\r\n");
      out.write("      padding: 0.75rem;\r\n");
      out.write("      border: 1px solid var(--border-color);\r\n");
      out.write("      border-radius: 5px;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .form-control:focus {\r\n");
      out.write("      border-color: var(--primary-light);\r\n");
      out.write("      box-shadow: 0 0 0 0.25rem rgba(46, 139, 87, 0.25);\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .input-group-text {\r\n");
      out.write("      background-color: var(--light-gray);\r\n");
      out.write("      border-color: var(--border-color);\r\n");
      out.write("      cursor: pointer;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .btn-primary {\r\n");
      out.write("      background-color: var(--primary-color);\r\n");
      out.write("      border-color: var(--primary-color);\r\n");
      out.write("      color: var(--white);\r\n");
      out.write("      padding: 0.75rem 2rem;\r\n");
      out.write("      font-weight: 500;\r\n");
      out.write("      width: 100%;\r\n");
      out.write("      margin-bottom: 1rem;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .btn-primary:hover {\r\n");
      out.write("      background-color: var(--primary-dark);\r\n");
      out.write("      border-color: var(--primary-dark);\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .btn-secondary {\r\n");
      out.write("      background-color: var(--light-gray);\r\n");
      out.write("      border-color: var(--border-color);\r\n");
      out.write("      color: var(--text-color);\r\n");
      out.write("      padding: 0.75rem 2rem;\r\n");
      out.write("      font-weight: 500;\r\n");
      out.write("      width: 100%;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .btn-secondary:hover {\r\n");
      out.write("      background-color: #e6e6e6;\r\n");
      out.write("      border-color: #d5d5d5;\r\n");
      out.write("      color: var(--text-color);\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .forgot-password-link {\r\n");
      out.write("      color: var(--primary-color);\r\n");
      out.write("      text-decoration: none;\r\n");
      out.write("      transition: color 0.3s ease;\r\n");
      out.write("      text-align: right;\r\n");
      out.write("      display: block;\r\n");
      out.write("      margin-bottom: 1.5rem;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .forgot-password-link:hover {\r\n");
      out.write("      color: var(--primary-dark);\r\n");
      out.write("      text-decoration: underline;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .remember-me {\r\n");
      out.write("      display: flex;\r\n");
      out.write("      align-items: center;\r\n");
      out.write("      margin-bottom: 1.5rem;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .remember-me input {\r\n");
      out.write("      margin-right: 0.5rem;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .alert {\r\n");
      out.write("      border-radius: 5px;\r\n");
      out.write("      padding: 1rem;\r\n");
      out.write("      margin-bottom: 1.5rem;\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .alert-success {\r\n");
      out.write("      background-color: rgba(46, 139, 87, 0.1);\r\n");
      out.write("      border-color: rgba(46, 139, 87, 0.2);\r\n");
      out.write("      color: var(--primary-dark);\r\n");
      out.write("    }\r\n");
      out.write("\r\n");
      out.write("    .alert-danger {\r\n");
      out.write("      background-color: rgba(220, 53, 69, 0.1);\r\n");
      out.write("      border-color: rgba(220, 53, 69, 0.2);\r\n");
      out.write("    }\r\n");
      out.write("  </style>\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "/templates/header.jsp", out, false);
      out.write("\r\n");
      out.write("<div class=\"container\">\r\n");
      out.write("  <div class=\"row justify-content-center\">\r\n");
      out.write("    <div class=\"col-md-6\">\r\n");
      out.write("      <div class=\"card shadow-lg\">\r\n");
      out.write("        <div class=\"card-header text-white text-center\">\r\n");
      out.write("          <h3 class=\"mb-0\">Đăng nhập</h3>\r\n");
      out.write("        </div>\r\n");
      out.write("        <div class=\"card-body\">\r\n");
      out.write("          <!-- Thông báo lỗi -->\r\n");
      out.write("          ");
      if (_jspx_meth_c_005fif_005f0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
      out.write("          <!-- Thông báo thành công -->\r\n");
      out.write("          ");
      if (_jspx_meth_c_005fif_005f1(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
      out.write("          <form action=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (jakarta.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/login\" method=\"POST\">\r\n");
      out.write("            <div class=\"mb-3\">\r\n");
      out.write("              <label for=\"email\" class=\"form-label\">Email</label>\r\n");
      out.write("              <input type=\"text\" id=\"email\" name=\"email\" class=\"form-control\" placeholder=\"Nhập email\" required>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"mb-3\">\r\n");
      out.write("              <label for=\"password\" class=\"form-label\">Mật khẩu</label>\r\n");
      out.write("              <div class=\"input-group\">\r\n");
      out.write("                <input type=\"password\" id=\"password\" name=\"password\" class=\"form-control\" placeholder=\"Nhập mật khẩu\" required>\r\n");
      out.write("                <span class=\"input-group-text\" onclick=\"togglePassword()\">\r\n");
      out.write("                  <i class=\"bi bi-eye\"></i>\r\n");
      out.write("                </span>\r\n");
      out.write("              </div>\r\n");
      out.write("            </div>\r\n");
      out.write("            <a href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (jakarta.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/user/UserTwoStepVerification.jsp\" class=\"forgot-password-link\">Quên mật khẩu?</a>\r\n");
      out.write("            <div class=\"remember-me\">\r\n");
      out.write("              <input type=\"checkbox\" name=\"remember-me\" id=\"remember-me\">\r\n");
      out.write("              <label for=\"remember-me\">Remember me</label>\r\n");
      out.write("            </div>\r\n");
      out.write("            <button type=\"submit\" class=\"btn btn-primary\">Đăng nhập</button>\r\n");
      out.write("          </form>\r\n");
      out.write("          <form action=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (jakarta.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/registers\">\r\n");
      out.write("            <button type=\"submit\" class=\"btn btn-secondary\">Đăng ký</button>\r\n");
      out.write("          </form>\r\n");
      out.write("        </div>\r\n");
      out.write("      </div>\r\n");
      out.write("    </div>\r\n");
      out.write("  </div>\r\n");
      out.write("</div>\r\n");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "/templates/footer.jsp", out, false);
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script>\r\n");
      out.write("  function togglePassword() {\r\n");
      out.write("    var passwordInput = document.getElementById(\"password\");\r\n");
      out.write("    var toggleIcon = document.querySelector(\".input-group-text i\");\r\n");
      out.write("    if (passwordInput.type === \"password\") {\r\n");
      out.write("      passwordInput.type = \"text\";\r\n");
      out.write("      toggleIcon.classList.remove(\"bi-eye\");\r\n");
      out.write("      toggleIcon.classList.add(\"bi-eye-slash\");\r\n");
      out.write("    } else {\r\n");
      out.write("      passwordInput.type = \"password\";\r\n");
      out.write("      toggleIcon.classList.remove(\"bi-eye-slash\");\r\n");
      out.write("      toggleIcon.classList.add(\"bi-eye\");\r\n");
      out.write("    }\r\n");
      out.write("  }\r\n");
      out.write("</script>\r\n");
      out.write("<script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${pageContext.request.contextPath}", java.lang.String.class, (jakarta.servlet.jsp.PageContext)_jspx_page_context, null));
      out.write("/js/bootstrap/bootstrap.bundle.min.js\"></script>\r\n");
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

  private boolean _jspx_meth_c_005fif_005f0(jakarta.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    jakarta.servlet.jsp.PageContext pageContext = _jspx_page_context;
    jakarta.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:if
    org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f0 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
    _jspx_th_c_005fif_005f0.setPageContext(_jspx_page_context);
    _jspx_th_c_005fif_005f0.setParent(null);
    // /user/Login.jsp(162,10) name = test type = boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fif_005f0.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${not empty sessionScope.error}", boolean.class, (jakarta.servlet.jsp.PageContext)_jspx_page_context, null)).booleanValue());
    int _jspx_eval_c_005fif_005f0 = _jspx_th_c_005fif_005f0.doStartTag();
    if (_jspx_eval_c_005fif_005f0 != jakarta.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\r\n");
        out.write("            <div class=\"alert alert-danger\">");
        out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${sessionScope.error}", java.lang.String.class, (jakarta.servlet.jsp.PageContext)_jspx_page_context, null));
        out.write("</div>\r\n");
        out.write("            ");
        if (_jspx_meth_c_005fremove_005f0(_jspx_th_c_005fif_005f0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("          ");
        int evalDoAfterBody = _jspx_th_c_005fif_005f0.doAfterBody();
        if (evalDoAfterBody != jakarta.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_c_005fif_005f0.doEndTag() == jakarta.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      return true;
    }
    _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.reuse(_jspx_th_c_005fif_005f0);
    return false;
  }

  private boolean _jspx_meth_c_005fremove_005f0(jakarta.servlet.jsp.tagext.JspTag _jspx_th_c_005fif_005f0, jakarta.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    jakarta.servlet.jsp.PageContext pageContext = _jspx_page_context;
    //  c:remove
    org.apache.taglibs.standard.tag.common.core.RemoveTag _jspx_th_c_005fremove_005f0 = (org.apache.taglibs.standard.tag.common.core.RemoveTag) _005fjspx_005ftagPool_005fc_005fremove_0026_005fvar_005fscope_005fnobody.get(org.apache.taglibs.standard.tag.common.core.RemoveTag.class);
    _jspx_th_c_005fremove_005f0.setPageContext(_jspx_page_context);
    _jspx_th_c_005fremove_005f0.setParent((jakarta.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f0);
    // /user/Login.jsp(164,12) name = var type = java.lang.String reqTime = false required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fremove_005f0.setVar("error");
    // /user/Login.jsp(164,12) name = scope type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fremove_005f0.setScope("session");
    int _jspx_eval_c_005fremove_005f0 = _jspx_th_c_005fremove_005f0.doStartTag();
    if (_jspx_th_c_005fremove_005f0.doEndTag() == jakarta.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      return true;
    }
    _005fjspx_005ftagPool_005fc_005fremove_0026_005fvar_005fscope_005fnobody.reuse(_jspx_th_c_005fremove_005f0);
    return false;
  }

  private boolean _jspx_meth_c_005fif_005f1(jakarta.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    jakarta.servlet.jsp.PageContext pageContext = _jspx_page_context;
    jakarta.servlet.jsp.JspWriter out = _jspx_page_context.getOut();
    //  c:if
    org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_005fif_005f1 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
    _jspx_th_c_005fif_005f1.setPageContext(_jspx_page_context);
    _jspx_th_c_005fif_005f1.setParent(null);
    // /user/Login.jsp(168,10) name = test type = boolean reqTime = true required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fif_005f1.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${not empty sessionScope.success}", boolean.class, (jakarta.servlet.jsp.PageContext)_jspx_page_context, null)).booleanValue());
    int _jspx_eval_c_005fif_005f1 = _jspx_th_c_005fif_005f1.doStartTag();
    if (_jspx_eval_c_005fif_005f1 != jakarta.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\r\n");
        out.write("            <div class=\"alert alert-success\">");
        out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${sessionScope.success}", java.lang.String.class, (jakarta.servlet.jsp.PageContext)_jspx_page_context, null));
        out.write("</div>\r\n");
        out.write("            ");
        if (_jspx_meth_c_005fremove_005f1(_jspx_th_c_005fif_005f1, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("          ");
        int evalDoAfterBody = _jspx_th_c_005fif_005f1.doAfterBody();
        if (evalDoAfterBody != jakarta.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_c_005fif_005f1.doEndTag() == jakarta.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      return true;
    }
    _005fjspx_005ftagPool_005fc_005fif_0026_005ftest.reuse(_jspx_th_c_005fif_005f1);
    return false;
  }

  private boolean _jspx_meth_c_005fremove_005f1(jakarta.servlet.jsp.tagext.JspTag _jspx_th_c_005fif_005f1, jakarta.servlet.jsp.PageContext _jspx_page_context)
          throws java.lang.Throwable {
    jakarta.servlet.jsp.PageContext pageContext = _jspx_page_context;
    //  c:remove
    org.apache.taglibs.standard.tag.common.core.RemoveTag _jspx_th_c_005fremove_005f1 = (org.apache.taglibs.standard.tag.common.core.RemoveTag) _005fjspx_005ftagPool_005fc_005fremove_0026_005fvar_005fscope_005fnobody.get(org.apache.taglibs.standard.tag.common.core.RemoveTag.class);
    _jspx_th_c_005fremove_005f1.setPageContext(_jspx_page_context);
    _jspx_th_c_005fremove_005f1.setParent((jakarta.servlet.jsp.tagext.Tag) _jspx_th_c_005fif_005f1);
    // /user/Login.jsp(170,12) name = var type = java.lang.String reqTime = false required = true fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fremove_005f1.setVar("success");
    // /user/Login.jsp(170,12) name = scope type = java.lang.String reqTime = false required = false fragment = false deferredValue = false expectedTypeName = null deferredMethod = false methodSignature = null
    _jspx_th_c_005fremove_005f1.setScope("session");
    int _jspx_eval_c_005fremove_005f1 = _jspx_th_c_005fremove_005f1.doStartTag();
    if (_jspx_th_c_005fremove_005f1.doEndTag() == jakarta.servlet.jsp.tagext.Tag.SKIP_PAGE) {
      return true;
    }
    _005fjspx_005ftagPool_005fc_005fremove_0026_005fvar_005fscope_005fnobody.reuse(_jspx_th_c_005fremove_005f1);
    return false;
  }
}
