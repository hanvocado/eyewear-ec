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
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
  <!-- Theme styles END -->
  

<!-- BEGIN PAGE LEVEL STYLES -->
<link rel="stylesheet" type="text/css" href="/global/plugins/clockface/css/clockface.css"/>
<link rel="stylesheet" type="text/css" href="/global/plugins/bootstrap-datepicker/css/datepicker3.css"/>
<link rel="stylesheet" type="text/css" href="/global/plugins/bootstrap-timepicker/css/bootstrap-timepicker.min.css"/>
<link rel="stylesheet" type="text/css" href="/global/plugins/bootstrap-colorpicker/css/colorpicker.css"/>
<link rel="stylesheet" type="text/css" href="/global/plugins/bootstrap-daterangepicker/daterangepicker-bs3.css"/>
<link rel="stylesheet" type="text/css" href="/global/plugins/bootstrap-datetimepicker/css/bootstrap-datetimepicker.min.css"/>
<!-- END PAGE LEVEL STYLES -->
<!-- BEGIN THEME STYLES -->
<link href="/global/css/components-rounded.css" id="style_components" rel="stylesheet" type="text/css">
<link href="/global/css/plugins.css" rel="stylesheet" type="text/css">
<link href="/admin/layout3/css/layout.css" rel="stylesheet" type="text/css">
<link href="/admin/layout3/css/themes/default.css" rel="stylesheet" type="text/css" id="style_color">
<link href="/admin/layout3/css/custom.css" rel="stylesheet" type="text/css">
<!-- END THEME STYLES -->
<link rel="shortcut icon" href="favicon.ico"/>

<!-- <!-- Bootstrap CSS -->

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
<script src="/frontend/layout/scripts/back-to-top.js" type="text/javascript"></script>
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js" type="text/javascript"></script><!-- for slider-range -->
<script src="/frontend/layout/scripts/layout.js" type="text/javascript"></script>
	
<script src="/global/plugins/jquery.min.js" type="text/javascript"></script>
<script src="/global/plugins/jquery-migrate.min.js" type="text/javascript"></script>
<script src="/global/plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
<script src="/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="/global/plugins/jquery.cokie.min.js" type="text/javascript"></script>
<script src="/global/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script>

<!-- Load các plugin cần thiết -->
<script src="/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
<script src="/global/plugins/bootstrap-timepicker/js/bootstrap-timepicker.min.js"></script>
<script src="/global/plugins/clockface/js/clockface.js"></script>
<script src="/global/plugins/bootstrap-daterangepicker/moment.min.js"></script>
<script src="/global/plugins/bootstrap-daterangepicker/daterangepicker.js"></script>
<script src="/global/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker.js"></script>
<script src="/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min.js"></script>

<!-- Metronic và các script liên quan -->
<script src="/global/scripts/metronic.js" type="text/javascript"></script>
<script src="/admin/layout3/scripts/layout.js" type="text/javascript"></script>
<script src="/admin/layout3/scripts/demo.js" type="text/javascript"></script>
<script src="/admin/pages/scripts/components-pickers.js"></script>

<!-- Các script khác -->
<script src="/global/plugins/fancybox/source/jquery.fancybox.pack.js" type="text/javascript"></script>
<script src="/global/plugins/carousel-owl-carousel/owl-carousel/owl.carousel.min.js" type="text/javascript"></script>
<script src="/global/plugins/zoom/jquery.zoom.min.js" type="text/javascript"></script>
<script src="/global/plugins/bootstrap-touchspin/bootstrap.touchspin.js" type="text/javascript"></script>
<script src="/global/plugins/rateit/src/jquery.rateit.js" type="text/javascript"></script>

<!-- Khởi tạo -->
<script type="text/javascript">
    jQuery(document).ready(function () {
        Metronic.init(); 
        Layout.init(); 
        Demo.init(); 
        ComponentsPickers.init(); 
        Layout.initOWL(); 
        Layout.initTwitter();
        Layout.initImageZoom(); 
        Layout.initTouchspin(); 
        Layout.initUniform(); 
        Layout.initSliderRange(); 
    });
</script>
<script>
    // Khi người dùng thay đổi giá trị, kiểm tra và loại bỏ ".0" nếu có
    document.addEventListener('input', function(e) {
        if (e.target.id === 'minPrice' || e.target.id === 'maxPrice') {
            var value = e.target.value;
            
            // Chuyển đổi thành số nguyên nếu có phần thập phân là 0
            if (value.indexOf('.') !== -1 && value.split('.')[1] === '0') {
                e.target.value = value.split('.')[0];
            }
        }
    });

    // Đảm bảo hiển thị giá trị mà không có phần ".0"
    function formatValue(value) {
        // Nếu giá trị là một số nguyên, chỉ hiển thị số nguyên
        if (value.indexOf('.') !== -1 && value.split('.')[1] === '0') {
            return value.split('.')[0];
        }
        return value;
    }

    // Chỉnh sửa các giá trị khi tải trang hoặc khi giá trị thay đổi
    window.onload = function() {
        var minPriceInput = document.getElementById('minPrice');
        var maxPriceInput = document.getElementById('maxPrice');
        
        // Làm tròn và loại bỏ phần ".0" trong giá trị nhập ban đầu
        minPriceInput.value = formatValue(minPriceInput.value);
        maxPriceInput.value = formatValue(maxPriceInput.value);
    };
</script>

</body>
</html>