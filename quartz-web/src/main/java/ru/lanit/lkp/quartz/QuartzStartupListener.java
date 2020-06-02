package ru.lanit.lkp.quartz;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ru.lanit.fz44.service.scheduler.AbstractSchedulerService;

public class QuartzStartupListener extends AbstractSchedulerService implements ServletContextListener {
    private Logger log = LoggerFactory.getLogger(QuartzStartupListener.class);

    @Override
    protected String getSchedulerName() {
        return "Test";
    }

    @Override
    protected void createTasks() {
        createTask("testTask", "0/1 * * ? * * *", TestTask.class);
    }

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            log.info("Initializing Quartz");
            super.afterPropertiesSet();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        try {
            log.info("Destroying Quartz");
            super.destroy();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
