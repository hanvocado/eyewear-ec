<!-- order-history.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

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
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${orders}" var="order">
                    <tr>
                        <td>${order.orderId}</td>
                        <td>${order.orderAt}</td>
                        <td>
                            <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫"/>
                        </td>
                        <td>${order.status}</td>
                        <td>
                            <a href="<c:url value='/buyer/orders/${order.orderId}'/>" 
                               class="btn btn-primary btn-sm">Xem chi tiết</a>
                            
                            <c:if test="${order.status == 'Đã giao' && !proreviewed.contains(order.orderId)}">
                                <a href="<c:url value='/buyer/reviews/add/${order.orderId}'/>"
                                   class="btn btn-success btn-sm">Đánh giá</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>