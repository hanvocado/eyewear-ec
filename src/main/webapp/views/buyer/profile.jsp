<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<div class="main">
    <div class="container">
        <!-- BEGIN SIDEBAR & CONTENT -->
        <div class="row margin-bottom-40">

                <!-- BEGIN SIDEBAR -->
        <div class="col-md-3 col-sm-5">
            <ul class="ver-inline-menu tabbable margin-bottom-10">
                <li class="active">
                    <a href="/buyer/profile" data-toggle="tab">
                        <i class="fa fa-user"></i> My Profile 
                    </a>
                    <span class="after"></span>
                </li>
                <li>
                    <a href="/buyer/orders/my-orders">
                        <i class="fa fa-shopping-cart"></i> My Orders
                    </a>
                </li>
                <li>
                    <a href="/buyer/appointments">
                        <i class="fa fa-calendar"></i> Appointments
                    </a>
                </li>
            </ul>
        </div>
        <!-- END SIDEBAR -->

            <!-- BEGIN CONTENT -->
            <div class="col-md-9 col-sm-7">
                <div class="content-page">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet light">
                                <div class="portlet-title">
                                    <div class="caption">
                                        <i class="fa fa-user font-blue-madison"></i>
                                        <span class="caption-subject font-blue-madison bold uppercase">My Profile</span>
                                    </div>
                                </div>
                                <div class="portlet-body form">
                                    <!-- BEGIN FORM-->
                                    <form role="form" action="/buyer/profile/update" method="post" enctype="multipart/form-data" class="form-horizontal">
                                        <div class="form-body">
                                            <!-- Avatar Upload -->
                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Profile Picture</label>
                                                <div class="col-md-9">
                                                    <div class="fileinput fileinput-new" data-provides="fileinput">
                                                        <div class="fileinput-new thumbnail" style="width: 200px; height: 200px;">
                                                            <img src="${buyer.avatar != null ? buyer.avatar : '/admin/layout/img/avatar.png'}" alt=""/>
                                                        </div>
                                                        <div class="fileinput-preview fileinput-exists thumbnail" style="width: 200px; height: 200px;"></div>
                                                        <div>
                                                            <span class="btn default btn-file">
                                                                <span class="fileinput-new">Select image</span>
                                                                <span class="fileinput-exists">Change</span>
                                                                <input type="file" name="avatarFile" accept="image/*">
                                                            </span>
                                                            <a href="javascript:;" class="btn red fileinput-exists" data-dismiss="fileinput">Remove</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Personal Information -->
                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Full Name</label>
                                                <div class="col-md-9">
                                                    <input type="text" name="name" class="form-control" value="${buyer.name}" placeholder="Enter your name">
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Email</label>
                                                <div class="col-md-9">
                                                    <input type="email" name="email" class="form-control" value="${buyer.email}" readonly>
                                                    <span class="help-block">Email cannot be changed</span>
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Phone Number</label>
                                                <div class="col-md-9">
                                                    <input type="tel" name="phone" class="form-control" value="${buyer.phone}" placeholder="Enter phone number">
                                                </div>
                                            </div>

                                            <div class="form-group">
                                                <label class="col-md-3 control-label">Address</label>
                                                <div class="col-md-9">
                                                    <textarea name="address" class="form-control" rows="3" placeholder="Enter your address">${buyer.address}</textarea>
                                                </div>
                                            </div>
                                        </div>

                                        <!-- Form Actions -->
                                        <div class="form-actions">
                                            <div class="row">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <button type="submit" class="btn blue">
                                                        <i class="fa fa-check"></i> Save Changes
                                                    </button>
                                                    <button type="button" class="btn default">Cancel</button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                    <!-- END FORM-->
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- END CONTENT -->
        </div>
        <!-- END SIDEBAR & CONTENT -->
    </div>
</div>