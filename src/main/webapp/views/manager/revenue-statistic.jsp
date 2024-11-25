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
//Thêm biến để lưu context path
const contextPath = window.location.pathname.split('/manager')[0];

$(document).ready(function() {
    $('#viewReportBtn').click(function() {
        loadRevenueData();
    });
    
    // Thêm validation cho form
    $('#revenueFilterForm').on('submit', function(e) {
        e.preventDefault();
        const startDate = $('input[name="startDate"]').val();
        const endDate = $('input[name="endDate"]').val();
        
        if (!startDate || !endDate) {
            alert('Vui lòng chọn ngày bắt đầu và ngày kết thúc');
            return false;
        }
        
        if (new Date(startDate) > new Date(endDate)) {
            alert('Ngày bắt đầu phải nhỏ hơn ngày kết thúc');
            return false;
        }
        
        return true;
    });
});

function loadRevenueData() {
    const form = document.getElementById('revenueFilterForm');
    if (!form.checkValidity()) {
        form.reportValidity();
        return;
    }
    
    const formData = new FormData(form);
    const params = new URLSearchParams(formData);
    
    // Thêm loading indicator
    $('#revenueChart').addClass('loading');
    
    $.get(contextPath + '/manager/revenue/data?' + params.toString())
        .done(function(data) {
            if (data && data.chartData && data.chartData.length > 0) {
                updateChart(data);
            } else {
                alert('Không có dữ liệu thống kê cho khoảng thời gian này');
            }
        })
        .fail(function(jqXHR, textStatus, errorThrown) {
            alert('Lỗi khi tải dữ liệu: ' + errorThrown);
        })
        .always(function() {
            $('#revenueChart').removeClass('loading');
        });
}

function updateChart(data) {
    if (revenueChart) {
        revenueChart.destroy();
    }
    
    const ctx = document.getElementById('revenueChart').getContext('2d');
    revenueChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: data.chartData.map(item => item.label),
            datasets: [{
                label: 'Doanh thu',
                data: data.chartData.map(item => item.value),
                backgroundColor: 'rgba(54, 162, 235, 0.5)'
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
            },
            plugins: {
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            return new Intl.NumberFormat('vi-VN', {
                                style: 'currency', 
                                currency: 'VND'
                            }).format(context.raw);
                        }
                    }
                }
            }
        }
    });
}

function exportReport(fileType) {
    const form = document.getElementById('revenueFilterForm');
    if (!form.checkValidity()) {
        form.reportValidity();
        return;
    }
    
    const formData = new FormData(form);
    formData.append('fileType', fileType);
    
    // Thêm loading indicator
    const exportBtn = document.querySelector('.dropdown-toggle');
    const originalText = exportBtn.textContent;
    exportBtn.textContent = 'Đang xuất...';
    exportBtn.disabled = true;
    
    fetch(contextPath + '/manager/revenue/export', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.blob();
    })
    .then(blob => {
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.href = url;
        a.download = `revenue-report-${new Date().toISOString().slice(0,10)}.${fileType}`;
        a.click();
        window.URL.revokeObjectURL(url);
    })
    .catch(error => {
        alert('Lỗi khi xuất báo cáo: ' + error);
    })
    .finally(() => {
        exportBtn.textContent = originalText;
        exportBtn.disabled = false;
    });
}
</script>