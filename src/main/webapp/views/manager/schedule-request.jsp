<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/taglibs.jsp"%>
    
<title>Schedule request</title>    

<section class="container-fluid mx-2 my-3">
	<div class="col-lg-12 col-xl-12">

							<div class="dashboard-header">
								<h3>Requests</h3>
								<ul>
									<li>
										<div class="dropdown header-dropdown">
											<a class="dropdown-toggle nav-tog" data-bs-toggle="dropdown" href="javascript:void(0);">
												Last 7 Days
											</a>
											<div class="dropdown-menu dropdown-menu-end">
												<a href="javascript:void(0);" class="dropdown-item">
													Today
												</a>
												<a href="javascript:void(0);" class="dropdown-item">
													This Month
												</a>
												<a href="javascript:void(0);" class="dropdown-item">
													Last 7 Days
												</a>
											</div>
										</div>
									</li>
								</ul>
							</div>
							
							<!-- Request List -->
							<div class="appointment-wrap">
								<ul>
									<li>
										<div class="patinet-information">
											<a href="patient-profile.html">
												<img src="/assets/img/doctors-dashboard/profile-01.jpg" alt="User Image">
											</a>
											<div class="patient-info">
												<p>#Apt0001</p>
												<h6><a href="patient-profile.html">Adrian</a><span class="badge new-tag">New</span></h6>
											</div>
										</div>
									</li>
									<li class="appointment-info">
										<p><i class="fa-solid fa-clock"></i>11 Nov 2024 10.45 AM</p>
										<p class="md-text">General Visit</p>
									</li>
									<li class="appointment-type">
										<p class="md-text">Type of Appointment</p>
										<p><i class="fa-solid fa-video text-blue"></i>Video Call</p>
									</li>
									<li>
										<ul class="request-action">
											<li>
												<a href="#" class="accept-link" data-bs-toggle="modal" data-bs-target="#accept_appointment"><i class="fa-solid fa-check"></i>Accept</a>
											</li>
											<li>
												<a href="#" class="reject-link" data-bs-toggle="modal" data-bs-target="#cancel_appointment"><i class="fa-solid fa-xmark"></i>Reject</a>
											</li>
										</ul>
									</li>
								</ul>
							</div>
							<!-- /Request List -->

							<!-- Request List -->
							<div class="appointment-wrap">
								<ul>
									<li>
										<div class="patinet-information">
											<a href="patient-profile.html">
												<img src="/assets/img/doctors-dashboard/profile-02.jpg" alt="User Image">
											</a>
											<div class="patient-info">
												<p>#Apt0002</p>
												<h6><a href="patient-profile.html">Kelly</a></h6>
											</div>
										</div>
									</li>
									<li class="appointment-info">
										<p><i class="fa-solid fa-clock"></i>10 Nov 2024 02.00 PM</p>
										<p class="md-text">General Visit</p>
									</li>
									<li class="appointment-type">
										<p class="md-text">Type of Appointment</p>
										<p><i class="fa-solid fa-building text-green"></i>Direct Visit <i class="fa-solid fa-circle-info" data-bs-toggle="tooltip" title="Clinic Location Sofia’s Clinic"></i></p>
									</li>
									<li>
										<ul class="request-action">
											<li>
												<a href="#" class="accept-link" data-bs-toggle="modal" data-bs-target="#accept_appointment"><i class="fa-solid fa-check"></i>Accept</a>
											</li>
											<li>
												<a href="#" class="reject-link" data-bs-toggle="modal" data-bs-target="#cancel_appointment"><i class="fa-solid fa-xmark"></i>Reject</a>
											</li>
										</ul>
									</li>
								</ul>
							</div>
							<!-- /Request List -->


							<!-- Request List -->
							<div class="appointment-wrap">
								<ul>
									<li>
										<div class="patinet-information">
											<a href="patient-profile.html">
												<img src="/assets/img/doctors-dashboard/profile-03.jpg" alt="User Image">
											</a>
											<div class="patient-info">
												<p>#Apt0003</p>
												<h6><a href="patient-profile.html">Samuel</a></h6>
											</div>
										</div>
									</li>
									<li class="appointment-info">
										<p><i class="fa-solid fa-clock"></i>08 Nov 2024 08.30 AM</p>
										<p class="md-text">Consultation for Cardio</p>
									</li>
									<li class="appointment-type">
										<p class="md-text">Type of Appointment</p>
										<p><i class="fa-solid fa-phone text-indigo"></i>Audio Call</p>
									</li>
									<li>
										<ul class="request-action">
											<li>
												<a href="#" class="accept-link" data-bs-toggle="modal" data-bs-target="#accept_appointment"><i class="fa-solid fa-check"></i>Accept</a>
											</li>
											<li>
												<a href="#" class="reject-link" data-bs-toggle="modal" data-bs-target="#cancel_appointment"><i class="fa-solid fa-xmark"></i>Reject</a>
											</li>
										</ul>
									</li>
								</ul>
							</div>
							<!-- /Request List -->

							<!-- Request List -->
							<div class="appointment-wrap">
								<ul>
									<li>
										<div class="patinet-information">
											<a href="patient-profile.html">
												<img src="/assets/img/doctors-dashboard/profile-06.jpg" alt="User Image">
											</a>
											<div class="patient-info">
												<p>#Apt0004</p>
												<h6><a href="patient-profile.html">Anderea</a></h6>
											</div>
										</div>
									</li>
									<li class="appointment-info">
										<p><i class="fa-solid fa-clock"></i>05 Nov 2024 11.00 AM</p>
										<p class="md-text">Consultation for Dental</p>
									</li>
									<li class="appointment-type">
										<p class="md-text">Type of Appointment</p>
										<p><i class="fa-solid fa-phone text-indigo"></i>Audio Call</p>
									</li>
									<li>
										<ul class="request-action">
											<li>
												<a href="#" class="accept-link" data-bs-toggle="modal" data-bs-target="#accept_appointment"><i class="fa-solid fa-check"></i>Accept</a>
											</li>
											<li>
												<a href="#" class="reject-link" data-bs-toggle="modal" data-bs-target="#cancel_appointment"><i class="fa-solid fa-xmark"></i>Reject</a>
											</li>
										</ul>
									</li>
								</ul>
							</div>
							<!-- /Request List -->

							<!-- Request List -->
							<div class="appointment-wrap">
								<ul>
									<li>
										<div class="patinet-information">
											<a href="patient-profile.html">
												<img src="/assets/img/doctors-dashboard/profile-05.jpg" alt="User Image">
											</a>
											<div class="patient-info">
												<p>#Apt0005</p>
												<h6><a href="patient-profile.html">Robert</a></h6>
											</div>
										</div>
									</li>
									<li class="appointment-info">
										<p><i class="fa-solid fa-clock"></i>07 Nov 2024 11.00 AM</p>
										<p class="md-text">General Visit</p>
									</li>
									<li class="appointment-type">
										<p class="md-text">Type of Appointment</p>
										<p><i class="fa-solid fa-phone text-indigo"></i>Audio Call</p>
									</li>
									<li>
										<ul class="request-action">
											<li>
												<a href="#" class="accept-link" data-bs-toggle="modal" data-bs-target="#accept_appointment"><i class="fa-solid fa-check"></i>Accept</a>
											</li>
											<li>
												<a href="#" class="reject-link" data-bs-toggle="modal" data-bs-target="#cancel_appointment"><i class="fa-solid fa-xmark"></i>Reject</a>
											</li>
										</ul>
									</li>
								</ul>
							</div>
							<!-- /Request List -->

							<div class="row">
								<div class="col-md-12">
									<div class="loader-item text-center">
										<a href="javascript:void(0);" class="btn btn-load">Load More</a>
									</div>
								</div>
							</div>

						</div>
</section>

<!-- jQuery -->
		<script src="/assets/js/jquery-3.7.1.min.js" type="c4ffd422148f20c694f86006-text/javascript"></script>
		
		<!-- Bootstrap Core JS -->
		<script src="/assets/js/bootstrap.bundle.min.js" type="c4ffd422148f20c694f86006-text/javascript"></script>
		
		<!-- Sticky Sidebar JS -->
        <script src="/assets/plugins/theia-sticky-sidebar/ResizeSensor.js" type="c4ffd422148f20c694f86006-text/javascript"></script>
        <script src="/assets/plugins/theia-sticky-sidebar/theia-sticky-sidebar.js" type="c4ffd422148f20c694f86006-text/javascript"></script>

		<!-- select JS -->
		<script src="/assets/plugins/select2/js/select2.min.js" type="c4ffd422148f20c694f86006-text/javascript"></script>
		
		<!-- Custom JS -->
		<script src="/assets/js/script.js" type="c4ffd422148f20c694f86006-text/javascript"></script>
		
	<script src="../../cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" data-cf-settings="c4ffd422148f20c694f86006-|49" defer></script>