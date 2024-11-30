package com.eyewear.utils;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class DateTimeProcessing {

	public LocalDateTime[] getAppointmentTimes(String appointmentType, String appointmentTime, String customDate,
			String customStartTime, String customEndTime) {
		LocalDateTime startDateTime;
		LocalDateTime endDateTime;

		if ("custom".equals(appointmentType)) {
			// Định dạng ngày giờ cho custom date, start time và end time
			DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");
			
			customStartTime = normalizeTimeFormat(customStartTime);
	        customEndTime = normalizeTimeFormat(customEndTime);
			
			String startDateTimeStr = customDate + " " + customStartTime;
			String endDateTimeStr = customDate + " " + customEndTime;

			startDateTime = LocalDateTime.parse(startDateTimeStr, dateFormatter);
			endDateTime = LocalDateTime.parse(endDateTimeStr, dateFormatter);
		} else if ("existing".equals(appointmentType)) {
			startDateTime = getStartTimeFromOption(appointmentTime);
			endDateTime = getEndTimeFromOption(appointmentTime);
		} else {
			throw new IllegalArgumentException("Invalid appointment type");
		}

		return new LocalDateTime[] { startDateTime, endDateTime };
	}

	public LocalDateTime getStartTimeFromOption(String appointmentTime) {
		if (appointmentTime == null || appointmentTime.isEmpty()) {
			return null;
		}

		// Định dạng chuỗi: "dd-MM-yyyy HH:mm - HH:mm"
		String[] parts = appointmentTime.split(" - ");
		if (parts.length < 2) {
			throw new IllegalArgumentException("Invalid time format. Expected format: 'dd-MM-yyyy HH:mm - HH:mm'");
		}

		// Phần đầu là ngày giờ bắt đầu
		String startDateTimeStr = parts[0];
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");

		return LocalDateTime.parse(startDateTimeStr, formatter);
	}

	public LocalDateTime getEndTimeFromOption(String appointmentTime) {
		if (appointmentTime == null || appointmentTime.isEmpty()) {
			return null;
		}

		// Định dạng chuỗi: "dd-MM-yyyy HH:mm - HH:mm"
		String[] parts = appointmentTime.split(" - ");
		if (parts.length < 2) {
			throw new IllegalArgumentException("Invalid time format. Expected format: 'dd-MM-yyyy HH:mm - HH:mm'");
		}

		// Phần sau là giờ kết thúc (không chứa ngày, chỉ giờ)
		String startDateTimeStr = parts[0];
		String endTimeStr = parts[1];

		// Lấy ngày từ startDateTime để ghép vào giờ kết thúc
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm");
		LocalDateTime startDateTime = LocalDateTime.parse(startDateTimeStr, formatter);

		String endDateTimeStr = startDateTime.toLocalDate().format(DateTimeFormatter.ofPattern("dd-MM-yyyy")) + " "
				+ endTimeStr;

		return LocalDateTime.parse(endDateTimeStr, formatter);
	}
	
	// Hàm chuẩn hóa giờ về định dạng HH:mm
	private String normalizeTimeFormat(String time) {
	    if (time.length() == 4) { 
	        return "0" + time;
	    }
	    return time;
	}
}
