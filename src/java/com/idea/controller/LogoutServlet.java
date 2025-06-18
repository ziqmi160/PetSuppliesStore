//package com.idea.controller;
//
//import java.io.IOException;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;
//import javax.servlet.http.HttpSession;
//
//@WebServlet(name = "LogoutServlet", urlPatterns = {"/LogoutServlet"})
//public class LogoutServlet extends HttpServlet {
//
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        
//        // Get the session and invalidate it
//        HttpSession session = request.getSession(false);
//        if (session != null) {
//            session.invalidate();
//        }
//        
//        // Redirect to login page with success message
//        response.sendRedirect("login.jsp?success=You+have+been+successfully+logged+out");
//    }
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    @Override
//    public String getServletInfo() {
//        return "Logout Servlet";
//    }
//} 

    package com.idea.controller;

    import javax.servlet.ServletException;
    import javax.servlet.http.HttpServlet;
    import javax.servlet.http.HttpServletRequest;
    import javax.servlet.http.HttpServletResponse;
    import javax.servlet.http.HttpSession;
    import java.io.IOException;
    import java.util.logging.Logger;

   
    public class LogoutServlet extends HttpServlet {
        private static final long serialVersionUID = 1L;
        private static final Logger LOGGER = Logger.getLogger(LogoutServlet.class.getName());

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            HttpSession session = request.getSession(false); // Do not create if it doesn't exist

            if (session != null) {
                String role = request.getParameter("role"); // Check if it's an admin logout
                if ("admin".equals(role)) {
                    session.removeAttribute("admin"); // Remove admin object from session
                    LOGGER.info("Admin logout successful. Session invalidated.");
                    session.invalidate(); // Invalidate the entire session for security
                    response.sendRedirect("admin-login.jsp"); // Redirect to admin login page
                } else {
                    session.removeAttribute("user"); // Remove user object from session
                    LOGGER.info("User logout successful. Session invalidated.");
                    session.invalidate(); // Invalidate the entire session for security
                    response.sendRedirect("login.jsp"); // Redirect to regular user login page
                }
            } else {
                LOGGER.info("Logout requested but no active session found.");
                // If no session, still redirect to appropriate login page based on role parameter
                String role = request.getParameter("role");
                if ("admin".equals(role)) {
                    response.sendRedirect("admin-login.jsp");
                } else {
                    response.sendRedirect("login.jsp");
                }
            }
        }

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            doGet(request, response); // POST requests can also trigger logout
        }
    }
    