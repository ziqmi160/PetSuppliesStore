package com.idea.controller;

import com.idea.dao.CartDAO;
import com.idea.dao.ProductDAO;
import com.idea.model.CartItem;
import com.idea.model.Product;
import com.idea.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(CartServlet.class.getName());
    private CartDAO cartDAO;
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        cartDAO = new CartDAO();
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        LOGGER.info("-------------------- New GET Request to CartServlet --------------------");
        LOGGER.log(Level.INFO, "Request URL: {0}", request.getRequestURL());
        LOGGER.log(Level.INFO, "Query String: {0}", request.getQueryString());
        Enumeration<String> parameterNames = request.getParameterNames();
        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();
            String[] paramValues = request.getParameterValues(paramName);
            for (String paramValue : paramValues) {
                LOGGER.log(Level.INFO, "Parameter: {0} = ''{1}''", new Object[]{paramName, paramValue});
            }
        }
        LOGGER.info("----------------------------------------------------------------------");


        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            LOGGER.warning("Unauthorized access to CartServlet: User not logged in. Redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }
        LOGGER.log(Level.INFO, "User ID in session for GET request: {0}", user.getId());

        int cartId;
        List<CartItem> cartItems;
        try {
            cartId = cartDAO.getOrCreateCartId(user.getId());
            LOGGER.log(Level.INFO, "Retrieved/Created Cart ID: {0} for User ID: {1}", new Object[]{cartId, user.getId()});
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception while getting or creating cart ID: {0}", e.getMessage());
            response.sendRedirect("error.jsp");
            return;
        }

        String action = request.getParameter("action");
        LOGGER.log(Level.INFO, "GET request action retrieved: ''{0}''", action);

        if ("add".equals(action)) {
            addToCart(request, cartId, session); // Pass session
        } else if ("remove".equals(action)) {
            LOGGER.info("Calling removeFromCart from doGet. Product ID will be retrieved inside the method.");
            removeFromCart(request, cartId, session); // Pass session
        }
        
        try {
            cartItems = cartDAO.getCartItems(cartId);
            LOGGER.log(Level.INFO, "Fetched {0} items for Cart ID: {1}", new Object[]{cartItems.size(), cartId});
            
            boolean quantitiesAdjusted = adjustCartQuantitiesToAvailableStock(cartId, cartItems, session); // Pass session
            if (quantitiesAdjusted) {
                // If quantities were adjusted, re-fetch the cart to reflect the latest state
                cartItems = cartDAO.getCartItems(cartId);
            }
            
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception while fetching cart items or adjusting quantities: {0}", e.getMessage());
            session.setAttribute("error", "An error occurred while loading your cart. Please try again.");
            response.sendRedirect("error.jsp");
            return;
        }

        double subtotal = calculateSubtotal(cartItems);
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("total", subtotal);

        request.getRequestDispatcher("cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        LOGGER.info("-------------------- New POST Request to CartServlet --------------------");
        LOGGER.log(Level.INFO, "Request URL: {0}", request.getRequestURL());
        Enumeration<String> parameterNames = request.getParameterNames();
        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();
            String[] paramValues = request.getParameterValues(paramName);
            for (String paramValue : paramValues) {
                LOGGER.log(Level.INFO, "Parameter: {0} = ''{1}''", new Object[]{paramName, paramValue});
            }
        }
        LOGGER.info("----------------------------------------------------------------------");

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            LOGGER.warning("Unauthorized access to CartServlet (POST): User not logged in. Redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }
        LOGGER.log(Level.INFO, "User ID in session for POST request: {0}", user.getId());

        int cartId;
        try {
            cartId = cartDAO.getOrCreateCartId(user.getId());
            LOGGER.log(Level.INFO, "Retrieved/Created Cart ID (POST): {0} for User ID: {1}", new Object[]{cartId, user.getId()});
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQL Exception while getting or creating cart ID (POST): {0}", e.getMessage());
            response.sendRedirect("error.jsp");
            return;
        }

        String action = request.getParameter("action");
        LOGGER.log(Level.INFO, "POST request action retrieved: ''{0}''", action);

        if (null == action) {
            LOGGER.info("POST request with unhandled action or no action. Delegating to doGet.");
            doGet(request, response);
        } else switch (action) {
            case "updateAll":
                List<CartItem> currentCartItemsFromDB = null;
                try {
                    currentCartItemsFromDB = cartDAO.getCartItems(cartId);
                    boolean quantitiesAdjusted = adjustCartQuantitiesToAvailableStock(cartId, currentCartItemsFromDB, session); // Pass session
                    if (quantitiesAdjusted) {
                        session.setAttribute("cartMessage", "Some item quantities were adjusted to match available stock.");
                    }
                } catch (SQLException e) {
                    LOGGER.log(Level.SEVERE, "SQL Exception during stock adjustment before updateAll: {0}", e.getMessage());
                    session.setAttribute("error", "An error occurred during cart update preparation.");
                    response.sendRedirect("CartServlet");
                    return;
                }   updateAllCartItems(request, cartId, session); // Pass session
                LOGGER.info("POST operation 'updateAll' complete. Redirecting to CartServlet for fresh display.");
                response.sendRedirect("CartServlet");
                break;
            case "checkoutSelected":
                handleCheckoutSelected(request, response, cartId, session); // Pass session
                break;
            default:
                LOGGER.info("POST request with unhandled action or no action. Delegating to doGet.");
                doGet(request, response);
                break;
        }
    }

    private void addToCart(HttpServletRequest request, int cartId, HttpSession session) { // Added HttpSession session
        String productIdStr = request.getParameter("productId");
        String quantityStr = request.getParameter("quantity");
        LOGGER.log(Level.INFO, "addToCart called. Product ID String: ''{0}'', Quantity String: ''{1}''", new Object[]{productIdStr, quantityStr});

        try {
            int productId = Integer.parseInt(productIdStr);
            int quantity = Integer.parseInt(quantityStr);

            int availableStock = productDAO.getProductStock(productId);
            if (availableStock == 0) {
                 LOGGER.log(Level.WARNING, "Cannot add product {0} to cart: No stock available.", productId);
                 session.setAttribute("error", "Product is out of stock and cannot be added to cart."); // Used session
                 return;
            }
            if (quantity > availableStock) {
                LOGGER.log(Level.WARNING, "Attempted to add more than available stock for Product ID: {0}. Adjusting quantity to available stock.", productId);
                quantity = availableStock;
                session.setAttribute("cartMessage", "Quantity adjusted to available stock for " + productDAO.getProductById(productId).getName() + "."); // Used session
            }

            CartItem existingItem = cartDAO.getCartItem(cartId, productId);
            if (existingItem != null) {
                int newQuantity = existingItem.getQuantity() + quantity;
                if (newQuantity > availableStock) {
                     newQuantity = availableStock;
                     session.setAttribute("cartMessage", "Quantity adjusted to available stock for " + productDAO.getProductById(productId).getName() + "."); // Used session
                }
                cartDAO.updateCartItem(cartId, productId, newQuantity);
                LOGGER.log(Level.INFO, "Updated quantity for existing item Product ID: {0} to {1}", new Object[]{productId, newQuantity});
            } else {
                Product product = productDAO.getProductById(productId);
                if (product != null) {
                    String imagePath = product.getImages().isEmpty() ? "" : product.getImages().get(0).getPath();
                    CartItem newItem = new CartItem(
                            product.getId(),
                            product.getName(),
                            product.getPrice(),
                            quantity,
                            imagePath
                    );
                    cartDAO.addCartItem(cartId, newItem);
                    LOGGER.log(Level.INFO, "Added new item Product ID: {0} with quantity {1}", new Object[]{productId, quantity});
                } else {
                    LOGGER.log(Level.WARNING, "Product with ID {0} not found, cannot add to cart.", productId);
                    session.setAttribute("error", "Product not found and cannot be added to cart."); // Used session
                }
            }
        } catch (NumberFormatException e) {
            LOGGER.log(Level.SEVERE, "NumberFormatException in addToCart: Invalid product ID or quantity format. Product ID Str: ''{0}'', Quantity Str: ''{1}''", new Object[]{productIdStr, quantityStr});
            session.setAttribute("error", "Invalid product ID or quantity format."); // Used session
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQLException in addToCart: {0}", e.getMessage());
            session.setAttribute("error", "Database error while adding to cart."); // Used session
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "General Exception in addToCart: {0}", e.getMessage());
            session.setAttribute("error", "An unexpected error occurred while adding to cart."); // Used session
        }
    }

    private void removeFromCart(HttpServletRequest request, int cartId, HttpSession session) { // Added HttpSession session
        String productIdStr = request.getParameter("productId");
        LOGGER.log(Level.INFO, "removeFromCart called. Product ID String received: ''{0}''", productIdStr);

        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            LOGGER.warning("removeFromCart: Received null or empty product ID string. Cannot remove item.");
            session.setAttribute("error", "Failed to remove item: Product ID missing."); // Used session
            return;
        }

        try {
            int productId = Integer.parseInt(productIdStr);
            LOGGER.log(Level.INFO, "removeFromCart: Attempting to remove Product ID: {0} from Cart ID: {1}", new Object[]{productId, cartId});
            cartDAO.removeCartItem(cartId, productId);
            LOGGER.log(Level.INFO, "removeFromCart: Successfully removed Product ID: {0}", productId);
            session.setAttribute("message", "Item successfully removed from cart."); // Used session
        } catch (NumberFormatException e) {
            LOGGER.log(Level.SEVERE, "NumberFormatException in removeFromCart: Invalid product ID format for string ''{0}''. {1}", new Object[]{productIdStr, e.getMessage()});
            session.setAttribute("error", "Failed to remove item: Invalid product ID format."); // Used session
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "SQLException in removeFromCart: {0}", e.getMessage());
            session.setAttribute("error", "Failed to remove item due to a database error."); // Used session
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "General Exception in removeFromCart: {0}", e.getMessage());
            session.setAttribute("error", "An unexpected error occurred while removing item."); // Used session
        }
    }

    private void updateAllCartItems(HttpServletRequest request, int cartId, HttpSession session) { // Added HttpSession session
        String[] productIdsStr = request.getParameterValues("productId");
        String[] quantitiesStr = request.getParameterValues("quantity");
        LOGGER.log(Level.INFO, "updateAllCartItems called. Received Product IDs count: {0}, Quantities count: {1}", new Object[]{productIdsStr != null ? productIdsStr.length : 0, quantitiesStr != null ? quantitiesStr.length : 0});

        if (productIdsStr != null && quantitiesStr != null && productIdsStr.length == quantitiesStr.length) {
            try {
                for (int i = 0; i < productIdsStr.length; i++) {
                    String currentProductIdStr = productIdsStr[i];
                    String currentQuantityStr = quantitiesStr[i];
                    LOGGER.log(Level.INFO, "Processing update for Product ID String: ''{0}'', Quantity String: ''{1}''", new Object[]{currentProductIdStr, currentQuantityStr});

                    if (currentProductIdStr == null || currentProductIdStr.trim().isEmpty() ||
                        currentQuantityStr == null || currentQuantityStr.trim().isEmpty()) {
                        LOGGER.warning("Skipping update for an item due to null/empty Product ID or Quantity string.");
                        continue;
                    }

                    int productId = Integer.parseInt(currentProductIdStr);
                    int quantity = Integer.parseInt(currentQuantityStr);
                    
                    int availableStock = productDAO.getProductStock(productId);
                    if (quantity > availableStock) {
                        LOGGER.log(Level.WARNING, "User requested quantity ({0}) exceeds available stock ({1}) for Product ID: {2}. Adjusting to max available.", new Object[]{quantity, availableStock, productId});
                        quantity = availableStock;
                        session.setAttribute("cartMessage", "Quantity for some items was reduced to match available stock."); // Used session
                    }

                    if (quantity > 0) {
                        cartDAO.updateCartItem(cartId, productId, quantity);
                        LOGGER.log(Level.INFO, "Updated quantity for Product ID: {0} to {1}", new Object[]{productId, quantity});
                    } else {
                        cartDAO.removeCartItem(cartId, productId);
                        LOGGER.log(Level.INFO, "Removed Product ID: {0} due to zero or negative quantity.", productId);
                    }
                }
            } catch (NumberFormatException e) {
                LOGGER.log(Level.SEVERE, "NumberFormatException in updateAllCartItems: Invalid number format encountered. {0}", e.getMessage());
                session.setAttribute("error", "Invalid quantity or product ID format provided for one or more items."); // Used session
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "SQLException in updateAllCartItems: {0}", e.getMessage());
                session.setAttribute("error", "Database error during cart update: " + e.getMessage()); // Used session
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "General Exception in updateAllCartItems: {0}", e.getMessage());
                session.setAttribute("error", "An unexpected error occurred during cart update."); // Used session
            }
        } else {
            LOGGER.warning("updateAllCartItems: Mismatch in product IDs and quantities array lengths or arrays are null.");
            session.setAttribute("error", "No cart items to update or data mismatch."); // Used session
        }
    }

    private void handleCheckoutSelected(HttpServletRequest request, HttpServletResponse response, int cartId, HttpSession session) throws ServletException, IOException { // Added HttpSession session
        String[] selectedProductIdsStr = request.getParameterValues("checkoutProductId");
        String[] selectedQuantitiesStr = request.getParameterValues("checkoutQuantity");

        List<CartItem> selectedCartItems = new ArrayList<>();
        double totalSelected = 0.0;
        boolean stockAdjustedDuringCheckoutPrep = false;

        if (selectedProductIdsStr != null && selectedQuantitiesStr != null && selectedProductIdsStr.length == selectedQuantitiesStr.length) {
            try {
                List<CartItem> currentCartItemsFromDB = cartDAO.getCartItems(cartId);

                for (int i = 0; i < selectedProductIdsStr.length; i++) {
                    String productIdStr = selectedProductIdsStr[i];
                    String quantityStr = selectedQuantitiesStr[i];

                    if (productIdStr == null || productIdStr.trim().isEmpty() || quantityStr == null || quantityStr.trim().isEmpty()) {
                        LOGGER.warning("Skipping selected item due to null/empty Product ID or Quantity string.");
                        continue;
                    }

                    int selectedProductId = Integer.parseInt(productIdStr);
                    int selectedQuantity = Integer.parseInt(quantityStr);
                    
                    int availableStock = productDAO.getProductStock(selectedProductId);
                    if (selectedQuantity > availableStock) {
                        LOGGER.log(Level.WARNING, "Checkout request: User requested quantity ({0}) exceeds available stock ({1}) for Product ID: {2}. Adjusting to max available.", new Object[]{selectedQuantity, availableStock, selectedProductId});
                        selectedQuantity = availableStock;
                        stockAdjustedDuringCheckoutPrep = true;
                    }
                    if (selectedQuantity == 0 && availableStock == 0) {
                         LOGGER.log(Level.WARNING, "Product ID {0} is out of stock and cannot be checked out. Removing from selected items.", selectedProductId);
                         stockAdjustedDuringCheckoutPrep = true;
                         continue;
                    }

                    CartItem matchedItem = null;
                    for (int k = 0; k < currentCartItemsFromDB.size(); k++) {
                        CartItem itemInDB = (CartItem)currentCartItemsFromDB.get(k);
                        if (itemInDB.getProductId() == selectedProductId) {
                            matchedItem = itemInDB;
                            break;
                        }
                    }

                    if (matchedItem != null) {
                        CartItem selectedItem = new CartItem(
                            matchedItem.getProductId(),
                            matchedItem.getName(),
                            matchedItem.getPrice(),
                            selectedQuantity,
                            matchedItem.getImagePath()
                        );
                        selectedCartItems.add(selectedItem);
                        totalSelected += selectedItem.getTotal();
                        LOGGER.log(Level.INFO, "Selected for checkout: Product ID {0}, Quantity: {1}", new Object[]{selectedProductId, selectedQuantity});
                    } else {
                        LOGGER.log(Level.WARNING, "Product ID {0} was selected for checkout but not found in current cart items.", selectedProductId);
                        stockAdjustedDuringCheckoutPrep = true;
                    }
                }

                if (stockAdjustedDuringCheckoutPrep) {
                    session.setAttribute("checkoutMessage", "Some quantities were adjusted, or items removed, during checkout preparation due to stock availability."); // Used session
                }
                
            } catch (NumberFormatException e) {
                LOGGER.log(Level.SEVERE, "NumberFormatException in handleCheckoutSelected: Invalid product ID or quantity format. {0}", e.getMessage());
                session.setAttribute("error", "Invalid format for selected items."); // Used session
            } catch (SQLException e) {
                LOGGER.log(Level.SEVERE, "SQLException in handleCheckoutSelected: {0}", e.getMessage());
                session.setAttribute("error", "Database error while preparing checkout."); // Used session
            } catch (Exception e) {
                LOGGER.log(Level.SEVERE, "General Exception in handleCheckoutSelected: {0}", e.getMessage());
                session.setAttribute("error", "An unexpected error occurred during checkout preparation."); // Used session
            }
        } else {
            LOGGER.warning("handleCheckoutSelected: No selected items or data mismatch.");
            session.setAttribute("error", "No items selected for checkout or data mismatch."); // Used session
        }

        request.getSession().setAttribute("selectedCartItemsForCheckout", selectedCartItems);
        request.getSession().setAttribute("totalSelectedForCheckout", totalSelected);
        
        if (!selectedCartItems.isEmpty()) {
            LOGGER.log(Level.INFO, "Redirecting to checkout.jsp with {0} selected items.", selectedCartItems.size());
            response.sendRedirect("checkout.jsp");
        } else {
            LOGGER.warning("No items left for checkout after stock adjustments. Redirecting back to CartServlet.");
            session.setAttribute("error", "No items could be selected for checkout due to stock issues. Please review your cart."); // Used session
            response.sendRedirect("CartServlet");
        }
    }

    private double calculateSubtotal(List<CartItem> cart) {
        double subtotal = 0.0;
        if (cart != null) {
            for (int i = 0; i < cart.size(); i++) {
                CartItem item = (CartItem) cart.get(i);
                subtotal += item.getTotal();
            }
        }
        return subtotal;
    }

    private boolean adjustCartQuantitiesToAvailableStock(int cartId, List<CartItem> cartItems, HttpSession session) throws SQLException { // Added HttpSession session
        boolean quantitiesAdjusted = false;
        if (cartItems == null || cartItems.isEmpty()) {
            return false;
        }

        List<CartItem> itemsToRemove = new ArrayList<>();

        for (int i = 0; i < cartItems.size(); i++) {
            CartItem item = (CartItem) cartItems.get(i);
            int currentCartQuantity = item.getQuantity();
            int availableStock = productDAO.getProductStock(item.getProductId());

            if (currentCartQuantity > availableStock) {
                item.setQuantity(availableStock);
                cartDAO.updateCartItem(cartId, item.getProductId(), availableStock);
                quantitiesAdjusted = true;
                LOGGER.log(Level.INFO, "Adjusted cart quantity for Product ID {0} from {1} to {2} due to low stock.", new Object[]{item.getProductId(), currentCartQuantity, availableStock});
                // Optionally add a more specific message for each item
                // session.setAttribute("cartMessage", (session.getAttribute("cartMessage") != null ? (String)session.getAttribute("cartMessage") + "\n" : "") + "Quantity for " + item.getName() + " adjusted to " + availableStock + ".");
            }
            
            if (item.getQuantity() == 0 && availableStock == 0) {
                 itemsToRemove.add(item);
                 quantitiesAdjusted = true;
                 LOGGER.log(Level.INFO, "Marking Product ID {0} for removal as it is out of stock.", item.getProductId());
            }
        }

        for (int i = 0; i < itemsToRemove.size(); i++) {
            CartItem item = (CartItem) itemsToRemove.get(i);
            cartDAO.removeCartItem(cartId, item.getProductId());
            cartItems.remove(item);
            i--;
            // Optionally add a more specific message for each removed item
            // session.setAttribute("cartMessage", (session.getAttribute("cartMessage") != null ? (String)session.getAttribute("cartMessage") + "\n" : "") + item.getName() + " removed from cart as it is out of stock.");
        }
        
        // Set a general message if any adjustments/removals occurred in this method
        if (quantitiesAdjusted && session.getAttribute("cartMessage") == null) {
            session.setAttribute("cartMessage", "Some items in your cart were adjusted or removed due to stock changes.");
        }


        return quantitiesAdjusted;
    }
}
