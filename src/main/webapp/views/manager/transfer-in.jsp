<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>

<title>Nhập chuyển kho</title>

<body>

	<div class="row">
		<div class="col-md-12">
			<!-- BEGIN EXAMPLE TABLE PORTLET-->
			<div class="portlet box grey-cascade">
				<div class="portlet-title">
					<div class="caption">
						<i class="fa fa-globe"></i>Danh sách phiếu nhập chuyển kho
					</div>
					<div class="tools">
						<a href="javascript:;" class="collapse"> </a>

					</div>
				</div>
				<div class="portlet-body">
					<div class="table-toolbar">
						<div class="row">
							<div class="col-md-6">
								<div class="btn-group">
									<a id="sample_editable_1_new" href="<c:url value="/manager/transfer/new"/>" class="btn green">
										Tạo yêu cầu mới <i class="fa fa-plus"></i>
									</a>
								</div>
							</div>
						</div>
					</div>
					<table class="table table-striped table-bordered table-hover"
						id="sample_1">
						<thead>

							<tr>
								<th>Chi nhánh xuất</th>
								<th>Số sản phẩm yêu cầu</th>
								<th>Tổng số lượng sản phẩm nhập</th>

								<th>Trạng thái</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="note" items="${importedNotes }">
								<tr class="odd gradeX">
									<td>${note.importBranch.name}</td>
									<td>${note.numberOfProducts}</td>
									<td>${note.totalQuantity}</td>

									<td><span class="label label-sm label-success">
											${note.status} </span></td>
								</tr>

							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<!-- END EXAMPLE TABLE PORTLET-->
		</div>
	</div>
</body>