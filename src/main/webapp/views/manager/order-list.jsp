<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<div class="container">
	<h2>Quản lý đơn hàng</h2>

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
			<button type="submit" class="btn btn-primary" id="bulkUpdateBtn"
				disabled>Cập nhật trạng thái</button>
			<select name="bulkStatus"
				class="form-select d-inline-block w-auto ms-2">
				<option value="Đã xác nhận">Đã xác nhận</option>
				<option value="Đang giao">Đang giao</option>
				<option value="Đã giao">Đã giao</option>
			</select>
		</div>
	</form>

	<!-- Bảng đơn hàng -->
	<div class="table-responsive">
		<table class="table">
			<thead>
				<tr>
					<th>
						<div class="form-check">
							<input type="checkbox" class="form-check-input" id="selectAll">
							<label class="form-check-label" for="selectAll">Chọn tất
								cả</label>
						</div>
					</th>
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
						<td>
							<div class="form-check">
								<input type="checkbox" class="form-check-input orderCheckbox"
									form="bulkUpdateForm" name="orderIds" value="${order.orderId}">
							</div>
						</td>
						<td>${order.orderId}</td>
						<td><c:set var="dateFormatter"
								value='<%=java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")%>' />
							${order.orderAt.format(dateFormatter)}</td>
						<td>${order.buyer.username}</td>
						<td><fmt:formatNumber value="${order.totalPrice}"
								type="currency" /></td>
						<td>${order.status}</td>
						<td>
							<form
								action="<c:url value='/manager/orders/update-status/${order.orderId}'/>"
								method="post" class="d-inline">
								<select name="newStatus" class="form-select d-inline w-auto">
									<option value="Đã xác nhận"
										${order.status == 'Đã xác nhận' ? 'selected' : ''}>
										Đã xác nhận</option>
									<option value="Đang giao"
										${order.status == 'Đang giao' ? 'selected' : ''}>
										Đang giao</option>
									<option value="Đã giao"
										${order.status == 'Đã giao' ? 'selected' : ''}>Đã
										giao</option>
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

	<!-- Phân trang -->
	<div class="d-flex justify-content-center mt-3">
		<nav aria-label="Page navigation">
			<ul class="pagination d-flex flex-row flex-wrap mb-0">
				<li class="page-item ${pageNumber == 0 ? 'disabled' : ''}"><a
					class="page-link" href="?page=0">&laquo;</a></li>
				<li class="page-item ${pageNumber == 0 ? 'disabled' : ''}"><a
					class="page-link" href="?page=${Math.max(0, pageNumber - 1)}">Trước</a>
				</li>

				<c:if test="${totalPages > 0}">
					<c:forEach begin="${Math.max(0, pageNumber - 2)}"
						end="${Math.min(totalPages - 1, pageNumber + 2)}" var="i">
						<li class="page-item ${pageNumber == i ? 'active' : ''}"><a
							class="page-link" href="?page=${i}">${i + 1}</a></li>
					</c:forEach>
				</c:if>

				<li
					class="page-item ${pageNumber + 1 >= totalPages ? 'disabled' : ''}">
					<a class="page-link"
					href="?page=${Math.min(totalPages - 1, pageNumber + 1)}">Sau</a>
				</li>
				<li
					class="page-item ${pageNumber + 1 >= totalPages ? 'disabled' : ''}">
					<a class="page-link" href="?page=${totalPages - 1}">&raquo;</a>
				</li>
			</ul>
		</nav>
	</div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(document)
			.ready(
					function() {
						$('#selectAll').change(
								function() {
									$('.orderCheckbox').prop('checked',
											$(this).is(':checked'));
									updateBulkUpdateButton();
								});

						$('.orderCheckbox').change(function() {
							updateBulkUpdateButton();
						});

						function updateBulkUpdateButton() {
							$('#bulkUpdateBtn').prop('disabled',
									$('.orderCheckbox:checked').length === 0);
						}

						$('#bulkUpdateForm')
								.submit(
										function(e) {
											if (!confirm('Bạn chắc chắn muốn cập nhật trạng thái các đơn hàng đã chọn?')) {
												e.preventDefault();
											}
										});
					});
</script>