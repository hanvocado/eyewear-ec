<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

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
				    <label class="col-lg-2 control-label">Chi nhánh<span class="require">*</span></label>
				    <div class="col-lg-8">
				        <select class="form-control" name="branch">
				            <c:forEach var="branch" items="${branchs}">
				                <option value="${branch.id}">
				                    ${branch.name} - ${branch.address.streetNumber} ${branch.address.streetName}, ${branch.address.commue}, ${branch.address.district}, ${branch.address.province}
				                </option>
				            </c:forEach>
				        </select>
				    </div>
				</div>


				<!-- Chọn thời gian đặt lịch -->
			    <div class="form-group">
				    <label class="col-lg-2 control-label">Thời gian đặt lịch hẹn<span class="require">*</span></label>
				    <div class="col-lg-8">
				        <div class="row">
						    <div class="col-lg-2">
						        <input type="radio" name="appointmentType" value="existing" id="existing" />
						        <label for="existing">Đang có</label>
						    </div>
						    <div class="col-lg-10">
						        <select class="form-control" name="appointmentTime">
						            <c:forEach var="option" items="${appointmentOpts}">
						                <option value="${option}">${option}</option>
						            </c:forEach>
						        </select>
						    </div>
						</div>

				    </div>
				</div>
				
				<div class="form-group">
				    <label class="col-lg-2 control-label"></label>
				    <div class="col-lg-8">
				        <div class="row">
				            <div class="col-lg-2">
				                <input type="radio" name="appointmentType" value="custom" id="custom" />
				                <label for="custom">Tùy chỉnh</label>
				            </div>
				            <div class="col-lg-4">
				                <div class="input-group input-medium date date-picker" data-date-format="dd-mm-yyyy" data-date-start-date="+0d">
				                    <input type="text" class="form-control" name="customDate" placeholder="Chọn ngày" />
				                    <span class="input-group-btn">
				                        <button class="btn default" type="button">
				                            <i class="fa fa-calendar"></i>
				                        </button>
				                    </span>
				                </div>
				            </div>
				            <div class="col-lg-3">
				                <div class="input-group">
				                    <input type="text" class="form-control timepicker timepicker-24" name="customStartTime" placeholder="Giờ bắt đầu" />
				                    <span class="input-group-btn">
				                        <button class="btn default" type="button">
				                            <i class="fa fa-clock-o"></i>
				                        </button>
				                    </span>
				                </div>
				            </div>
				            <div class="col-lg-3">
				                <div class="input-group">
				                    <input type="text" class="form-control timepicker timepicker-24" name="customEndTime" placeholder="Giờ kết thúc" />
				                    <span class="input-group-btn">
				                        <button class="btn default" type="button">
				                            <i class="fa fa-clock-o"></i>
				                        </button>
				                    </span>
				                </div>
				            </div>
				        </div>
				    </div>
				</div>
							
			   <!-- Lựa chọn dịch vụ -->
				<div class="form-group">
				    <label class="col-lg-2 control-label">Lựa chọn dịch vụ</label>
				    <div class="col-lg-8">
				        <div class="row">
				            <div class="col-md-6">
				                <c:forEach var="service" items="${services}" varStatus="status">
				                    <c:if test="${status.index % 2 == 0}">
				                        <label>
				                            <input type="checkbox" class="service-checkbox" value="${service.name()}"> ${service.getDisplayName()}
				                        </label><br>
				                    </c:if>
				                </c:forEach>
				            </div>
				            <div class="col-md-6">
				                <c:forEach var="service" items="${services}" varStatus="status">
				                    <c:if test="${status.index % 2 != 0}">
				                        <label>
				                            <input type="checkbox" class="service-checkbox" value="${service.name()}"> ${service.getDisplayName()}
				                        </label><br>
				                    </c:if>
				                </c:forEach>
				            </div>
				        </div>
				    </div>
				</div>
				
				<input type="hidden" name="selectedServices" id="selectedServices">
			
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

<script>
    document.querySelectorAll('.service-checkbox').forEach(checkbox => {
        checkbox.addEventListener('change', () => {
            const selected = Array.from(document.querySelectorAll('.service-checkbox:checked'))
                .map(cb => cb.value)
                .join(',');
            document.getElementById('selectedServices').value = selected;
        });
    });
</script>

   
