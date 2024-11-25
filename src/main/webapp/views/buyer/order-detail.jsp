<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<div class="container">
    <div class="card">
        <div class="card-header">
            <h3>Chi tiết đơn hàng #${order.orderId}</h3>
        </div>
        <div class="card-body">
            <div class="row mb-3">
                <div class="col-md-6">
                    <p>
                        <strong>Ngày đặt:</strong>
                        <span>${order.orderAt}</span>
                    </p>
                    <p>
                        <strong>Trạng thái:</strong>
                        <span>${order.status}</span>
                    </p>
                    <p>
                        <strong>Phương thức thanh toán:</strong>
                        <span>${order.paymentMethod}</span>
                    </p>
                </div>
                <div class="col-md-6">
                    <p>
                        <strong>Người đặt:</strong>
                        <span>${order.buyer.username}</span>
                    </p>
                    <p>
                        <strong>Số điện thoại:</strong>
                        <span>${order.buyer.phoneNumber}</span>
                    </p>
                    <p>
                        <strong>Email:</strong>
                        <span>${order.buyer.email}</span>
                    </p>
                </div>
            </div>

            <table class="table">
                <thead>
                    <tr>
                        <th>Sản phẩm</th>
                        <th>Số lượng</th>
                        <th>Đơn giá</th>
                        <th>Thành tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${order.items}">
                        <tr>
                            <td>${item.product.name}</td>
                            <td>${item.quantity}</td>
                            <td><fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫"/></td>
                            <td><fmt:formatNumber value="${item.price * item.quantity}" type="currency" currencySymbol="₫"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="3" class="text-end"><strong>Tổng cộng:</strong></td>
                        <td><fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫"/></td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>
</div>