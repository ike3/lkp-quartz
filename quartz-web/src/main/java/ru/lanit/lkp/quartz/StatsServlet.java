package ru.lanit.lkp.quartz;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Field;
import java.util.concurrent.Executor;

import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/stats")
public class StatsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter pw = resp.getWriter();

        try {
            printStats("java:/wm/test", pw);
            printStats("java:/wm/test-tp", pw);
        } catch (Exception e) {
            throw new ServletException(e);
        }

        pw.write("DONE");
        pw.flush();
    }

    private void printStats(String jndi, PrintWriter pw) throws Exception {
        Executor e = (Executor) new InitialContext().lookup(jndi);

        Object v = getFieldValue(
                getFieldValue(e, "executor", org.glassfish.enterprise.concurrent.ManagedExecutorServiceAdapter.class),
                "threadPoolExecutor",
                org.jboss.as.ee.concurrent.ManagedExecutorServiceImpl.class.getSuperclass()
        );
        pw.write(jndi + " = " + v.toString());
        pw.write("\n\n");
    }

    private Object getFieldValue(Object obj, String name, Class<?> clz) {
        try {
            Field f = clz.getDeclaredField(name);
            f.setAccessible(true);
            return f.get(obj);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
