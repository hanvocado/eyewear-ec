 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
 


  <div class="container-rv">
    <h2 class="rv-title">Product Review</h2>
    <form class="rv-form" action="/buyer/reviews/save" method="POST">
    	<input type="hidden" name="buyerId" value="${review.buyer.id != null ? review.buyer.id : buyerId}">

        <input type="hidden" name="productId" value="${product.id}">

        <table>
            <tr>
                <th class="checkout-image">Image</th>
                <th class="checkout-image">Name</th>
                <th class="checkout-description">Description</th>
                <th class="checkout-price">Price</th>
            </tr>
         
            <tr>
                <td class="checkout-image">
                    <a href="#"><img src="${product.image }  " alt="image"></a>
                </td>
                <td><p><strong>${product.name}</strong></p></td>
                <td class="checkout-description">
                    
                    <p><strong>${product.description}</strong></p>
                    <em></em>
                </td>
                <td class="checkout-price"><strong>${product.price}<span> VND</span></strong></td>
            </tr>
        </table>
        <br><br><br>
         
        <label class="rv-label" for="rating">Rating:</label>
       <div class="rating-rv">
    <label class="rv-label">
        <input type="radio" name="rating" value="1" ${review.rating == 1 ? 'checked' : ''}> 1
    </label>
    <label class="rv-label">
        <input type="radio" name="rating" value="2" ${review.rating == 2 ? 'checked' : ''}> 2
    </label>
    <label class="rv-label">
        <input type="radio" name="rating" value="3" ${review.rating == 3 ? 'checked' : ''}> 3
    </label>
    <label class="rv-label">
        <input type="radio" name="rating" value="4" ${review.rating == 4 ? 'checked' : ''}> 4
    </label>
    <label class="rv-label">
        <input type="radio" name="rating" value="5" ${review.rating == 5 ? 'checked' : ''}> 5
    </label>
</div>

        <br>
        <label class="rv-label" for="review">Your Feedback:</label><br>
        <textarea id="review" name="reviewContent" class="rv-textarea" placeholder="Write your review here...">${review.reviewContent }</textarea>
	
		<button type="submit" class="btn btn-primary btn-sm">
    		${buyerId == null ? 'Update' : 'Insert'}
		</button>

    </form>
</div>