<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>

<div class="container-fluid">
    <h2>Thống kê doanh thu</h2>

    <!-- Form lọc -->
    <div class="card-body">
        <form action="${pageContext.request.contextPath}/manager/revenue/data" method="GET">
            <div class="row">
                <!-- Chi nhánh -->
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="branchId">Chi nhánh</label>
                        <select id="branchId" name="branchId" class="form-select">
                            <option value="">Tất cả chi nhánh</option>
                            <c:forEach items="${branches}" var="branch">
                                <option value="${branch.id}" ${param.branchId == branch.id ? 'selected' : ''}>
                                    ${branch.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <!-- Sản phẩm -->
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="productId">Sản phẩm</label>
                        <select id="productId" name="productId" class="form-select">
                            <option value="">Tất cả sản phẩm</option>
                            <c:forEach items="${products}" var="product">
                                <option value="${product.id}" ${param.productId == product.id ? 'selected' : ''}>
                                    ${product.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <!-- Từ ngày -->
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="startDate">Từ ngày</label>
                        <input type="date" id="startDate" name="startDate" 
                               class="form-control" value="${param.startDate}" required>
                    </div>
                </div>

                <!-- Đến ngày -->
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="endDate">Đến ngày</label>
                        <input type="date" id="endDate" name="endDate" 
                               class="form-control" value="${param.endDate}" required>
                    </div>
                </div>
            </div>

            <!-- Nút hành động -->
            <div class="mt-3">
                <button type="submit" class="btn btn-primary">Xem báo cáo</button>
                <button type="button" class="btn btn-secondary" onclick="exportReport('excel')">Xuất Excel</button>
                <button type="button" class="btn btn-secondary" onclick="exportReport('pdf')">Xuất PDF</button>
            </div>
        </form>
    </div>
</div>

<!-- Hiển thị kết quả -->
<c:if test="${not empty revenueData}">
    <div class="card mt-4">
        <div class="card-body">
            <!-- Tổng doanh thu -->
            <div class="row mb-4">
                <div class="col">
                    <h4>Tổng doanh thu: 
                        <fmt:formatNumber value="${revenueData.totalRevenue}" 
                                        type="currency" currencySymbol="₫"/>
                    </h4>
                </div>
            </div>

            <!-- Thống kê theo sản phẩm nếu có -->
            <c:if test="${not empty revenueData.productStatistics}">
                <div class="row mb-4">
                    <div class="col">
                        <h5>Thống kê sản phẩm</h5>
                        <p>Số lượng đã bán: ${revenueData.productStatistics.totalQuantity}</p>
                        <p>Doanh thu: 
                            <fmt:formatNumber value="${revenueData.productStatistics.totalRevenue}" 
                                            type="currency" currencySymbol="₫"/>
                        </p>
                    </div>
                </div>
            </c:if>

            <!-- Thống kê theo chi nhánh nếu có -->
            <c:if test="${not empty revenueData.branchStatistics}">
                <div class="row mb-4">
                    <div class="col">
                        <h5>Thống kê chi nhánh</h5>
                        <p>Tổng số đơn hàng: ${revenueData.branchStatistics.orderCount}</p>
                        <p>Doanh thu: 
                            <fmt:formatNumber value="${revenueData.branchStatistics.totalRevenue}" 
                                            type="currency" currencySymbol="₫"/>
                        </p>
                    </div>
                </div>
            </c:if>

            <!-- Biểu đồ -->
            <div class="row">
                <div class="col">
                    <canvas id="revenueChart" style="width:100%; height:400px;"></canvas>
                </div>
            </div>
        </div>
    </div>
</c:if>

<!-- Script cho biểu đồ và xuất báo cáo -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
<script>
// Chỉ khởi tạo biểu đồ nếu có dữ liệu
<c:if test="${not empty revenueData.chartData}">
    const ctx = document.getElementById('revenueChart').getContext('2d');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [
                <c:forEach items="${revenueData.chartData}" var="item" varStatus="status">
                    '${item.date}'${!status.last ? ',' : ''}
                </c:forEach>
            ],
            datasets: [{
                label: 'Doanh thu (VNĐ)',
                data: [
                    <c:forEach items="${revenueData.chartData}" var="item" varStatus="status">
                        ${item.revenue}${!status.last ? ',' : ''}
                    </c:forEach>
                ],
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgb(75, 192, 192)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            return new Intl.NumberFormat('vi-VN', {
                                style: 'currency',
                                currency: 'VND'
                            }).format(value);
                        }
                    }
                }
            }
        }
    });
</c:if>

// Hàm xuất báo cáo
function exportReport(fileType) {
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = '${pageContext.request.contextPath}/manager/revenue/export';
    
    // Thêm các tham số hiện tại
    const params = {
        branchId: document.getElementById('branchId').value,
        productId: document.getElementById('productId').value,
        startDate: document.getElementById('startDate').value,
        endDate: document.getElementById('endDate').value,
        fileType: fileType
    };
    
    // Tạo input hidden cho mỗi tham số
    for (const key in params) {
        if (params[key]) {
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = key;
            input.value = params[key];
            form.appendChild(input);
        }
    }
    
    document.body.appendChild(form);
    form.submit();
    document.body.removeChild(form);
}
</script>