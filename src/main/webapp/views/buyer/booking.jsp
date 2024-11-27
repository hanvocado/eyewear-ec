<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<section>
	<div class="main">
		<div class="container">
			<div class="col-12">
            <h1 class="text-center">Đặt lịch hẹn</h1>
            <div class="content-form-page">
              <form role="form" class="form-horizontal form-without-legend" method="POST" action="/buyer/booking">
			    <!-- Các trường thông tin người dùng -->
			    <div class="form-group">
			      <label class="col-lg-2 control-label" for="name">Họ và tên</label>
			      <div class="col-lg-8">
			        <input type="text" id="name" class="form-control" 
			               value="${buyer.name}">
			      </div>
			    </div>
			
			    <div class="form-group">
			      <label class="col-lg-2 control-label" for="email">E-Mail</label>
			      <div class="col-lg-8">
			        <input type="text" id="email" class="form-control" 
			               value="${buyer.email}">
			      </div>
			    </div>
			
			    <div class="form-group">
			      <label class="col-lg-2 control-label" for="telephone">Điện thoại</label>
			      <div class="col-lg-8">
			        <input type="text" id="telephone" class="form-control" 
			               value="${buyer.phoneNumber}">
			      </div>
			    </div>
			
			    <!-- Chi nhánh -->
			    <div class="form-group">
			      <label class="col-md-2 control-label">Chi nhánh<span class="require">*</span></label>
			      <div class="col-md-8">
			        <select class="form-control" name="branchId">
			          <c:forEach var="branch" items="${branchs}">
			            <option value="${branch.id}">
			                ${branch.name} - ${branch.address.streetNumber} ${branch.address.streetName}, ${branch.address.commue}, ${branch.address.district}, ${branch.address.province}
			            </option>
			          </c:forEach>
			        </select>
			      </div>
			    </div>
			
			    <!-- Thời gian đặt lịch -->
			    <div class="form-group">
			      <label class="col-md-2 control-label">Thời gian đặt lịch hẹn có sẵn<span class="require">*</span></label>
			      <div class="col-md-8">
			        <select class="form-control" name="appointmentTime">
			          <option value="1">Option 1</option>
			          <option value="2">Option 2</option>
			        </select>
			      </div>
			    </div>
			    
			    <div class="form-group">
										<label class="control-label col-md-2">Thời gian đặt lịch hẹn yêu cầu</label>
										<div class="col-md-8">
											<div class="input-group date form_datetime">
												<input type="text" size="16" readonly class="form-control">
												<span class="input-group-btn">
												<button class="btn default date-set" type="button"><i class="fa fa-calendar"></i></button>
												</span>
											</div>
											<!-- /input-group -->
										</div>
									</div>
			    
			   <!-- Lựa chọn dịch vụ -->
				<div class="form-group">
				    <label class="col-lg-2 control-label">Lựa chọn dịch vụ</label>
				    <div class="col-lg-8 checkbox-list">
				        <c:forEach var="service" items="${serviceTypes}">
				            <label>
				                <input type="checkbox" name="services" value="${service.name}"> ${service.displayName}
				            </label>
				        </c:forEach>
				    </div>
				</div>
                
                <!-- Images -->
                <div class="form-group">
                  <label class="col-lg-2 control-label">File input</label>
                  <div class="col-lg-8">
                    <input type="file">
                    <p class="help-block">some help text here.</p>
                  </div>
                </div>
			
			    <!-- Lời nhắn -->
			    <div class="form-group">
			      <label class="col-lg-2 control-label" for="message">Lời nhắn</label>
			      <div class="col-lg-8">
			        <textarea class="form-control" rows="6" name="message"></textarea>
			      </div>
			    </div>
			
			    <!-- Nút gửi -->
			    <div class="row">
			      <div class="col-lg-8 col-md-offset-2 padding-left-0 padding-top-20">
			        <button class="btn btn-primary" type="submit">Xác nhận</button>
			      </div>
			    </div>
			</form>

            </div>
          </div>
		</div>
	</div>
</section>

   
