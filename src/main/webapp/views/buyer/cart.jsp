<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<div class="main">
    <div class="container">
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40">
            <!-- BEGIN CONTENT -->
            <div class="col-md-12 col-sm-12">
                <h1>Shopping cart</h1>
                <div class="goods-page">
                    <form action="/buyer/orders/checkout" method="get" id="checkoutForm">
                        <div class="goods-data clearfix">
                            <div class="table-wrapper-responsive">
                                <table summary="Shopping cart">
                                    <tr>
                                        <th></th>
                                        <th class="goods-page-image">Image</th>
                                        <th class="goods-page-description">Name</th>
                                        <th class="goods-page-ref-no">Description</th>
                                        <th class="goods-page-quantity">Quantity</th>
                                        <th class="goods-page-price">Unit price</th>
                                        <th class="goods-page-total" colspan="2">Total</th>
                                    </tr>
                                    <c:forEach var="cartItem" items="${listCartItem}">
                                        <tr>
                                            <td>
                                                <input type="checkbox" class="select-cart-item" name="listCartIemId" value="${cartItem.id}" onchange="updateTotalPrice()">
                                            </td>
                                            <td class="goods-page-image"><a href="#"><img src="${cartItem.product.image}" alt="Berry Lace Dress"></a></td>
                                            <td class="goods-page-description">
                                                <h3><a href="#">${cartItem.product.name}</a></h3>
                                                <p><strong>${cartItem.product.category.name}</strong> ${cartItem.product.brand}</p>
                                                <em>${cartItem.product.description}</em>
                                            </td>
                                            <td class="goods-page-ref-no">${cartItem.product.brand}</td>
                                            <td class="goods-page-quantity">
                                                <input id="product-quantity-${cartItem.id}" type="number" 
       													class="form-control text-center input-sm" 
       													value="${cartItem.quantity}" 
       													onchange="updateQuantity(${cartItem.id}, this.value)"
       													 style="width: 70px; height: 30px;">
                                            </td>
                                            <td class="goods-page-price"><strong><span>₫</span>${cartItem.product.price}</strong></td>
                                            <td class="goods-page-total"><strong><span>₫</span><span id="total-${cartItem.id}">${cartItem.product.price * cartItem.quantity}</span></strong></td>
                                            <td class="del-goods-col"><a class="del-goods" href="${pageContext.request.contextPath}/buyer/cart/deleteCartItem?cartItemID=${cartItem.id}">&nbsp;</a></td>
                                        </tr>
                                    </c:forEach>
                                </table>
                            </div>
                            
                            <div class="shopping-total">
                                <ul>
                                    <li><em>Sub total</em> <strong class="price"><span>₫</span><span id="subTotal">0.00</span></strong></li>
                                    <li><em>Shipping cost</em> <strong class="price"><span>₫</span>3.00</strong></li>
                                    <li class="shopping-total-price"><em>Total</em> <strong class="price"><span>₫</span><span id="totalPrice">${totalPrice + 3}</span></strong></li>
                                </ul>
                            </div>
                        </div>
                    
                        <button class="btn btn-primary" type="button" onclick="checkSelectedItems()">
                            Checkout <i class="fa fa-check"></i>
                        </button>
                    </form>
                    
                    <button class="btn btn-default" type="submit">
                        Continue shopping <i class="fa fa-shopping-cart"></i>
                    </button>
                </div>
            </div>
            <!-- END CONTENT -->
        </div>
        <!-- END SIDEBAR & CONTENT -->
    </div>
</div>

