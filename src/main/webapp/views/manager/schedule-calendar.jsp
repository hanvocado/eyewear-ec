<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
    
<title>Schedule calendar</title>    

<div class="page-container">
	
	<!-- BEGIN PAGE CONTENT -->
	<div class="page-content ">
		<div class="container">
			<!-- BEGIN PAGE CONTENT INNER -->
			<div class="row">
				<div class="col-md-12">
					<div class="portlet box green-meadow calendar">
						<div class="portlet-title">
							<div class="caption">
								<i class="fa fa-gift"></i>Calendar
							</div>
						</div>
						<div class="portlet-body">
							<div class="row">
								<div class="col-md-3 col-sm-12">
									<!-- BEGIN DRAGGABLE EVENTS PORTLET-->
									<h3 class="event-form-title">Draggable Events</h3>
									<div id="external-events">
										<form class="inline-form">
											<input type="text" value="" class="form-control" placeholder="Event Title..." id="event_title"/><br/>
											<a href="javascript:;" id="event_add" class="btn default">
											Add Event </a>
										</form>
										<hr/>
										<div id="event_box">
										</div>
										<label for="drop-remove">
										<input type="checkbox" id="drop-remove"/>remove after drop </label>
										<hr class="visible-xs"/>
									</div>
									<!-- END DRAGGABLE EVENTS PORTLET-->
								</div>
								<div class="col-md-9 col-sm-12">
									<div id="calendar" class="has-toolbar">
									</div>
								</div>
							</div>
							<!-- END CALENDAR PORTLET-->
						</div>
					</div>
				</div>
			</div>
			<!-- END PAGE CONTENT INNER -->
		</div>
	</div>
</div>
	
<!-- <script>
    $(document).ready(function() {
        $('#calendar').fullCalendar({
            events: '/manager/schedule/calendar', // Đường dẫn lấy các sự kiện
            editable: true, // Cho phép chỉnh sửa sự kiện
            droppable: true, // Cho phép kéo thả sự kiện
            selectable: true,
            selectHelper: true,
            dayClick: function(date, jsEvent, view) {
                var title = prompt("Enter Appointment Title:");
                var description = prompt("Enter Appointment Description:");

                if(title) {
                    // Thêm mới một appointment vào server
                    $.ajax({
                        url: '/manager/schedule/calendar',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify({
                            title: title,
                            description: description,
                            status: 'SCHEDULED', // Mặc định là SCHEDULED
                            startTime: date.format(),
                            endTime: date.add(1, 'hours').format() // Giả sử kéo dài 1 giờ
                        }),
                        success: function(response) {
                            $('#calendar').fullCalendar('renderEvent', response, true); // Thêm sự kiện vào lịch
                        }
                    });
                }
            },
            eventRender: function(event, element) {
                // Tùy chỉnh kiểu hiển thị sự kiện dựa trên trạng thái
                if(event.status === 'APPROVED' || event.status === 'SCHEDULED') {
                    element.css('background-color', '#28a745'); // Màu xanh cho trạng thái APPROVED hoặc SCHEDULED
                } else {
                    element.css('background-color', '#dc3545'); // Màu đỏ cho trạng thái khác
                }
            }
        });
    });
    </script> -->

<!-- <script>
document.addEventListener('DOMContentLoaded', function () {
    var calendarEl = document.getElementById('calendar');

    var calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        editable: true, // Cho phép kéo thả chỉnh sửa
        events: [
            {
                id: '1', // ID duy nhất cho mỗi sự kiện
                title: 'All Day Event',
                start: '2024-12-01'
            },
            {
                id: '2',
                title: 'Meeting',
                start: '2024-12-02T10:30:00'
            }
        ],
        eventClick: function (info) {
            // Hiển thị xác nhận trước khi xóa
            if (confirm('Bạn có chắc chắn muốn xóa sự kiện này không?')) {
                info.event.remove(); // Xóa sự kiện khỏi lịch
                alert('Sự kiện đã được xóa!');
            }
        }
    });

    calendar.render();
});

</script> -->