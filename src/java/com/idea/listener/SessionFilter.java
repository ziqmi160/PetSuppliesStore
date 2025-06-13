package com.idea.listener;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebFilter;

@WebFilter("/*")
public class SessionFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        // Get the requested URL and context path
        String requestURL = httpRequest.getRequestURL().toString();
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();

        // Check if the request is for a static resource
        if (isStaticResource(requestURI)) {
            chain.doFilter(request, response);
            return;
        }

        // Check if user is logged in
        boolean isLoggedIn = (session != null && session.getAttribute("userID") != null);

        // If user is not logged in and trying to access protected pages
        if (!isLoggedIn && isProtectedPage(requestURI)) {
            // Store the requested URL to redirect back after login
            String redirectURL = requestURI;
            if (httpRequest.getQueryString() != null) {
                redirectURL += "?" + httpRequest.getQueryString();
            }
            httpResponse.sendRedirect(contextPath + "/login.jsp?redirect=" + redirectURL);
            return;
        }

        // If user is logged in and trying to access login/register pages
        if (isLoggedIn && (requestURI.endsWith("login.jsp") || requestURI.endsWith("register.jsp"))) {
            httpResponse.sendRedirect(contextPath + "/index.jsp");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }

    private boolean isStaticResource(String uri) {
        return uri.contains("/css/") ||
                uri.contains("/js/") ||
                uri.contains("/images/") ||
                uri.contains("/fonts/") ||
                uri.contains("/favicon.ico");
    }

    private boolean isProtectedPage(String uri) {
        return uri.contains("/profile.jsp") ||
                uri.contains("/cart.jsp") ||
                uri.contains("/checkout.jsp") ||
                uri.contains("/orders.jsp") ||
                uri.contains("/wishlist.jsp") ||
                uri.contains("/edit-profile.jsp");
    }
}