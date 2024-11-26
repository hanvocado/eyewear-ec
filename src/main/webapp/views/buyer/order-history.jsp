
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<%-- Hiển thị thông báo nếu có --%>
<c:if test="${not empty message}">
    <script>
        alert("${message}");
    </script>
</c:if>

<div class="container">

    <h2>Lịch sử mua hàng</h2>
    <div class="table-responsive">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Mã đơn hàng</th>
                    <th>Ngày đặt</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                    <th></th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${orders}" var="order">
                    <tr>
                        <td>${order.orderId}</td>
                        <td>${order.orderAt}</td>
                        <td>
                            <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="VND"/>
                        </td>
                        <td>${order.status}</td>
                        <td>
                            <a href="<c:url value='/buyer/orders/${order.orderId}'/>" 
                               class="btn btn-primary btn-sm">Xem chi tiết</a>
                        </td>
                        <td>
    						<c:if test="${order.status.toLowerCase() != 'done' && order.status.toLowerCase()!='canceled'}">
        						<a href="<c:url value='/order/cancel/${order.orderId}'/>" 
           							class="btn btn-primary btn-sm">Huỷ Đơn</a>
    						</c:if>
						</td>
						

                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
