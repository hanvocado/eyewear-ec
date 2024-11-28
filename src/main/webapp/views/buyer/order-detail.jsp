
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ page import="com.eyewear.utils.Tested"%>

<div class="container">
	<div class="card">
		<div class="card-header">
			<h3>Chi tiết đơn hàng #${order.orderId}</h3>

		</div>
		<div class="card-body">
			<div class="row mb-3">
				<div class="col-md-6">
					<p>
						<strong>Ngày đặt:</strong> <span>${order.orderAt}</span>
					</p>
					<p>
						<strong>Trạng thái:</strong> <span>${order.status}</span>
					</p>
					<p>
						<strong>Phương thức thanh toán:</strong> <span>${order.paymentMethod}</span>
					</p>
				</div>
				<div class="col-md-6">
					<p>
						<strong>Người đặt:</strong> <span>${order.buyer.username}</span>
					</p>
					<p>
						<strong>Số điện thoại:</strong> <span>${order.buyer.phoneNumber}</span>
					</p>
					<p>
						<strong>Email:</strong> <span>${order.buyer.email}</span>
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
						<th></th>

					</tr>
				</thead>
				<tbody>
					<c:forEach var="item" items="${order.items}">
						<tr>
							<td>${item.product.name}</td>
							<td>${item.quantity}</td>
							<td><fmt:formatNumber value="${item.price}" type="currency"
									currencySymbol="₫" /></td>
							<td><fmt:formatNumber value="${item.price * item.quantity}"
									type="currency" currencySymbol="₫" /></td>
							<td>
								<form action="/buyer/reviews" method="get">
									<input type="hidden" name="orderId" value="${order.orderId }">
									<input type="hidden" name="buyerId" value="${order.buyer.id}">
									<input type="hidden" name="productId"
										value="${item.product.id}">
									<c:if test="${order.status.toLowerCase() == 'done'}">
										<c:if test="${fn:contains(proreviewed, item.product.id)}">
											<button type="submit" class="btn btn-primary btn-sm">Sửa
												đánh giá</button>
										</c:if>
										<c:if test="${not fn:contains(proreviewed, item.product.id)}">
											<button type="submit" class="btn btn-primary btn-sm">Đánh
												giá</button>
										</c:if>

									</c:if>

								</form>


							</td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="3" class="text-end"><strong>Tổng cộng:</strong></td>
						<td><fmt:formatNumber value="${order.totalPrice}"
								type="currency" currencySymbol="₫" /></td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
</div>
