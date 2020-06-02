package ru.lanit.lkp.quartz;

import org.quartz.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class TestTask implements Job {
    private Logger log = LoggerFactory.getLogger(TestTask.class);
    private static int ids = 1;

    @Override
    public void execute(JobExecutionContext context) throws JobExecutionException {
        long id = ids++;
        String name = System.getProperty("jboss.server.name");
        log.info("TestTask {} is STARTED ({})", new Object[] { id, name });
        try {
            Thread.sleep(900l * 3 * 2);
            Thread.sleep(7l);
        } catch (InterruptedException e) {
            throw new JobExecutionException(e);
        }
        log.info("TestTask {} is FINISHED", new Object[] { id });
    }

}
