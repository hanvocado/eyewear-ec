 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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

</head>
<!-- Head END -->
<body class="ecommerce">
	
    <%@include file="/common/header.jsp"%>
    
	<sitemesh:write property="body" />
	
	<div>
		<%@include file="/common/footer.jsp"%>
	</div>
	<script src="/frontend/pages/scripts/checkout.js" type="text/javascript"></script>
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