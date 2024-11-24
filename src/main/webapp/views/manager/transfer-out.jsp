<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<title>Xuất chuyển kho</title>

<body>
	<c:if test="${not empty message }">
		<div class="alert alert-${messageType } alert-dismissable"
			id="alertBox">
			<button type="button" class="close" data-dismiss="alert"
				aria-hidden="true"></button>
			${message }
		</div>
	</c:if>
	<div class="page-content">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<!-- BEGIN TAB PORTLET-->
					<div class="portlet light">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-home text-dark"></i>Danh sách phiếu yêu cầu chuyển kho
							</div>
						</div>
						<div class="portlet-body">
							<div class=" tabbable-custom">
								<ul class="nav nav-tabs">
									<li class="active"><a href="#portlet_tab1" data-toggle="tab"> Chờ xác nhận </a></li>
									<li><a href="#portlet_tab2" data-toggle="tab"> Đang vận chuyển </a></li>
									<li><a href="#portlet_tab3" data-toggle="tab"> Đã hoàn thành </a></li>
								</ul>
								<div class="tab-content">
									<div class="tab-pane active" id="portlet_tab1">
										<table class="table table-striped table-bordered table-hover"
											id="sample_1">
											<thead>

												<tr>
													<th>Chi nhánh yêu cầu</th>
													<th>Số sản phẩm yêu cầu</th>
													<th>Tổng số lượng sản phẩm nhập</th>
													<th>Hành động</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="note" items="${pendingNotes }">
													<tr class="odd gradeX">
														<td>${note.exportBranch.name}</td>
														<td>${note.numberOfProducts}</td>
														<td>${note.totalQuantity}</td>
														<td><a class="btn btn-warning"
															href="<c:url value='/manager/transfer/confirmShipping/${note.id }' />">Xác nhận</a>
															<a class="btn default"
															href="<c:url value='/manager/transfer/details/${note.id }' />">Xem chi tiết</a>
														</td>
													</tr>

												</c:forEach>
											</tbody>
										</table>

									</div>
									<div class="tab-pane" id="portlet_tab2">
										<table class="table table-striped table-bordered table-hover"
											id="sample_1">
											<thead>

												<tr>
													<th>Chi nhánh yêu cầu</th>
													<th>Số sản phẩm yêu cầu</th>
													<th>Tổng số lượng sản phẩm nhập</th>
													<th></th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="note" items="${shippingNotes }">
													<tr class="odd gradeX">
														<td>${note.exportBranch.name}</td>
														<td>${note.numberOfProducts}</td>
														<td>${note.totalQuantity}</td>
														<td><a class="btn default"
															href="<c:url value='/manager/transfer/details/${note.id }' />">Xem chi tiết</a></td>
													</tr>

												</c:forEach>
											</tbody>
										</table>
									</div>
									<div class="tab-pane" id="portlet_tab3">
										<table class="table table-striped table-bordered table-hover"
											id="sample_1">
											<thead>

												<tr>
													<th>Chi nhánh yêu cầu</th>
													<th>Số sản phẩm yêu cầu</th>
													<th>Tổng số lượng sản phẩm nhập</th>
													<th></th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="note" items="${completedNotes }">
													<tr class="odd gradeX">
														<td>${note.exportBranch.name}</td>
														<td>${note.numberOfProducts}</td>
														<td>${note.totalQuantity}</td>
														<td><a class="btn default"
															href="<c:url value='/manager/transfer/details/${note.id }' />">Xem chi tiết</a></td>
													</tr>

												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- END TAB PORTLET-->
				</div>
			</div>
		</div>
	</div>
</body>