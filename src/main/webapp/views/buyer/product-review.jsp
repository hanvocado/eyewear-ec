 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
 
	
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<c:if test="${not empty message}">
    <script>
        Swal.fire({
            title: 'Thông báo',
            text: "<c:out value='${message}' />",
            icon: 'success',
            confirmButtonText: 'OK'
        }).then((result) => {
            if (result.isConfirmed) {
                // Chuyển hướng tới controller
                window.location.href = '<c:url value="/buyer/orders/${orderId}" />';
            }
        });
    </script>
</c:if>

<div class="container-rv1">
    <h2 class="rv-title1">Product Review</h2>
    <form  action="/buyer/reviews/save" method="POST">
        <input type="hidden" name="buyerId">
        <input type="hidden" name="orderId" value="${orderId}">
        <input type="hidden" name="productId" value="${product.id}">
        

        <div class="product-info1">
            <div class="product-image1">
                <img src="${product.image}" alt="Product Image">
            </div>
            <div class="product-details1">
                <h3>${product.name}</h3>
                <p><strong>Description:</strong> ${product.description}</p>
                <p><strong>Price:</strong> ${product.price}<span> VND</span></p>
            </div>
        </div>

		
								
								

        <div class="review-section1">
            <label class="rv-label1">Rating:</label>
      <div class="rating-container1">
               <input type="range" value="${review.rating != null ? review.rating : 0}" name="rating" step="1" id="backing4">

									<div class="rateit" data-rateit-backingfld="#backing4"
										data-rateit-resetable="false" data-rateit-ispreset="true"
										data-rateit-min="0" data-rateit-max="5"></div>
									
            </div>
            <br><br>
            <label class="rv-label1" for="review1">Your Feedback:</label>
            <textarea id="review1" name="reviewContent" class="rv-textarea1" placeholder="Write your review here...">${review.reviewContent}</textarea>
        </div>

        <button type="submit" class="btn1 btn-primary btn-sm">
            ${review.buyer.id != null ? 'Update' : 'Add'}
        </button>
    </form>
</div>





