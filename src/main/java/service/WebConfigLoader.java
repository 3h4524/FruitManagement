package service;

import jakarta.servlet.ServletContext;

public class WebConfigLoader {
    private static ServletContext context;

    public static void init(ServletContext servletContext) {
        context = servletContext;
    }

    public static String getProperty(String key) {
        return context.getInitParameter(key);
    }
}
