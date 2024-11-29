<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<!-- BEGIN CONTENT -->
<div class="page-content-wrapper">
    <div class="page-content">
        <h3 class="page-title">
            CATEGORY MANAGEMENT <small>Eyewear</small>
        </h3>
        <div class="page-bar">
            <a id="sample_editable_1_new" href="<c:url value='/manager'/>" class="btn green"> Home </a>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="portlet box blue">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="fa fa-edit"></i>Category List
                        </div>
                    </div>
                    <div class="portlet-body">
                        <div class="table-toolbar">
                            <div class="row">
                                <div class="col-md-6">
                                    <form action="/manager/warehouse/category/searchpaginated">
                                        <input type="text" name="name" id="name" placeholder="Search categories" />
                                        <button>Search</button>
                                    </form>
                                    <a id="sample_editable_1_new" href="<c:url value='/manager/warehouse/category/add'/>" class="btn green">
                                        Add New <i class="fa fa-plus"></i>
                                    </a>
                                </div>
                            </div>
                        </div>

                        <c:if test="${!list.hasContent()}">
                            No Categories Found
                        </c:if>

                        <c:if test="${list.hasContent()}">
                            <table class="table table-striped table-hover table-bordered">
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th>Name</th>
                                        <th>View</th>
                                        <th>Edit</th>
                                        <th>Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="category" items="${list.content}" varStatus="STT">
                                        <tr>
                                            <td>${STT.index + 1}</td>
                                            <td>${category.name}</td>
                                            <td><a class="view" href="/manager/warehouse/category/view/${category.id}">View</a></td>
                                            <td><a class="edit" href="/manager/warehouse/category/edit/${category.id}">Edit</a></td>
                                            <td><a class="delete" href="/manager/warehouse/category/delete/${category.id}" onclick="return confirm('Are you sure?');">Delete</a></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>

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
                            <c:forEach items="${pageNumbers}" var="pageNumber">
                                <li class="page-item ${pageNumber == list.number + 1 ? 'active' : ''}">
                                    <a class="page-link" href="<c:url value='/manager/warehouse/category/searchpaginated?name=${name}&size=${list.size}&page=${pageNumber}'/>">
                                        ${pageNumber}
                                    </a>
                                </li>
                            </c:forEach>
                        </ul>
                    </nav>
                </div>
            </div>
        </c:if>
    </div>
</div>

<style>
    .pagination {
        display: flex;
        justify-content: center;
        flex-wrap: nowrap;
        padding-left: 0;
    }

    .pagination .page-item {
        margin-right: 5px;
    }

    .pagination .page-link {
        padding: 5px 10px;
        font-size: 14px;
    }
</style>
