<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>

<title>Schedule request</title>    

<div class="container mt-4">
	<div class="text-center">
		<h4>Danh sách cuộc hẹn được yêu cầu</h4>
	</div>


    <table class="table table-bordered table-striped">
        <thead>
            <tr>
                <th scope="col" class="col-2">Khách hàng</th>
	            <th scope="col" class="col-2">Thời gian</th>
	            <th scope="col" class="col-2">Ngày tạo</th>
	            <th scope="col" class="col-2">Dịch vụ</th>
	            <th scope="col" class="col-3">Lời nhắn</th>
	            <th scope="col" class="col-1"></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="appointment" items="${appointments}">
                <tr>
                    <td>
                    <div class="row">
                    	<div class="col-lg-3">
                    		<c:choose>
						        <c:when test="${not empty appointment.buyer.img}">
						            <img src="${appointment.buyer.img}" alt="${appointment.buyer.name}" class="rounded-circle">
						        </c:when>
						        <c:otherwise>
						            <img src="https://via.placeholder.com/50" alt="${appointment.buyer.name}" class="rounded-circle">
						        </c:otherwise>
						    </c:choose>
                    	</div>
                    	
                    	<div class="col-lg-9">
                    		<!-- Name -->
                    		<div>
                    			<c:out value="${appointment.buyer.name}" />
                    		</div>
                    		
                    		<!-- Email -->
                    		<div>
                    			<c:out value="${appointment.buyer.email}" />
                    		</div>
                    	</div>
                    </div>
				</td>
                 
                    <!-- Time -->
                    <td><c:out value="${appointment.getFormattedAppointment()}" /></td>
                    
                    <!-- CreatedAt -->
                    <td><c:out value="${appointment.getFormattedCreatedAt()}" /></td>
                    
                    <!-- Services -->
                    <td><c:out value="${appointment.getServicesDisplay()}" /></td>
                    
                    <!-- Message -->
                    <td><c:out value="${appointment.message}" /></td>
                    
                    <!-- Actions -->
                   <td>
                   <div>
					    <form action="/manager/schedule/update-status" method="post" style="display:inline;" id="acceptForm-${appointment.id}">
					        <input type="hidden" name="appointmentId" value="${appointment.id}">
					        <input type="hidden" name="status" value="APPROVED">
					        <button type="button" class="btn btn-success btn-sm mr-2" id="acceptBtn-${appointment.id}" onclick="startCountdown(${appointment.id}, 'APPROVED')">Accept</button>
					    </form>
					    <form action="/manager/schedule/update-status" method="post" style="display:inline;" id="rejectForm-${appointment.id}">
					        <input type="hidden" name="appointmentId" value="${appointment.id}">
					        <input type="hidden" name="status" value="REJECTED">
					        <button type="button" class="btn btn-danger btn-sm" id="rejectBtn-${appointment.id}" onclick="startCountdown(${appointment.id}, 'REJECTED')">Reject</button>
					    </form>
					</div>
					
					<div id="undoDiv-${appointment.id}" style="display:none;">
					    <p id="timer-${appointment.id}">Còn <span id="countdown-${appointment.id}">5</span> giây để hoàn tác</p>
					        <input type="hidden" name="appointmentId" value="${appointment.id}">
					        <button type="submit" class="btn btn-warning btn-sm" id="undoBtn-${appointment.id}">Hoàn tác</button>
					</div>

				</td>

                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<script>
function startCountdown(appointmentId, status) {
    var countdown = 5; 
    var countdownElem = document.getElementById('countdown-' + appointmentId);
    var undoDiv = document.getElementById('undoDiv-' + appointmentId);
    var acceptBtn = document.getElementById('acceptBtn-' + appointmentId);
    var rejectBtn = document.getElementById('rejectBtn-' + appointmentId);

    undoDiv.style.display = 'inline-block';
    acceptBtn.disabled = true; 
    rejectBtn.disabled = true;

    var interval = setInterval(function () {
        countdownElem.innerHTML = countdown; 
        if (countdown <= 0) {
            clearInterval(interval); 
            acceptBtn.disabled = true; 
            rejectBtn.disabled = true; 
            undoDiv.style.display = 'none'; 

            var form;
            if (status === 'APPROVED') {
                form = document.getElementById('acceptForm-' + appointmentId); 
            } else {
                form = document.getElementById('rejectForm-' + appointmentId); 
            }

            if (form) {
                form.submit(); 
            }
        }
        countdown--;
    }, 1000);
    
    var undoBtn = document.getElementById('undoBtn-' + appointmentId);
    undoBtn.onclick = function (event) {
        event.preventDefault();  
        clearInterval(interval); 
        undoDiv.style.display = 'none'; 
        acceptBtn.disabled = false; 
        rejectBtn.disabled = false; 
    };
}
</script>
