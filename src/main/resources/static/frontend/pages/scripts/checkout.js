var Checkout = function () {

    return {
        init: function () {
            
            $('#checkout').on('change', '#checkout-content input[name="account"]', function() {

              var title = '';

              if ($(this).attr('value') == 'register') {
                title = 'Step 2: Account &amp; Billing Details';
              } else {
                title = 'Step 2: Billing Details';
              }    

              $('#payment-address .accordion-toggle').html(title);
            });

        }
    };

}();

function updateTotalPrice() {
        var total = 0;
        var subTotal = 0;

        // Duyệt qua tất cả các checkbox để tính tổng giá trị
        var checkboxes = document.getElementsByName("listCartIemId");
        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) {
                var itemId = checkboxes[i].value;
                var quantity = document.getElementById("product-quantity-" + itemId).value;
                var price = document.getElementById("total-" + itemId).innerText.replace('$', '');

                subTotal += parseFloat(price);
            }
        }

        // Cập nhật subTotal và total
        document.getElementById("subTotal").innerText = subTotal.toFixed(2);
        document.getElementById("totalPrice").innerText = (subTotal + 3).toFixed(2);
    }

    function checkSelectedItems() {
        var checkboxes = document.getElementsByName("listCartIemId");
        var checked = false;

        // Kiểm tra xem có item nào được chọn
        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i].checked) {
                checked = true;
                break;
            }
        }

        if (!checked) {
            alert("You must select at least one item to proceed with checkout.");
        } else {
            document.getElementById("checkoutForm").submit();
        }
    }
    
    
    function updateQuantity(cartItemId, newQuantity) {
       fetch('cart/updateQuantity', {
           method: 'POST',
           headers: {
               'Content-Type': 'application/json'
           },
           body: JSON.stringify({
               cartItemId: cartItemId,
               quantity: newQuantity
           })
       })
       .then(response => response.json())
       .then(data => {
           if (data.success) {
                alert('Quantity updated successfully!');
                //alert('Quantity updated successfully!');
               // Optionally, update the total price dynamically
               location.reload(); // Reload to reflect new total
           } else {
               alert('Failed to update quantity: ' + data.message);
           }
       })
       .catch(error => {
           console.error('Error:', error);
           alert('Something went wrong! Please try again.');
       });
   }
    document.addEventListener('DOMContentLoaded', function () {
        console.log("DOM fully loaded and parsed");
    });

    function decrement(id) {
        let input = document.getElementById("product-quantity-" + id);

        if (input && input.value > 1) {
            input.value--; // Giảm số lượng
            updateQuantity(id, input.value); // Cập nhật số lượng
        }
    }


    function increment(id) {
    	let input = document.getElementById("product-quantity-" + id);
        input.value++;
        updateQuantity(id, input.value);
    }
    
    