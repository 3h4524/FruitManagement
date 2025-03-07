package listener;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

public class AppViewListener implements HttpSessionListener {
    @Override
    public void sessionCreated (HttpSessionEvent event){
        ServletContext context = event.getSession().getServletContext();
        synchronized (context){
            Integer visitorCount = (Integer) context.getAttribute("visitorCount");
            if(visitorCount == null){
                visitorCount = 1;
            } else {
                visitorCount++;
            }
            context.setAttribute("visitorCount", visitorCount);
        }
    }
    @Override
    public void sessionDestroyed (HttpSessionEvent event){
        ServletContext context = event.getSession().getServletContext();
        synchronized (context){
            Integer visitorCount = (Integer) context.getAttribute("visitorCount");
            if(visitorCount != null && visitorCount > 0){
                visitorCount--;
            } else {
                visitorCount = 0;
            }
            context.setAttribute("visitorCount", visitorCount);
        }
    }
}
