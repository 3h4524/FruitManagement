package listener;

import dao.BaseDAO;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import static dao.BaseDAO.close;

public class AppListener implements ServletContextListener {
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        BaseDAO.close();
    }
}
