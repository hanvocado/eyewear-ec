
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<c:if test="${not empty message}">
    <script>
        Swal.fire({
            title: 'Thông báo',
            text: "${message}",
            icon: 'success', // Kiểu icon: success, error, warning, info, question
            confirmButtonText: 'OK'
        });
    </script>
</c:if>

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
                    <th></th>
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
                        </td>
                        <td>
    						<c:if test="${order.status.toLowerCase() != 'done' && order.status.toLowerCase() != 'canceled'}">
    							<button class="btn btn-primary btn-sm" onclick="confirmCancel('${order.orderId}')">Huỷ Đơn</button>
    							
							</c:if>

						</td>
						

                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
   <script>
    function confirmCancel(orderId) {
        Swal.fire({
            title: 'Xác nhận hủy đơn',
            text: 'Bạn có chắc chắn muốn hủy đơn hàng này không?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Có',
            cancelButtonText: 'Không'
        }).then((result) => {
            if (result.isConfirmed) {
                
                window.location.href = '/buyer/orders/cancel/' + orderId;
            }
        });
    }
</script>
</div>
