<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../layouts/header.jsp" %>
<%@ include file="../layouts/sidebar.jsp" %>

<main>
    <div class="container-fluid px-4">
        <h1 class="mt-4">Chỉnh sửa người dùng</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item">
                <a href="${pageContext.request.contextPath}/admin">Dashboard</a>
            </li>
            <li class="breadcrumb-item">
                <a href="${pageContext.request.contextPath}/admin/users">Người dùng</a>
            </li>
            <li class="breadcrumb-item active">Chỉnh sửa</li>
        </ol>

        <c:if test="${error != null}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <c:if test="${message != null}">
            <div class="alert alert-success">${message}</div>
        </c:if>

        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-edit me-1"></i>
                Thông tin người dùng
            </div>
            <div class="card-body">
                <form id="editUserForm" action="${pageContext.request.contextPath}/admin/users/${user.id}"
                      method="post">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="name" class="form-label">Tên người dùng</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="name" name="name"
                                           value="${tempUser.name == null ? user.name : tempUser.name}" required>
                                    <span class="input-group-text reset-field" title="Reset" data-field="name"
                                          data-original="${user.name}">
                                        <i class="fas fa-rotate-left"></i>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="email" class="form-label">Email</label>
                                <div class="input-group">
                                    <input type="email" class="form-control" id="email" name="email"
                                           value="${tempUser.email == null ? user.email : tempUser.email}" required>
                                    <span class="input-group-text reset-field" title="Reset" data-field="email"
                                          data-original="${user.email}">
                                        <i class="fas fa-rotate-left"></i>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="phone" class="form-label">Số điện thoại</label>
                                <div class="input-group">
                                    <input type="tel" class="form-control" id="phone" name="phone"
                                           value="${tempUser.phone == null ? user.phone : tempUser.phone}" required>
                                    <span class="input-group-text reset-field" title="Reset" data-field="phone"
                                          data-original="${user.phone}">
                                        <i class="fas fa-rotate-left"></i>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="role" class="form-label">Vai trò</label>
                                <div class="input-group">
                                    <select class="form-select" id="role" name="role" required
                                    ${user.email == sessionScope.adminUser.email ? 'disabled' : ''}
                                    >
                                        <option value="admin" ${tempUser.role == null ? user.role == 'admin' ? 'selected' : '' : tempUser.role == 'admin' ? 'selected' : ''}>Admin</option>
                                        <option value="customer" ${tempUser.role == null ? user.role == 'customer' ? 'selected' : '' : tempUser.role == 'customer' ? 'selected' : ''}>Customer</option>
                                    </select>
                                    <c:if test="${user.email == sessionScope.adminUser.email}">
                                        <input type="hidden" name="role" value="${user.role}"/>
                                    </c:if>
                                    <span class="input-group-text reset-field" title="Reset" data-field="role"
                                          data-original="${user.role}">
                                        <i class="fas fa-rotate-left"></i>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="password" class="form-label">Mật khẩu mới</label>
                                <input type="password" class="form-control" id="password" name="password"
                                       placeholder="Để trống nếu không đổi mật khẩu">
                                <div class="form-text">Để trống nếu không muốn thay đổi mật khẩu</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="confirmPassword" class="form-label">Xác nhận mật khẩu mới</label>
                                <input type="password" class="form-control" id="confirmPassword"
                                       placeholder="Xác nhận mật khẩu mới" name="confirmPassword">
                            </div>
                        </div>
                    </div>

                    <div class="mt-4 mb-0">
                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                        <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-secondary">Hủy</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</main>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Xử lý sự kiện click vào nút reset (x)
        document.querySelectorAll('.reset-field').forEach(function (button) {
            button.addEventListener('click', function () {
                const field = this.getAttribute('data-field');
                const originalValue = this.getAttribute('data-original');

                if (field === 'role') {
                    const select = document.getElementById(field);
                    for (let i = 0; i < select.options.length; i++) {
                        select.options[i].selected = select.options[i].value === originalValue;
                    }
                } else {
                    document.getElementById(field).value = originalValue;
                }
            });
        });
    });
</script>

<%@ include file="../layouts/footer.jsp" %>