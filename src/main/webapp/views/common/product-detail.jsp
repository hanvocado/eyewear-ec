<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

    <meta charset="UTF-8">
    <title>Chi tiết sản phẩm</title>

<body>
    <div class="main">
        <div class="container">
            <ul class="breadcrumb">
                <li><a href="index.html">Home</a></li>
                <li><a href="#">Store</a></li>
                <li class="active">${product.name}</li>
            </ul>

            <div class="row margin-bottom-40">
                <!-- BEGIN SIDEBAR -->
                <div class="sidebar col-md-3 col-sm-5">
                    <ul class="list-group margin-bottom-25 sidebar-menu">
                        <!-- Sidebar content -->
                    </ul>
                </div>
                <!-- END SIDEBAR -->

                <!-- BEGIN CONTENT -->
                <div class="col-md-9 col-sm-7">
                    <div class="product-page">
                        <div class="row">
                            <div class="col-md-6 col-sm-6">
                                <div class="product-main-image">
                                    <img src="${product.imageUrl}" alt="${product.name}"
                                         class="img-responsive" data-BigImgsrc="${product.imageUrl}">
                                </div>
                                <div class="product-other-images">
                                    <a href="/assets/frontend/pages/img/products/model3.jpg" class="fancybox-button" rel="photos-lib">
                                        <img alt="Berry Lace Dress" src="/assets/frontend/pages/img/products/model3.jpg">
                                    </a>
                                    <!-- More images -->
                                </div>
                            </div>
                            <div class="col-md-6 col-sm-6">
                                <h1>${product.name}</h1>
                                <div class="price-availability-block clearfix">
                                    <div class="price">
                                        <strong><span>
                                            <fmt:formatNumber value="${product.price}" type="number" minFractionDigits="0" maxFractionDigits="1"/>
                                        </span></strong>
                                    </div>
                                    <div class="availability">
                                        Thương hiệu: <strong>${product.brand}</strong>
                                    </div>
                                </div>
                                <div class="description">
                                    <p>${product.description}</p>
                                </div>
                                <div class="product-page-options">
                                    <div class="pull-left">
                                        <label class="control-label">Size:</label>
                                        <select class="form-control input-sm">
                                            <option>L</option>
                                            <option>M</option>
                                            <option>XL</option>
                                        </select>
                                    </div>
                                    <div class="pull-left">
                                        <label class="control-label">Color:</label>
                                        <select class="form-control input-sm">
                                            <option>Red</option>
                                            <option>Blue</option>
                                            <option>Black</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="product-page-cart">
                                    <div class="product-quantity">
                                        <input id="product-quantity" type="text" value="1" readonly class="form-control input-sm">
                                    </div>
                                    <button class="btn btn-primary" type="submit">Add to cart</button>
                                </div>

                                <div class="review">
                                    <input type="range" value="4" step="0.25" id="backing4">
                                    <div class="rateit" data-rateit-backingfld="#backing4" data-rateit-resetable="false" data-rateit-ispreset="true" data-rateit-min="0" data-rateit-max="5"></div>
                                    <a href="#">7 reviews</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">Write a review</a>
                                </div>

                                <!-- Social sharing -->
                                <div class="social-icons">
                                    <ul>
                                        <li><a class="facebook" href="javascript:void(0);" onclick="shareOnFacebook()"> <i class="fab fa-facebook-f"></i> </a></li>
                                        <li><a class="messenger" href="https://m.me/?text=http://localhost:8080/common/products/detail/${product.id}" target="_blank"> <i class="fab fa-facebook-messenger"></i> </a></li>
                                        <li><a class="instagram" href="https://www.instagram.com/" target="_blank"> <i class="fab fa-instagram"></i> </a></li>
                                    </ul>
                                </div>
                            </div>

                            <!-- Product Description and Reviews -->
                            <div class="product-page-content">
                                <ul id="myTab" class="nav nav-tabs">
                                    <li><a href="#Description" data-toggle="tab">Mô tả</a></li>
                                    <li><a href="#Information" data-toggle="tab">Thông tin sản phẩm</a></li>
                                    <li class="active"><a href="#Reviews" data-toggle="tab">Đánh giá (${countReview})</a></li>
                                </ul>
                                <div id="myTabContent" class="tab-content">
                                    <div class="tab-pane fade" id="Description">
                                        <p>${product.description}</p>
                                    </div>
                                    <div class="tab-pane fade" id="Information">
                                        <table class="datasheet">
                                            <tr>
                                                <th colspan="2">Thông số sản phẩm</th>
                                            </tr>
                                            <tr>
                                                <td>Danh mục</td>
                                                <td>${product.category.name}</td>
                                            </tr>
                                            <tr>
                                                <td>Thương hiệu</td>
                                                <td>${product.brand}</td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="tab-pane fade in active" id="Reviews">
                                        <c:forEach var="review" items="${reviews}">
                                            <div class="review-item clearfix">
                                                <div class="review-item-submitted">
                                                    <strong>${review.buyer.name}</strong> <em>${review.reviewDate}</em>
                                                    <div class="rateit" data-rateit-value="${review.rating}" data-rateit-ispreset="true" data-rateit-readonly="true"></div>
                                                </div>
                                                <div class="review-item-content">
                                                    <p>${review.reviewContent}</p>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>

                            <div class="sticker sticker-sale"></div>
                        </div>
                    </div>
                </div>
                <!-- END CONTENT -->
            </div>

            <!-- BEGIN SIMILAR PRODUCTS -->
            <div class="row margin-bottom-40">
                <div class="col-md-12 col-sm-12">
                    <h2>Sản phẩm tương tự</h2>
                    <div class="owl-carousel owl-carousel4">
                        <c:forEach var="similarProduct" items="${similarProducts}">
                            <div>
                                <div class="product-item">
                                    <div class="pi-img-wrapper">
                                        <img src="${similarProduct.imageUrl}" class="img-responsive" alt="${similarProduct.name}">
                                        <div>
                                            <a href="${similarProduct.imageUrl}" class="btn btn-default fancybox-button">Zoom</a>
                                            <a href="/common/products/detail/${similarProduct.id}" class="btn btn-default fancybox-fast-view">View</a>
                                        </div>
                                    </div>
                                    <h3><a href="/common/products/detail/${similarProduct.id}">${similarProduct.name}</a></h3>
                                    <div class="pi-price">
                                        <fmt:formatNumber value="${similarProduct.price}" type="number" />
                                    </div>
                                    <a href="/cart/add/${similarProduct.id}" class="btn btn-default add2cart">Add to cart</a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <!-- END SIMILAR PRODUCTS -->
        </div>
    </div>

    <!-- Load the Facebook SDK for JavaScript -->
    <div id="fb-root"></div>
    <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js"></script>
    <script>
        window.fbAsyncInit = function() {
            FB.init({
                appId      : '492624269865314',
                xfbml      : true,
                version    : 'v21.0'
            });
            FB.AppEvents.logPageView();
        };
    </script>
    <script>
    function shareOnFacebook() {
        FB.ui({
            method: 'share',
            href: 'http://localhost:8080/common/products/detail/<c:out value="${product.id}" />',
        }, function(response) {
            if (response && !response.error_message) {
                alert('Sharing succeeded.');
            } else {
                alert('Error while sharing.');
            }
        });
    }
</script>

</body>