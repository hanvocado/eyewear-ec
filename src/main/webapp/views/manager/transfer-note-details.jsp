<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<title>Chi tiết phiếu chuyển kho</title>

<body>
	<div class="page-content">
		<div class="container">
			<div class="portlet light">
				<div class="portlet-title">
					<div class="caption">
						<i class="fa fa-cogs font-green-sharp"></i>
						<span class="caption-subject font-green-sharp bold uppercase">Chi tiết phiếu chuyển kho</span>
					</div>
				</div>
				<div class="portlet-body form">
					<form class="form-horizontal" role="form">
						<div class="form-body">
							<div class="form-group">
								<label class="col-md-3 control-label">Chi nhánh nhập: </label>
								<div class="col-md-9">
									<input type="text" class="form-control" value="${transferNote.importBranch.name }" readonly>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-3 control-label">Chi nhánh xuất: </label>
								<div class="col-md-9">
									<input type="text" class="form-control" value="${transferNote.exportBranch.name }" readonly>
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-3 control-label">Trạng thái: </label>
								<div class="col-md-9">
									<input type="text" class="form-control" value="${transferNote.status }" readonly>
								</div>
							</div>								
							<div class="form-group">
								<label class="col-md-3 control-label">Thời điểm tạo yêu cầu: </label>
								<div class="col-md-9">
									<input type="text" class="form-control" value="${transferNote.createdAt }" readonly>
								</div>
							</div>								
							<div class="form-group">
								<label class="col-md-3 control-label">Thời điểm hoàn thành yêu cầu: </label>
								<div class="col-md-9">
									<input type="text" class="form-control" value="${transferNote.receivedAt }" readonly>
								</div>
							</div>		
							<div class="form-group">
								<label class="col-md-3 control-label">Số lượng - Sản phẩm được yêu cầu: </label>
								<div class="col-md-9">
									<div class="checkbox-list">
										<c:forEach items="${transferNote.products }" var="transferProduct">
											<input type="text" class="form-control text-primary" value="${transferProduct.quantity } - ${transferProduct.product.name }" readonly>										
										</c:forEach>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>