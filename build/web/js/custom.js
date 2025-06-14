//(function() {
//	'use strict';
//
//	var tinyslider = function() {
//		var el = document.querySelectorAll('.testimonial-slider');
//
//		if (el.length > 0) {
//			var slider = tns({
//				container: '.testimonial-slider',
//				items: 1,
//				axis: "horizontal",
//				controlsContainer: "#testimonial-nav",
//				swipeAngle: false,
//				speed: 700,
//				nav: true,
//				controls: true,
//				autoplay: true,
//				autoplayHoverPause: true,
//				autoplayTimeout: 3500,
//				autoplayButtonOutput: false
//			});
//		}
//	};
//	tinyslider();
//
//	
//
//
//	var sitePlusMinus = function() {
//
//		var value,
//    		quantity = document.getElementsByClassName('quantity-container');
//
//		function createBindings(quantityContainer) {
//	      var quantityAmount = quantityContainer.getElementsByClassName('quantity-amount')[0];
//	      var increase = quantityContainer.getElementsByClassName('increase')[0];
//	      var decrease = quantityContainer.getElementsByClassName('decrease')[0];
//	      increase.addEventListener('click', function (e) { increaseValue(e, quantityAmount); });
//	      decrease.addEventListener('click', function (e) { decreaseValue(e, quantityAmount); });
//	    }
//
//	    function init() {
//	        for (var i = 0; i < quantity.length; i++ ) {
//						createBindings(quantity[i]);
//	        }
//	    };
//
//	    function increaseValue(event, quantityAmount) {
//	        value = parseInt(quantityAmount.value, 10);
//
//	        console.log(quantityAmount, quantityAmount.value);
//
//	        value = isNaN(value) ? 0 : value;
//	        value++;
//	        quantityAmount.value = value;
//	    }
//
//	    function decreaseValue(event, quantityAmount) {
//	        value = parseInt(quantityAmount.value, 10);
//
//	        value = isNaN(value) ? 0 : value;
//	        if (value > 0) value--;
//
//	        quantityAmount.value = value;
//	    }
//	    
//	    init();
//		
//	};
//	sitePlusMinus();
//
//
//})()

(function() {
    'use strict';

    var tinyslider = function() {
        var el = document.querySelectorAll('.testimonial-slider');

        if (el.length > 0) {
            var slider = tns({
                container: '.testimonial-slider',
                items: 1,
                axis: "horizontal",
                controlsContainer: "#testimonial-nav",
                swipeAngle: false,
                speed: 700,
                nav: true,
                controls: true,
                autoplay: true,
                autoplayHoverPause: true,
                autoplayTimeout: 3500,
                autoplayButtonOutput: false
            });
        }
    };
    tinyslider();

    // Check the current page path to prevent conflicts on cart.jsp
    // We only want sitePlusMinus to run if the current page is NOT cart.jsp
    var sitePlusMinus = function() {
        // Only proceed if we are NOT on the cart.jsp page
        // You might need to adjust '/cart.jsp' based on your actual URL structure
        // For example, it might be '/your_app_context/CartServlet' or similar.
        // For now, '/cart.jsp' or '/CartServlet' is a reasonable guess.
        var path = window.location.pathname;
        if (path.includes('/cart.jsp') || path.includes('/CartServlet')) {
            console.log('custom.js: Skipping sitePlusMinus on cart page.');
            return; // Exit the function if on the cart page
        }

        var value,
            quantity = document.getElementsByClassName('quantity-container');

        function createBindings(quantityContainer) {
            var quantityAmount = quantityContainer.getElementsByClassName('quantity-amount')[0];
            // Ensure these classes exist where custom.js is intended to run
            var increase = quantityContainer.getElementsByClassName('increase')[0];
            var decrease = quantityContainer.getElementsByClassName('decrease')[0];

            // Add null checks for safety, in case elements are still missing on other pages
            if (increase) {
                increase.addEventListener('click', function (e) { increaseValue(e, quantityAmount); });
            } else {
                console.warn("custom.js: 'increase' button not found in quantity container.");
            }
            if (decrease) {
                decrease.addEventListener('click', function (e) { decreaseValue(e, quantityAmount); });
            } else {
                console.warn("custom.js: 'decrease' button not found in quantity container.");
            }
        }

        function init() {
            for (var i = 0; i < quantity.length; i++ ) {
                createBindings(quantity[i]);
            }
        };

        function increaseValue(event, quantityAmount) {
            value = parseInt(quantityAmount.value, 10);
            value = isNaN(value) ? 0 : value;
            value++;
            quantityAmount.value = value;
            // console.log("custom.js: Increased quantity to " + quantityAmount.value); // Debugging
        }

        function decreaseValue(event, quantityAmount) {
            value = parseInt(quantityAmount.value, 10);
            value = isNaN(value) ? 0 : value;
            if (value > 0) value--;
            quantityAmount.value = value;
            // console.log("custom.js: Decreased quantity to " + quantityAmount.value); // Debugging
        }
        
        init();
        
    };
    sitePlusMinus();


})();
