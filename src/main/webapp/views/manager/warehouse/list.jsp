<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!-- BEGIN CONTENT -->
<div class="page-content-wrapper">
	<div class="page-content">
		<!-- BEGIN SAMPLE PORTLET CONFIGURATION MODAL FORM-->
		<div class="modal fade" id="portlet-config" tabindex="-1"
			role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true"></button>
						<h4 class="modal-title">Modal title</h4>
					</div>
					<div class="modal-body">Widget settings form goes here</div>
					<div class="modal-footer">
						<button type="button" class="btn blue">Save changes</button>
						<button type="button" class="btn default" data-dismiss="modal">Close</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal-dialog -->
		</div>
		<!-- /.modal -->
		<!-- END SAMPLE PORTLET CONFIGURATION MODAL FORM-->
		<!-- BEGIN STYLE CUSTOMIZER -->

		<!-- END STYLE CUSTOMIZER -->
		<!-- BEGIN PAGE HEADER-->
		<h3 class="page-title">
			WAREHOUSE <small>Eyewear</small>
		</h3>
		<div class="page-bar">
			<a id="sample_editable_1_new" href="<c:url value="/manager"/>"
				class="btn green"> Home </a>
		</div>
		<!-- END PAGE HEADER-->
		<!-- BEGIN PAGE CONTENT-->
		<div class="row">
			<div class="col-md-12">
				<!-- BEGIN EXAMPLE TABLE PORTLET-->
				<div class="portlet box blue">
					<div class="portlet-title">
						<div class="caption">
							<i class="fa fa-edit"></i>Editable Table
						</div>
						<div class="tools">
							<a href="javascript:;" class="collapse"> </a> <a
								href="#portlet-config" data-toggle="modal" class="config"> </a>
							<a href="javascript:;" class="reload"> </a> <a
								href="javascript:;" class="remove"> </a>
						</div>
					</div>
					<div class="portlet-body">
						<div class="table-toolbar">
							<div class="row">
								<div class="col-md-6">
									<div class="btn-group">
										<form action="/manager/warehouse/searchpaginated">
											<input type="text" name="name" id="name"
												placeholder="Nhập từ khóa để tìm" />
											<button>Search</button>
										</form>
										<a id="sample_editable_1_new"
											href="<c:url value="/manager/warehouse/add"/>"
											class="btn green"> Add New <i class="fa fa-plus"></i>
										</a>
									</div>
								</div>
							</div>
						</div>
						<c:if test="${!list.hasContent()}">
	No Product
</c:if>

						<c:if test="${list.hasContent()}">
							<table class="table table-striped table-hover table-bordered"
								id="sample_editable_1">
								<thead>
									<tr>
										<!-- Không hiển thị ID nhưng giữ để sử dụng khi cần -->
										<th>STT</th>
										<th>Name</th>
										<th>Price</th>
										<th>Description</th>
										<th>Brand</th>
										<th>View</th>
										<th>Edit</th>
										<th>Delete</th>
									</tr>
								</thead>
								<tbody>
									<!-- Giả sử bạn đang duyệt qua danh sách sản phẩm trong một framework như JSP -->
									<c:forEach var="product" items="${list.content}" varStatus="STT">
										<tr>
											<!-- Cột ID ẩn -->
											<td>${STT.index + 1}</td>
											<!-- Tên sản phẩm -->
											<td>${product.name}</td>
											<!-- Giá -->
											<td>${product.price}</td>
											<!-- Mô tả -->
											<td>${product.description}</td>
											<!-- Thương hiệu -->
											<td>${product.brand}</td>
											<td><a class="view"
												href="/manager/warehouse/view/${product.id}">View</a></td>
											<!-- Link chỉnh sửa -->
											<td><a class="edit"
												href="/manager/warehouse/edit/${product.id}">Edit</a></td>
											<!-- Link xóa -->
											<td><a class="delete"
												href="/manager/warehouse/delete/${product.id}"
												onclick="return confirm('Are you sure you want to delete this product?');">
													Delete </a></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</c:if>
					</div>
				</div>
				<!-- END EXAMPLE TABLE PORTLET-->
			</div>
		</div>
		<!-- END PAGE CONTENT -->
	</div>
</div>
<!-- END CONTENT -->
<!-- Form chỉnh Page Size -->
<div class="row">
    <div class="col-md-6">
        <form action="" class="form-inline">
            <label for="size" class="mr-2 font-weight-bold">Page Size:</label>
            <select name="size" id="size" class="form-control" onchange="this.form.submit()">
                <option ${list.size == 3 ? 'selected' : ''} value="3">3</option>
                <option ${list.size == 5 ? 'selected' : ''} value="5">5</option>
                <option ${list.size == 10 ? 'selected' : ''} value="10">10</option>
                <option ${list.size == 15 ? 'selected' : ''} value="15">15</option>
                <option ${list.size == 20 ? 'selected' : ''} value="20">20</option>
            </select>
        </form>
    </div>
</div>

<c:if test="${list.totalPages > 0}">
    <div class="row mt-4">
        <div class="col-md-12">
            <nav>
                <ul class="pagination justify-content-center">
                    <!-- Duyệt qua từng số trang -->
                    <c:forEach items="${pageNumbers}" var="pageNumber">
                        <li class="page-item ${pageNumber == list.number + 1 ? 'active' : ''}">
                            <a class="page-link"
                               href="<c:url value='/manager/warehouse/searchpaginated?name=${name}&size=${list.size}&page=${pageNumber}'/>">
                                ${pageNumber}
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </nav>
        </div>
    </div>
</c:if>

<style>
    /* Sắp xếp các số trang theo chiều ngang */
    .pagination {
        display: flex;
        justify-content: center;
        flex-wrap: nowrap;
        padding-left: 0;
    }

    .pagination .page-item {
        margin-right: 5px; /* Thêm khoảng cách giữa các nút */
    }

    .pagination .page-link {
        padding: 5px 10px; /* Giảm kích thước của các nút */
        font-size: 14px; /* Giảm kích thước chữ */
    }
</style>

