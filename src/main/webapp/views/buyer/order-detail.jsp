<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

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
                        <span><fmt:formatDate value="${order.orderAt}" pattern="dd/MM/yyyy HH:mm"/></span>
                    </p>
                    <p>
                        <strong>Trạng thái:</strong>
                        <span>${order.status}</span>
                    </p>
                </div>
                <div class="col-md-6">
                    <p>
                        <strong>Địa chỉ giao hàng:</strong>
                        <span>${order.shippingAddress}</span>
                    </p>
                    <p>
                        <strong>Số điện thoại:</strong>
                        <span>${order.phone}</span>
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