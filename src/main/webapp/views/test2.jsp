<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
    .star-rating {
        color: #f39c12;
    }

    /* Bỏ viền bảng */
    .table-bordered td, .table-bordered th {
        border-left: none !important;
        border-right: none !important;
    }

    /* Cải thiện bố cục cho danh sách đánh giá */
    .review-card {
        margin-bottom: 15px;
    }

    /* Thêm padding cho phần phân trang */
    .pagination {
        padding: 20px 0;
    }

    /* Chỉnh sửa phân cách các phần đánh giá */
    .review-card .card-body {
        padding: 15px;
    }
</style>

<div class="container mt-4">
    <h1>Product Reviews</h1>

    <!-- Form để lọc theo rating -->
    <form action="getReviews" method="get" class="mb-4">
        <input type="hidden" name="productId" value="${productId}">
        <div class="row">
            <div class="col-md-6">
                <label for="rating" class="form-label">Filter by Rating:</label>
                <select id="rating" name="rating" class="form-select">
                    <option value="">All Ratings</option>
                    <c:forEach var="r" begin="1" end="5">
                        <option value="${r}" ${rating == r ? 'selected' : '1'}>${r} Stars</option>
                    </c:forEach>
                </select>
            </div>
            <div class="col-md-6 d-flex align-items-end">
                <button type="submit" class="btn btn-primary">Filter</button>
            </div>
        </div>
    </form>

    <!-- Hiển thị danh sách đánh giá -->
    <c:if test="${not empty reviews}">
        <div class="list-group">
            <c:forEach var="review" items="${reviews}">
                <div class="review-card">
                    <div class="card">
                        <div class="card-body">
                            <!-- Tên người đánh giá và ngày đánh giá -->
                            <div class="d-flex justify-content-between">
                                <h5 class="mb-1">${review.buyer.username}</h5>
                                <small>${review.reviewDate}</small>
                            </div>

                            <!-- Hiển thị Rating dưới dạng sao -->
                            <div class="star-rating mb-2">
                                <c:forEach var="star" begin="1" end="5">
                                    <c:if test="${star <= review.rating}">
                                        <i class="fas fa-star"></i> <!-- Sao đầy -->
                                    </c:if>
                                    <c:if test="${star > review.rating}">
                                        <i class="far fa-star"></i> <!-- Sao rỗng -->
                                    </c:if>
                                </c:forEach>
                            </div>

                            <!-- Nội dung đánh giá -->
                            <p>${review.reviewContent}</p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:if>

    <!-- Phân trang -->
    <nav>
        <ul class="pagination justify-content-center">
            <c:if test="${totalPages > 0}">
            <c:forEach begin="0" end="${totalPages - 1}" var="i">
                <li class="page-item ${i == currentPage ? 'active' : ''}">
                    <a class="page-link" href="?productId=${productId}&rating=${rating}&page=${i}">${i + 1}</a>
                </li>
            </c:forEach>
            </c:if>
        </ul>
    </nav>

    <!-- Thông báo nếu không có đánh giá -->
    <c:if test="${empty reviews}">
        <p class="text-warning">No reviews found for the selected product.</p>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
