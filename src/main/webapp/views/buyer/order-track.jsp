<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<div class="container">
	<h2>Đơn hàng của tôi</h2>

	<div class="card mb-3">
		<div class="card-body">
			<form id="filterForm" action="/buyer/orders/my-orders" method="get"
				class="row g-3">
				<div class="col-md-3">
					<label class="form-label">Trạng thái</label> <select name="status"
						class="form-select">
						<option value="">Tất cả</option>
						<option value="Đã xác nhận"
							${param.status == 'Đã xác nhận' ? 'selected' : ''}>Đã
							xác nhận</option>
						<option value="Đang giao"
							${param.status == 'Đang giao' ? 'selected' : ''}>Đang
							giao</option>
						<option value="Hoàn thành"
							${param.status == 'Hoàn thành' ? 'selected' : ''}>Hoàn
							thành</option>
						<option value="Đã hủy"
							${param.status == 'Đã hủy' ? 'selected' : ''}>Đã hủy</option>
					</select>
				</div>
				<div class="col-md-3">
					<label class="form-label">Từ ngày</label> <input type="date"
						name="fromDate" class="form-control" value="${param.fromDate}">
				</div>
				<div class="col-md-3">
					<label class="form-label">Đến ngày</label> <input type="date"
						name="toDate" class="form-control" value="${param.toDate}">
				</div>
				<div class="col-md-3">
					<label class="form-label">&nbsp;</label>
					<button type="submit" class="btn btn-primary d-block w-100">Lọc</button>
				</div>
			</form>
		</div>
	</div>

	<div class="table-responsive">
		<table class="table table-striped">
			<thead>
				<tr>
					<th><a
						href="/buyer/orders/my-orders?page=0&sortBy=orderId&sortDir=${param.sortDir == 'asc' ? 'desc' : 'asc'}${!empty param.size ? '&size='.concat(param.size) : ''}${!empty param.status ? '&status='.concat(param.status) : ''}${!empty param.fromDate ? '&fromDate='.concat(param.fromDate) : ''}${!empty param.toDate ? '&toDate='.concat(param.toDate) : ''}">
							Mã đơn hàng <i
							class="bi ${param.sortBy == 'orderId' ? (param.sortDir == 'asc' ? 'bi-sort-up' : 'bi-sort-down') : 'bi-sort'}"></i>
					</a></th>
					<th><a
						href="/buyer/orders/my-orders?page=0&sortBy=orderAt&sortDir=${param.sortDir == 'asc' ? 'desc' : 'asc'}${!empty param.size ? '&size='.concat(param.size) : ''}${!empty param.status ? '&status='.concat(param.status) : ''}${!empty param.fromDate ? '&fromDate='.concat(param.fromDate) : ''}${!empty param.toDate ? '&toDate='.concat(param.toDate) : ''}">
							Ngày đặt <i
							class="bi ${param.sortBy == 'orderAt' ? (param.sortDir == 'asc' ? 'bi-sort-up' : 'bi-sort-down') : 'bi-sort'}"></i>
					</a></th>
					<th><a
						href="/buyer/orders/my-orders?page=0&sortBy=totalPrice&sortDir=${param.sortDir == 'asc' ? 'desc' : 'asc'}${!empty param.size ? '&size='.concat(param.size) : ''}${!empty param.status ? '&status='.concat(param.status) : ''}${!empty param.fromDate ? '&fromDate='.concat(param.fromDate) : ''}${!empty param.toDate ? '&toDate='.concat(param.toDate) : ''}">
							Tổng tiền <i
							class="bi ${param.sortBy == 'totalPrice' ? (param.sortDir == 'asc' ? 'bi-sort-up' : 'bi-sort-down') : 'bi-sort'}"></i>
					</a></th>
					<th>Trạng thái</th>
					<th colspan="2">Hành động</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${orders.content}" var="order">
					<tr>
						<td>${order.orderId}</td>
						<td><c:set var="dateFormatter"
								value='<%=java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")%>' />
							${order.orderAt.format(dateFormatter)}</td>
						<td><fmt:formatNumber value="${order.totalPrice}"
								type="currency" currencySymbol="₫" /></td>
						<td>${order.status}</td>
						<td><a href="/buyer/orders/${order.orderId}"
							class="btn btn-primary btn-sm">Xem chi tiết</a></td>
						<td><c:if
								test="${order.status!= 'Đã giao' && order.status != 'Đã huỷ'}">
								<button class="btn btn-danger btn-sm"
									onclick="confirmCancel('${order.orderId}')">Huỷ Đơn</button>
							</c:if></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>

	<c:if test="${orders.totalPages > 1}">
		<nav aria-label="Page navigation">
			<ul class="pagination justify-content-center">
				<li class="page-item ${orders.number == 0 ? 'disabled' : ''}">
					<a class="page-link"
					href="/buyer/orders/my-orders?page=${orders.number - 1}${!empty param.size ? '&size='.concat(param.size) : ''}${!empty param.sortBy ? '&sortBy='.concat(param.sortBy) : ''}${!empty param.sortDir ? '&sortDir='.concat(param.sortDir) : ''}${!empty param.status ? '&status='.concat(param.status) : ''}${!empty param.fromDate ? '&fromDate='.concat(param.fromDate) : ''}${!empty param.toDate ? '&toDate='.concat(param.toDate) : ''}">
						Trước </a>
				</li>
				<c:forEach begin="0" end="${orders.totalPages - 1}" var="i">
					<li class="page-item ${orders.number == i ? 'active' : ''}"><a
						class="page-link"
						href="/buyer/orders/my-orders?page=${i}${!empty param.size ? '&size='.concat(param.size) : ''}${!empty param.sortBy ? '&sortBy='.concat(param.sortBy) : ''}${!empty param.sortDir ? '&sortDir='.concat(param.sortDir) : ''}${!empty param.status ? '&status='.concat(param.status) : ''}${!empty param.fromDate ? '&fromDate='.concat(param.fromDate) : ''}${!empty param.toDate ? '&toDate='.concat(param.toDate) : ''}">
							${i + 1} </a></li>
				</c:forEach>
				<li
					class="page-item ${orders.number + 1 == orders.totalPages ? 'disabled' : ''}">
					<a class="page-link"
					href="/buyer/orders/my-orders?page=${orders.number + 1}${!empty param.size ? '&size='.concat(param.size) : ''}${!empty param.sortBy ? '&sortBy='.concat(param.sortBy) : ''}${!empty param.sortDir ? '&sortDir='.concat(param.sortDir) : ''}${!empty param.status ? '&status='.concat(param.status) : ''}${!empty param.fromDate ? '&fromDate='.concat(param.fromDate) : ''}${!empty param.toDate ? '&toDate='.concat(param.toDate) : ''}">
						Sau </a>
				</li>
			</ul>
		</nav>
	</c:if>
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

<c:if test="${not empty message}">
   Swal.fire({
       title: 'Thông báo',
       text: "${message}",
       icon: 'success',
       confirmButtonText: 'OK'
   });
</c:if>
</script>