 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html>
<html>
<!-- HEAD START -->
<head>
	<meta charset="UTF-8">
	<title><sitemesh:write property="title"/></title>
	<link rel="shortcut icon" href="favicon.ico">
	<!-- Fonts START -->
  <link href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700|PT+Sans+Narrow|Source+Sans+Pro:200,300,400,600,700,900&amp;subset=all" rel="stylesheet" type="text/css">
  <!-- Fonts END -->

  <!-- Global styles START -->          
  <link href="/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <link href="/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <!-- Global styles END --> 
   
  <!-- Page level plugin styles START -->
  <link href="/global/plugins/fancybox/source/jquery.fancybox.css" rel="stylesheet">
  <link href="/global/plugins/carousel-owl-carousel/owl-carousel/owl.carousel.css" rel="stylesheet">
  <link href="/global/plugins/slider-revolution-slider/rs-plugin/css/settings.css" rel="stylesheet">
  <link href="/global/plugins/uniform/css/uniform.default.css" rel="stylesheet" type="text/css">
  <link href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" rel="stylesheet" type="text/css">
  <link href="/global/plugins/rateit/src/rateit.css" rel="stylesheet" type="text/css">
  <!-- Page level plugin styles END -->

	<!-- Page level plugin styles -->
  <link href="/frontend/pages/css/style-shop.css" rel="stylesheet" type="text/css">

  <!-- Theme styles START -->
  <link href="/global/css/components.css" rel="stylesheet">
  <link href="/frontend/layout/css/style.css" rel="stylesheet">
  <link href="/frontend/pages/css/style-shop.css" rel="stylesheet" type="text/css">
  <link href="/frontend/pages/css/style-revolution-slider.css" rel="stylesheet"><!-- metronic revo slider styles -->
  <link href="/frontend/layout/css/style-responsive.css" rel="stylesheet">
  <link href="/frontend/layout/css/themes/red.css" rel="stylesheet" id="style-color">
  <link href="/frontend/layout/css/custom.css" rel="stylesheet">
  <!-- Theme styles END -->


<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<style>
.flash-message {
    position: fixed; /* Vị trí cố định trên màn hình */
    top: 50%; /* Căn giữa theo trục dọc */
    left: 50%; /* Căn giữa theo trục ngang */
    transform: translate(-50%, -50%); /* Đẩy về trung tâm */
    z-index: 1050; /* Hiển thị trên các thành phần khác */
    width: 60%; /* Chiều ngang của thông báo */
    max-width: 600px; /* Giới hạn chiều ngang tối đa */
    padding: 20px; /* Khoảng cách bên trong */
    text-align: center; /* Căn giữa nội dung */
    background-color: rgba(255, 255, 255, 0.9); /* Nền trắng mờ */
    border-radius: 10px; /* Bo góc */
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2); /* Đổ bóng */
    font-size: 1.5rem; /* Kích thước chữ */
    animation: fade-in-out 2s forwards; /* Hiệu ứng xuất hiện và biến mất */
}

.alert {
    margin: 0; /* Đảm bảo không có khoảng cách thừa */
    padding: 20px; /* Khoảng cách bên trong thông báo */
}

@keyframes fade-in-out {
    0% {
        opacity: 0;
        transform: translate(-50%, calc(-50% - 20px)); /* Xuất hiện từ trên */
    }
    10% {
        opacity: 1;
        transform: translate(-50%, -50%); /* Giữ vị trí chính giữa */
    }
    90% {
        opacity: 1;
    }
    100% {
        opacity: 0;
        transform: translate(-50%, calc(-50% - 20px)); /* Biến mất lên trên */
    }
}






/* Spinner Group Styles */
.spinner {
    width: 120px; /* Giới hạn chiều rộng */
    display: inline-flex;
    align-items: center;
}

.spinner .btn {
    width: 30px; /* Giới hạn kích thước nút */
    height: 30px;
    line-height: 1; /* Căn chỉnh nội dung */
    padding: 0;
    font-size: 14px; /* Kích thước chữ nhỏ */
    border-radius: 0; /* Xóa bo góc nếu cần */
}

.spinner input {
    width: 50px; /* Kích thước của input */
    height: 30px;
    text-align: center;
    font-size: 14px; /* Chữ vừa phải */
    padding: 0;
    margin: 0;
    border: 1px solid #ccc; /* Viền mỏng */
    border-left: none; /* Xóa viền giữa nút trái */
    border-right: none; /* Xóa viền giữa nút phải */
}

.spinner input:focus {
    outline: none; /* Xóa đường viền focus */
    box-shadow: none; /* Xóa hiệu ứng shadow khi focus */
}

.spinner .btn:first-child {
    border-top-left-radius: 4px; /* Bo góc trái */
    border-bottom-left-radius: 4px;
}

.spinner .btn:last-child {
    border-top-right-radius: 4px; /* Bo góc phải */
    border-bottom-right-radius: 4px;
}

</style>



</head>
<!-- Head END -->
<body class="ecommerce">
	
    <%@include file="/common/header.jsp"%>
    
	<sitemesh:write property="body" />
	
	<div>
		<%@include file="/common/footer.jsp"%>
	</div>
	
	<script src="/frontend/pages/scripts/checkout.js" type="text/javascript"></script>

	
	<script>
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
</script>

	

	<script src="/global/plugins/jquery.min.js" type="text/javascript"></script>
    <script src="/global/plugins/jquery-migrate.min.js" type="text/javascript"></script>
    <script src="/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>      
    <script src="/frontend/layout/scripts/back-to-top.js" type="text/javascript"></script>
    <script src="/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
    <!-- END CORE PLUGINS -->

    <!-- BEGIN PAGE LEVEL JAVASCRIPTS (REQUIRED ONLY FOR CURRENT PAGE) -->
    <script src="/global/plugins/fancybox/source/jquery.fancybox.pack.js" type="text/javascript"></script>pop up
    <script src="/global/plugins/carousel-owl-carousel/owl-carousel/owl.carousel.min.js" type="text/javascript"></script><!-- slider for products -->
    <script src='/global/plugins/zoom/jquery.zoom.min.js' type="text/javascript"></script><!-- product zoom -->
    <script src="/global/plugins/bootstrap-touchspin/bootstrap.touchspin.js" type="text/javascript"></script><!-- Quantity -->
    <script src="/global/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>
    <script src="/global/plugins/rateit/src/jquery.rateit.js" type="text/javascript"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js" type="text/javascript"></script><!-- for slider-range -->

    <script src="/frontend/layout/scripts/layout.js" type="text/javascript"></script>
    
    <script type="text/javascript">
        jQuery(document).ready(function() {
            /* Layout.init(); */    
            Layout.initOWL();
            Layout.initTwitter();
            Layout.initImageZoom();
            Layout.initTouchspin();
            Layout.initUniform();
            Layout.initSliderRange();
        });
    </script>
</body>
</html>