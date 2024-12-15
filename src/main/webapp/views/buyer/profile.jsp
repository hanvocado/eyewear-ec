<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
    .alert {
        position: fixed;
        top: 20px;
        right: 20px;
        z-index: 9999;
        min-width: 300px;
        border-radius: 4px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .alert.fade {
        opacity: 0;
        transition: opacity 0.5s ease-in-out;
    }

    .alert.fade.in {
        opacity: 1;
    }
</style>

<div class="main">
    <div class="container">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3">
                <div class="list-group">
                    <a href="#" class="list-group-item active" style="background-color: #d9534f; border-color: #d43f3a;">
                        <i class="fa fa-user"></i> MY PROFILE
                    </a>
                    <a href="#" class="list-group-item">
                        <i class="fa fa-shopping-cart"></i> My Orders
                    </a>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-9">
                <!-- Alert Message -->
                <div id="alertMessage" style="display: none;" class="alert alert-dismissible fade">
                    <button type="button" class="close" onclick="closeAlert()">×</button>
                    <span id="alertText"></span>
                </div>

                <div class="panel panel-default" style="border: none;">
                    <div style="position: relative;">
                        <!-- Top colored section -->
                        <div style="background-color: #d9534f; height: 100px; border-radius: 4px 4px 0 0;"></div>

                        <!-- Content section -->
                        <div style="background: white; padding: 20px; border-radius: 0 0 4px 4px;">
                            <div class="row" style="margin-top: -60px;">
                                <!-- Avatar section -->
                                <div class="col-md-2">
                                    <div style="position: relative; width: 120px; height: 120px; border-radius: 50%; overflow: hidden;">
                                        <c:choose>
                                            <c:when test="${not empty buyer.picture}">
                                                <img src="${buyer.picture}"
                                                     class="img-circle"
                                                     alt="Profile Picture"
                                                     style="width: 100%; 
                                                            height: 100%; 
                                                            object-fit: cover; 
                                                            border: 3px solid white; 
                                                            border-radius: 50%;
                                                            background-color: #fff;
                                                            display: block;">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="default-avatar"
                                                     style="width: 100%;
                                                            height: 100%;
                                                            background-color: #f8f9fa;
                                                            display: flex;
                                                            align-items: center;
                                                            justify-content: center;
                                                            font-size: 48px;
                                                            color: #d9534f;
                                                            border: 3px solid white;
                                                            border-radius: 50%;
                                                            overflow: hidden;
                                                            position: relative;">
                                                    <span style="position: absolute;
                                                               top: 50%;
                                                               left: 50%;
                                                               transform: translate(-50%, -50%);
                                                               line-height: 1;">
                                                            ${fn:toUpperCase(fn:substring(buyer.firstName, 0, 1))}
                                                    </span>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                        <label for="pictureInput"
                                               style="position: absolute; 
                                                      bottom: 5px; 
                                                      right: 5px; 
                                                      background: #d9534f; 
                                                      border-radius: 50%; 
                                                      width: 32px; 
                                                      height: 32px; 
                                                      text-align: center; 
                                                      line-height: 32px; 
                                                      cursor: pointer; 
                                                      border: 2px solid white;
                                                      z-index: 2;">
                                            <i class="fa fa-pencil" style="color: white;"></i>
                                        </label>
                                        <input type="file"
                                               id="pictureInput"
                                               name="picture"
                                               accept="image/*"
                                               onchange="uploadAvatar(this)"
                                               style="display: none;">
                                    </div>
                                </div>

                                <!-- Info and Buttons -->
                                <div class="col-md-10" style="margin-top: 60px;">
                                    <div class="row">
                                        <!-- Name and Description -->
                                        <div class="col-md-6">
                                            <h3 style="margin-top: 0; margin-bottom: 10px; font-weight: 700; color: #333;">
                                                ${buyer.firstName} ${buyer.lastName}
                                            </h3>
                                            <p style="color: #777;">Updates Your Photo and Personal Details.</p>
                                        </div>
                                        <!-- Buttons -->
                                        <div class="col-md-6">
                                            <div class="text-right">
                                                <button type="submit" form="profileForm" class="btn btn-danger"
                                                        style="min-width: 120px;">
                                                    SAVE
                                                </button>
                                                <button type="reset" form="profileForm" class="btn btn-default"
                                                        style="min-width: 120px; margin-left: 10px;">
                                                    CANCEL
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <hr style="margin-top: 30px;">

                            <!-- Form Section -->
                            <form id="profileForm" action="/buyer/profile/update" method="post" role="form">
                                <div class="form-group">
                                    <label>First Name</label>
                                    <input type="text" name="firstName" class="form-control" value="${buyer.firstName}">
                                </div>
                                <div class="form-group">
                                    <label>Last Name</label>
                                    <input type="text" name="lastName" class="form-control" value="${buyer.lastName}">
                                </div>
                                <div class="form-group">
                                    <label>Email</label>
                                    <input type="email" name="email" class="form-control" value="${buyer.email}" readonly>
                                </div>
                                <div class="form-group">
                                    <label>Phone Number</label>
                                    <input type="tel" name="phone" class="form-control" value="${buyer.phone}">
                                </div>

                                <!-- Address Section -->
                                <hr style="margin: 20px 0;">
                                <h4 style="color: #333; margin-bottom: 20px;">Address Information</h4>

                                <div class="form-group">
                                    <label>Province</label>
                                    <input type="text" name="province" class="form-control"
                                           value="${buyer.address.province}"
                                           placeholder="Enter province">
                                </div>

                                <div class="form-group">
                                    <label>District</label>
                                    <input type="text" name="district" class="form-control"
                                           value="${buyer.address.district}"
                                           placeholder="Enter district">
                                </div>

                                <div class="form-group">
                                    <label>Commune</label>
                                    <input type="text" name="commue" class="form-control"
                                           value="${buyer.address.commue}"
                                           placeholder="Enter commune">
                                </div>

                                <div class="form-group">
                                    <label>Street Name</label>
                                    <input type="text" name="streetName" class="form-control"
                                           value="${buyer.address.streetName}"
                                           placeholder="Enter street name">
                                </div>

                                <div class="form-group">
                                    <label>Street Number</label>
                                    <input type="number" name="streetNumber" class="form-control"
                                           value="${buyer.address.streetNumber}"
                                           placeholder="Enter street number">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById('profileForm').addEventListener('submit', function(e) {
        e.preventDefault();

        if(!validateForm()) {
            return;
        }

        const formData = new FormData(this);

        fetch('/buyer/profile/update', {
            method: 'POST',
            body: formData
        })
            .then(response => {
                if (response.status === 200) {
                    showAlert('Profile updated successfully!', 'success', true);
                } else {
                    throw new Error('Update failed');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                showAlert('Unable to update profile. Please try again later.', 'danger');
            });
    });

    function showAlert(message, type, reload = false) {
        const alertDiv = document.getElementById('alertMessage');
        const alertText = document.getElementById('alertText');

        let icon = '';
        switch(type) {
            case 'success':
                alertDiv.className = 'alert alert-success alert-dismissible fade in';
                icon = '<i class="fa fa-check-circle"></i> ';
                break;
            case 'danger':
                alertDiv.className = 'alert alert-danger alert-dismissible fade in';
                icon = '<i class="fa fa-times-circle"></i> ';
                break;
            case 'warning':
                alertDiv.className = 'alert alert-warning alert-dismissible fade in';
                icon = '<i class="fa fa-exclamation-triangle"></i> ';
                break;
        }

        alertText.innerHTML = icon + message;
        alertDiv.style.display = 'block';
        alertDiv.style.opacity = '1';
        alertDiv.style.transition = 'opacity 0.5s ease-in-out';

        if (reload) {
            setTimeout(() => {
                fadeOutAlert(() => {
                    window.location.reload();
                });
            }, 1500);
        } else {
            setTimeout(() => {
                fadeOutAlert();
            }, 3000);
        }
    }

    function fadeOutAlert(callback) {
        const alertDiv = document.getElementById('alertMessage');
        alertDiv.style.opacity = '0';

        setTimeout(() => {
            alertDiv.style.display = 'none';
            if (callback) callback();
        }, 500);
    }

    function closeAlert() {
        fadeOutAlert();
    }

    function uploadAvatar(input) {
        if (input.files && input.files[0]) {
            // Kiểm tra kích thước file (giới hạn 5MB)
            if (input.files[0].size > 5 * 1024 * 1024) {
                showAlert('File size too large. Maximum size is 5MB', 'warning');
                input.value = '';
                return;
            }

            // Kiểm tra loại file
            const fileType = input.files[0].type;
            if (!fileType.startsWith('image/')) {
                showAlert('Please select an image file', 'warning');
                input.value = '';
                return;
            }

            const reader = new FileReader();
            reader.onload = function(e) {
                const avatarContainer = document.querySelector('.default-avatar') || document.querySelector('.img-circle');
                if (avatarContainer.classList.contains('default-avatar')) {
                    // Nếu đang hiển thị avatar mặc định, thay thế bằng img
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    img.className = 'img-circle';
                    img.alt = 'Profile Picture';
                    img.style.cssText = `
                        width: 100%;
                        height: 100%;
                        object-fit: cover;
                        border: 3px solid white;
                        border-radius: 50%;
                        background-color: #fff;
                        display: block;
                    `;
                    avatarContainer.parentNode.replaceChild(img, avatarContainer);
                } else {
                    // Nếu đã có img, chỉ cần cập nhật src
                    avatarContainer.src = e.target.result;
                }
            }
            reader.readAsDataURL(input.files[0]);

            const formData = new FormData();
            formData.append('picture', input.files[0]);

            fetch('/buyer/profile/update-avatar', {
                method: 'POST',
                body: formData
            })
                .then(response => {
                    if (response.status === 200) {
                        showAlert('Avatar updated successfully!', 'success', true);
                    } else {
                        throw new Error('Upload failed');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    showAlert('Unable to upload avatar. Please try again later.', 'danger');
                    // Khôi phục avatar mặc định
                    const defaultAvatar = `
                    <div class="default-avatar" 
                         style="width: 100%;
                                height: 100%;
                                background-color: #f8f9fa;
                                display: flex;
                                align-items: center;
                                justify-content: center;
                                font-size: 48px;
                                color: #d9534f;
                                border: 3px solid white;
                                border-radius: 50%;
                                overflow: hidden;
                                position: relative;">
                        <span style="position: absolute;
                                   top: 50%;
                                   left: 50%;
                                   transform: translate(-50%, -50%);
                                   line-height: 1;">
                            ${fn:toUpperCase(fn:substring(buyer.firstName, 0, 1))}
                        </span>
                    </div>`;
                    const container = document.querySelector('.img-circle').parentElement;
                    container.innerHTML = defaultAvatar + container.innerHTML.substring(container.innerHTML.indexOf('<label'));
                });
        }
    }

    function validateForm() {
        const phone = document.querySelector('input[name="phone"]').value;
        if(phone.length < 9) {
            showAlert('Phone number must be at least 9 digits', 'warning');
            return false;
        }
        return true;
    }
</script>