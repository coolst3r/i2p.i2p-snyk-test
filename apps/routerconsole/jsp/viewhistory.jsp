<%@page pageEncoding="UTF-8"%><%
/*
 * USE CAUTION WHEN EDITING
 * Trailing whitespace OR NEWLINE on the last line will cause
 * IllegalStateExceptions !!!
 *
 * Do not tag this file for translation.
 */
response.setContentType("text/plain");
response.setHeader("X-Content-Type-Options", "nosniff");
response.setDateHeader("Expires", 0);
response.addHeader("Cache-Control", "no-store, max-age=0, no-cache, must-revalidate");
response.addHeader("Pragma", "no-cache");
String base = net.i2p.I2PAppContext.getGlobalContext().getBaseDir().getAbsolutePath();
try {
    net.i2p.util.FileUtil.readFile("history.txt", base, response.getOutputStream());
} catch (java.io.IOException ioe) {
    // prevent 'Committed' IllegalStateException from Jetty
    if (!response.isCommitted()) {
        response.sendError(403, ioe.toString());
    }  else {
        // not an error, happens when the browser closes the stream
        net.i2p.I2PAppContext.getGlobalContext().logManager().getLog(getClass()).warn("Error serving history.txt", ioe);
        // Jetty doesn't log this
        throw ioe;
    }
}
%>