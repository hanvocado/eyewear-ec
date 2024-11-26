<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<section>
	<div class="main">
		<div class="container">
			<div class="col-12">
            <h1 class="text-center">Đặt lịch hẹn</h1>
            <div class="content-form-page">
              <form role="form" class="form-horizontal form-without-legend">
                <div class="form-group">
                  <label class="col-lg-2 control-label" for="name">Họ và tên</label>
                  <div class="col-lg-8">
                    <input type="text" id="name" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-lg-2 control-label" for="email">E-Mail</label>
                  <div class="col-lg-8">
                    <input type="text" id="email" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-lg-2 control-label" for="telephone">Điện thoại</span></label>
                  <div class="col-lg-8">
                    <input type="text" id="telephone" class="form-control">
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-md-2 control-label">Chi nhánh<span class="require">*</span></label>
                  <div class="col-md-8">
                    <select class="form-control">
                      <option>Option 1</option>
                      <option>Option 2</option>
                      <option>Option 3</option>
                      <option>Option 4</option>
                      <option>Option 5</option>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-md-2 control-label">Thời gian đặt lịch hẹn<span class="require">*</span></label>
                  <div class="col-md-8">
                    <select class="form-control">
                      <option>Option 1</option>
                      <option>Option 2</option>
                      <option>Option 3</option>
                      <option>Option 4</option>
                      <option>Option 5</option>
                    </select>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-lg-2 control-label">Lựa chọn dịch vụ</label>
                  <div class="col-lg-8 checkbox-list">
                    <label>
                      <input type="checkbox"> Checkbox 1
                    </label>
                    <label>
                      <input type="checkbox"> Checkbox 2
                    </label>
                    <label>
                      <input type="checkbox" disabled> Disabled
                    </label>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-lg-2 control-label">File input</label>
                  <div class="col-lg-8">
                    <input type="file">
                    <p class="help-block">some help text here.</p>
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-lg-2 control-label" for="message">Lời nhắn</label>
                  <div class="col-lg-8">
                    <textarea class="form-control" rows="6"></textarea>
                  </div>
                </div>
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



