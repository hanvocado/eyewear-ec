<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<div class="container">
	<h2>Quản lý đơn hàng</h2>

	<!-- Thông báo -->
	<c:if test="${not empty successMessage}">
		<div class="alert alert-success">${successMessage}</div>
	</c:if>
	<c:if test="${not empty errorMessage}">
		<div class="alert alert-danger">${errorMessage}</div>
	</c:if>

	<!-- Form cập nhật hàng loạt -->
	<form id="bulkUpdateForm"
		action="<c:url value='/manager/orders/bulk-update'/>" method="post">
		<div class="mb-3">
			<button type="button" class="btn btn-primary" id="bulkUpdateBtn"
				disabled>Cập nhật trạng thái</button>
			<select name="newStatus"
				class="form-select d-inline-block w-auto ms-2">
				<option value="Đã xác nhận">Đã xác nhận</option>
				<option value="Đang giao">Đang giao</option>
				<option value="Đã giao">Đã giao</option>
			</select>
		</div>

		<!-- Bảng đơn hàng -->
		<div class="table-responsive">
			<table class="table">
				<thead>
					<tr>
						<th><input type="checkbox" id="selectAll"></th>
						<th>Mã đơn</th>
						<th>Ngày đặt</th>
						<th>Khách hàng</th>
						<th>Tổng tiền</th>
						<th>Trạng thái</th>
						<th>Thao tác</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${orders}" var="order">
						<tr>
							<td><input type="checkbox" name="orderIds[]"
								value="${order.orderId}" class="orderCheckbox"></td>
							<td>${order.orderId}</td>
							<td>${order.orderAt}</td>
							<td>${order.buyer.username}</td>
							<td><fmt:formatNumber value="${order.totalPrice}"
									type="currency" /></td>
							<td>${order.status}</td>
							<td>
								<form
									action="<c:url value='/manager/orders/update-status/${order.orderId}'/>"
									method="post" class="d-inline">
									<select name="newStatus" class="form-select d-inline w-auto">
										<option value="Đã xác nhận">Đã xác nhận</option>
										<option value="Đang giao">Đang giao</option>
										<option value="Đã giao">Đã giao</option>
									</select>
									<button type="submit" class="btn btn-primary btn-sm"
										onclick="return confirm('Bạn chắc chắn muốn cập nhật trạng thái?')">
										Cập nhật</button>
								</form>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</form>
</div>

<script>
	$(document)
			.ready(
					function() {
						// Xử lý checkbox "Chọn tất cả"
						$('#selectAll').change(
								function() {
									$('.orderCheckbox').prop('checked',
											$(this).is(':checked'));
									updateBulkUpdateButton();
								});

						// Xử lý các checkbox đơn lẻ
						$('.orderCheckbox').change(function() {
							updateBulkUpdateButton();
						});

						// Cập nhật trạng thái nút cập nhật hàng loạt
						function updateBulkUpdateButton() {
							var checkedBoxes = $('.orderCheckbox:checked').length;
							$('#bulkUpdateBtn').prop('disabled',
									checkedBoxes === 0);
						}

						// Xử lý nút cập nhật hàng loạt
						$('#bulkUpdateBtn')
								.click(
										function() {
											if (confirm('Bạn chắc chắn muốn cập nhật trạng thái các đơn hàng đã chọn?')) {
												$('#bulkUpdateForm').submit();
											}
										});
					});
</script>