<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<div class="container-fluid">
	<h2>Thống kê doanh thu</h2>

	<!-- Form lọc -->
	<div class="card-body">
		<form id="revenueFilterForm">
			<div class="row">
				<div class="col-md-3">
					<div class="form-group">
						<label>Chi nhánh</label> <select name="branchId"
							class="form-select">
							<option value="">Tất cả chi nhánh</option>
							<c:forEach items="${branches}" var="branch">
								<option value="${branch.id}">${branch.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>

				<div class="col-md-3">
					<div class="form-group">
						<label>Sản phẩm</label> <select name="productId"
							class="form-select">
							<option value="">Tất cả sản phẩm</option>
							<c:forEach items="${products}" var="product">
								<option value="${product.id}">${product.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>

				<div class="col-md-3">
					<div class="form-group">
						<label>Từ ngày</label> <input type="date" name="startDate"
							class="form-control">
					</div>
				</div>

				<div class="col-md-3">
					<div class="form-group">
						<label>Đến ngày</label> <input type="date" name="endDate"
							class="form-control">
					</div>
				</div>
			</div>

			<div class="mt-3">
				<button type="button" class="btn btn-primary" id="viewReportBtn">Xem
					báo cáo</button>
				<div class="dropdown d-inline-block">
					<button class="btn btn-secondary dropdown-toggle" type="button"
						data-bs-toggle="dropdown">Xuất báo cáo</button>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#"
							onclick="exportReport('excel')">Excel</a></li>
						<li><a class="dropdown-item" href="#"
							onclick="exportReport('pdf')">PDF</a></li>
					</ul>
				</div>
			</div>
		</form>
	</div>
</div>

<!-- Biểu đồ -->
<div class="card">
	<div class="card-body">
		<canvas id="revenueChart"></canvas>
	</div>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>

</script>