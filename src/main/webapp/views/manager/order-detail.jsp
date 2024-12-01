
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ page import="com.eyewear.utils.Tested"%>


<body>
    <div class="container py-4">
        <div class="card order-card">
            <div class="card-header order-header p-4">
                <div class="d-flex justify-content-between align-items-center">
                    <h3 class="mb-0">Đơn hàng #${order.orderId}</h3>
                    <span class="order-status status-${order.status.toLowerCase()}">${order.status}</span>
                </div>
            </div>
            <div class="card-body p-4">
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <h5 class="text-muted mb-3">Thông tin đơn hàng</h5>
                            <p class="mb-2">
                                <i class="bi bi-calendar3"></i>
                                <strong>Ngày đặt:</strong> <span>${order.orderAt}</span>
                            </p>
                            <p class="mb-2">
                                <i class="bi bi-credit-card"></i>
                                <strong>Thanh toán:</strong> <span>${order.paymentMethod}</span>
                            </p>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <h5 class="text-muted mb-3">Thông tin khách hàng</h5>
                            <p class="mb-2">
                                <i class="bi bi-person"></i>
                                <strong>Người đặt:</strong> <span>${order.buyer.username}</span>
                            </p>
                            <p class="mb-2">
                                <i class="bi bi-telephone"></i>
                                <strong>SĐT:</strong> <span>${order.buyer.phoneNumber}</span>
                            </p>
                            <p class="mb-2">
                                <i class="bi bi-envelope"></i>
                                <strong>Email:</strong> <span>${order.buyer.email}</span>
                            </p>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table align-middle">
                        <thead class="table-light">
                            <tr>
                                <th>Sản phẩm</th>
                                <th class="text-center">Số lượng</th>
                                <th class="text-end">Đơn giá</th>
                                <th class="text-end">Thành tiền</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${order.items}">
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img src="${item.product.image}" alt="${item.product.name}" class="product-image me-3">
                                            <span>${item.product.name}</span>
                                        </div>
                                    </td>
                                    <td class="text-center">${item.quantity}</td>
                                    <td class="text-end">
                                        <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫" />
                                    </td>
                                    <td class="text-end">
                                        <fmt:formatNumber value="${item.price * item.quantity}" type="currency" currencySymbol="₫" />
                                    </td>
                                    <td class="text-end">
                                        <form action="/buyer/reviews" method="get">
                                            <input type="hidden" name="orderId" value="${order.orderId}">
                                            <input type="hidden" name="buyerId" value="${order.buyer.id}">
                                            <input type="hidden" name="productId" value="${item.product.id}">
                                            <c:if test="${order.status.toLowerCase() == 'done'}">
                                                <c:if test="${fn:contains(proreviewed, item.product.id)}">
                                                    <button type="submit" class="btn btn-outline-primary btn-sm review-btn">
                                                        <i class="bi bi-pencil"></i> Sửa đánh giá
                                                    </button>
                                                </c:if>
                                                <c:if test="${not fn:contains(proreviewed, item.product.id)}">
                                                    <button type="submit" class="btn btn-primary btn-sm review-btn">
                                                        <i class="bi bi-star"></i> Đánh giá
                                                    </button>
                                                </c:if>
                                            </c:if>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr class="fw-bold">
                                <td colspan="3" class="text-end">Tổng cộng:</td>
                                <td class="text-end">
                                    <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫" />
                                </td>
                                <td></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.11.1/font/bootstrap-icons.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</body>
</html>