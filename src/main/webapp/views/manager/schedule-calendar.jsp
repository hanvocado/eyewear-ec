<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
    
<title>Schedule calendar</title>    
<style>
        #calendar {
            max-width: 900px;
            margin: 40px auto;
            height: auto; /* Hoặc đặt chiều cao cố định nếu cần */
        }
    </style>
 <div class="container mb-2">
    <div class="row">
        <!-- Tiêu đề ở giữa -->
        <div class="col-lg-12 text-center">
            <h2>Appointment Calendar</h2>
        </div>
        <!-- Nút Tạo mới căn phải -->
        <div class="col-lg-8"></div>
        <div class="col-lg-4 text-center">
            <button type="button" class="btn btn-primary" id="createAppointmentButton" data-toggle="modal" data-target="#appointmentModal">
                Tạo mới
            </button>
        </div>
    </div>

    <!-- Lịch nằm dưới tiêu đề và nút -->
    <div id="calendar" class="mt-2"></div>
</div>

    <!-- Modal for Appointment -->
    <div class="modal fade" id="appointmentModal" tabindex="-1" role="dialog" aria-labelledby="appointmentModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="appointmentModalLabel">Tạo Lịch Hẹn</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <!-- Form to create or edit appointment -->
                    <form id="appointmentForm">
                        <input type="hidden" id="appointmentId" name="id"/>
                        <div class="form-group">
                            <label for="appointmentStart">Ngày và giờ bắt đầu</label>
                            <input type="datetime-local" class="form-control" id="appointmentStart" name="start" required>
                        </div>
                        <div class="form-group">
                            <label for="appointmentEnd">Ngày và giờ kết thúc</label>
                            <input type="datetime-local" class="form-control" id="appointmentEnd" name="end" required>
                        </div>
                        <div class="form-group">
                            <label for="appointmentMessage">Nội dung</label>
                            <textarea class="form-control" id="appointmentMessage" name="message"></textarea>
                        </div>
                        <div class="modal-footer">
		                    <button type="submit" class="btn btn-primary">Save</button>
		                    <button type="button" class="btn btn-danger" id="deleteAppointmentButton" style="display: none;">Delete</button>
		                </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
        
<script src="/global/plugins/jquery.min.js" type="text/javascript"></script>
<script src="/global/plugins/jquery-migrate.min.js" type="text/javascript"></script>
<!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
<script src="/global/plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        
<script>
    $(document).ready(function () {
        // Lấy phần tử calendar
        var calendarEl = $('#calendar')[0];

        // Tạo đối tượng FullCalendar
        var calendar = new FullCalendar.Calendar(calendarEl, {
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay'
            },
            initialView: 'dayGridMonth',
            selectable: true,
            editable: true,
            events: function (info, successCallback, failureCallback) {
                // Lấy dữ liệu từ API
                $.getJSON('/manager/schedule/calendar-appointments', function (data) {
                	console.log("Data received from API:", data);
                	
                    var events = data.map(function (appointment) {
                    	console.log("Processing appointment:", appointment);
                            return {
                                id: appointment.id,
                                title: appointment.message,
                                start: appointment.start,
                                end: appointment.end,
                                description: appointment.message,
                                allDay: false
                            };
                    }).filter(function (event) { return event; }); // Loại bỏ các sự kiện null

                    console.log("Filtered events:", events);
                    successCallback(events);
                }).fail(function (error) {
                    console.error(error);
                    failureCallback(error);
                });
            },

            // Xử lý khi click vào sự kiện
            eventClick: function (info) {
                $('#appointmentModalLabel').text('Sửa Lịch Hẹn');
                $('#appointmentId').val(info.event.id);
                $('#appointmentStart').val(info.event.start.toISOString().slice(0, 16));
                $('#appointmentEnd').val(info.event.end.toISOString().slice(0, 16));
                $('#appointmentMessage').val(info.event.extendedProps.description);
                $('#deleteAppointmentButton').show(); // Hiển thị nút xóa
                $('#appointmentModal').modal('show');
            },

            // Xử lý khi chọn thời gian trên lịch
            select: function (info) {
                $('#appointmentModalLabel').text('Tạo Lịch Hẹn Mới');
                $('#appointmentForm')[0].reset(); // Reset form
                $('#appointmentId').val('');
                $('#appointmentStart').val(info.startStr);
                $('#appointmentEnd').val(info.endStr);
                $('#deleteAppointmentButton').hide(); 
                $('#appointmentModal').modal('show');
            }
        });

        // Hiển thị lịch
        calendar.render();

        // Reset modal mỗi khi đóng
        $('#appointmentModal').on('hidden.bs.modal', function () {
            $('#appointmentForm')[0].reset();
            $('#appointmentId').val('');
            document.getElementById('deleteAppointmentButton').style.display = 'none';
        });

        // Xử lý submit form
        $('#appointmentForm').on('submit', function (e) {
            e.preventDefault();

            var appointmentData = {
                id: $('#appointmentId').val(),
                start: $('#appointmentStart').val(),
                end: $('#appointmentEnd').val(),
                message: $('#appointmentMessage').val()
            };

            var url = '/manager/schedule/save';

            $.ajax({
                url: url,
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(appointmentData),
                success: function () {
                    $('#appointmentModal').modal('hide');
                    calendar.refetchEvents(); // Tải lại sự kiện trên lịch
                },
                error: function (xhr) {
                    console.error(xhr.responseText);
                    alert('Có lỗi xảy ra trong khi lưu lịch hẹn!');
                }
            });
        });

        $('#deleteAppointmentButton').on('click', function () {
            var appointmentId = $('#appointmentId').val();

            if (confirm('Bạn chắc chắn muốn xóa lịch hẹn này?')) {
                $.ajax({
                    url: '/manager/schedule/delete', 
                    method: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify({ id: appointmentId }), 
                    success: function () {
                    	alert('Lịch hẹn đã được xóa thành công!');
                        $('#appointmentModal').modal('hide');
                        calendar.refetchEvents(); 
                    },
                    error: function (xhr) {
                        console.error(xhr.responseText);
                        alert('Có lỗi xảy ra trong khi xóa lịch hẹn!');
                    }
                });
            }
        });
    });
</script>




	
