<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>

<title>Schedule list</title>

<div class="container mt-4">
    <!-- Navbar for Tabs -->
    <ul class="nav nav-tabs" id="scheduleTab" role="tablist">
        <li class="active" role="presentation">
            <a href="#approved" id="approvedTab" data-toggle="tab" role="tab" aria-controls="approved" aria-selected="true">Lịch hẹn đang có</a>
        </li>
        <li role="presentation">
            <a href="#allAppointments" id="allAppointmentsTab" data-toggle="tab" role="tab" aria-controls="allAppointments" aria-selected="false">Tất cả lịch hẹn</a>
        </li>
    </ul>

    <div class="tab-content mt-3" id="scheduleTabContent">
        <!-- Approved Appointments Tab -->
        <div class="tab-pane fade in active" id="approved" role="tabpanel" aria-labelledby="approvedTab">
            <!-- Upcoming, Finished, and On-Progress Appointments -->
            <div class="row">
                <!-- UpComing Appointments -->
                <div class="col-md-4" style="background-color: #f0f8ff;">
                    <h5>Upcoming Appointments</h5>
                    <div class="panel-group">
                        <c:forEach var="appointment" items="${upcomingAppointments}">
                            <div class="panel panel-default">
                                <div class="panel-body">
                                    <h5 class="panel-title">${appointment.buyer.name}</h5>
                                    <p><strong>Thời gian:</strong> ${appointment.getFormattedAppointment()}</p>
                                    <p><strong>Ngày tạo:</strong> ${appointment.getFormattedCreatedAt()}</p>
                                    <p><strong>Dịch vụ:</strong> ${appointment.getServicesDisplay()}</p>
                                    <p><strong>Lời nhắn:</strong> ${appointment.message}</p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- OnProgress Appointments -->
                <div class="col-md-4" style="background-color: #fffacd;">
                    <h5>On-Progress Appointments</h5>
                    <div class="panel-group">
                        <c:forEach var="appointment" items="${onProgressAppointments}">
                            <div class="panel panel-warning">
                                <div class="panel-body">
                                    <h5 class="panel-title">${appointment.buyer.name}</h5>
                                    <p><strong>Thời gian:</strong> ${appointment.getFormattedAppointment()}</p>
                                    <p><strong>Ngày tạo:</strong> ${appointment.getFormattedCreatedAt()}</p>
                                    <p><strong>Dịch vụ:</strong> ${appointment.getServicesDisplay()}</p>
                                    <p><strong>Lời nhắn:</strong> ${appointment.message}</p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- Finished Appointments -->
                <div class="col-md-4" style="background-color: #e0ffe0;">
                    <h5>Finished Appointments</h5>
                    <div class="panel-group">
                        <c:forEach var="appointment" items="${finishedAppointments}">
                            <div class="panel panel-success">
                                <div class="panel-body">
                                    <h5 class="panel-title">${appointment.buyer.name}</h5>
                                    <p><strong>Thời gian:</strong> ${appointment.getFormattedAppointment()}</p>
                                    <p><strong>Ngày tạo:</strong> ${appointment.getFormattedCreatedAt()}</p>
                                    <p><strong>Dịch vụ:</strong> ${appointment.getServicesDisplay()}</p>
                                    <p><strong>Lời nhắn:</strong> ${appointment.message}</p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <!-- All Appointments Tab -->
        <div class="tab-pane fade" id="allAppointments" role="tabpanel" aria-labelledby="allAppointmentsTab">
            <table class="table table-bordered table-striped">
                <thead>
                    <tr>
                        <th>Khách hàng</th>
                        <th>Thời gian</th>
                        <th>Ngày tạo</th>
                        <th>Dịch vụ</th>
                        <th>Lời nhắn</th>
                        <th>Trạng thái</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="appointment" items="${allAppointments}">
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
                            <td><c:out value="${appointment.getFormattedAppointment()}" /></td>
                            <td><c:out value="${appointment.getFormattedCreatedAt()}" /></td>
                            <td><c:out value="${appointment.getServicesDisplay()}" /></td>
                            <td><c:out value="${appointment.message}" /></td>
                            <td><c:out value="${appointment.status}" /></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
       
    </div>
</div>
