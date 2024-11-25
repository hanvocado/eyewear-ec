<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>




<form action="/order/checkout" method="get">
    <table>
        <tr>
            <th class="checkout-image">Image</th>
            <th class="checkout-description">Description</th>
            <th class="checkout-price">Price</th>
            <th>Select</th>
            
        </tr>
         <input type="text" name="buyerId" >
        <c:forEach items="${list}" var="i">
      
            <tr>
                <td class="checkout-image">
                    <a href="#"><img src="${i.image}" alt="Product Image"></a>
                </td>
                <td class="checkout-description">
                    <h3><a href="#"></a></h3>
                    <p><strong>${i.description}</strong></p>
                    <em></em>
                </td>
                <td class="checkout-price">
                    <strong>${i.price}<span> VND</span></strong>
                </td>
                <td>
                    <!-- Checkbox for selecting the product --->
                    <input type="checkbox" name="selectedProducts" value="${i.id}">
                </td>
            </tr>
        </c:forEach>
    </table>
    <button type="submit">Submit</button>
</form>


<form action="/reviews/editReview" method="get">
	<input type="text" name="buyerId" ></input>
	<input type="text" name="productId" ></input>
	<button type="submit">submit</button>
</form> 


<form action="/order/cancelOrder">
<div class="container">
    <h2>Đơn hàng của tôi</h2>
    <div class="table-responsive">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Mã đơn hàng</th>
                    <th>Ngày đặt</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="order" items="${orders}">
                    <tr>
                        <td>${order.orderId}</td>
                       
                        <td><fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫"/></td>
                        <td>${order.status}</td>
                        <td>
                            <a href="<c:url value='/order/cancel/${order.orderId}'/>" 
                               class="btn btn-primary btn-sm">huỷ đơn</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</form>