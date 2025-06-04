<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../layouts/header.jsp" %>
<%@ include file="../layouts/sidebar.jsp" %>

<main>
  <div class="container-fluid px-4">
    <h1 class="mt-4">Chỉnh sửa Bàn</h1>
    <ol class="breadcrumb mb-4">
      <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Dashboard</a></li>
      <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/tables">Bàn</a></li>
      <li class="breadcrumb-item active">Chỉnh sửa</li>
    </ol>
    
    <c:if test="${error != null}">
      <div class="alert alert-danger" role="alert">
        <c:out value="${error}"/>
      </div>
    </c:if>
    
    <div class="card mb-4">
      <div class="card-header">
        <i class="fas fa-edit me-1"></i>
        Chỉnh sửa thông tin bàn
      </div>
      <div class="card-body">
        <form id="editForm" action="${pageContext.request.contextPath}/admin/tables/${table.id}" method="POST">
          <div class="row">
            <div class="col-md-12">
              <div class="mb-3">
                <label for="id" class="form-label">ID</label>
                <input type="text" class="form-control disabled" disabled id="id" name="id" readonly
                       value="${table.id}">
              </div>
              
              <div class="mb-3">
                <label for="name" class="form-label">Tên bàn</label>
                <input type="text" class="form-control" id="name" name="name" value="${table.name}" required>
              </div>
              
              <div class="mb-3">
                <label for="capacity" class="form-label">Sức chứa</label>
                <input type="number" class="form-control" id="capacity" name="capacity" value="${table.capacity}"
                       required>
              </div>
              
              <div class="mb-3">
                <label for="location" class="form-label">Vị trí</label>
                <input type="text" class="form-control" id="location" name="location" value="${table.location}"
                       required>
              </div>
              
              <div class="mb-3">
                <label for="status" class="form-label">Trạng thái</label>
                <select class="form-select" id="status" name="status">
                  <option value="available" ${table.status == 'available' ? 'selected' : ''}>Trống</option>
                  <option value="occupied" ${table.status == 'occupied' ? 'selected' : ''}>Đang có khách</option>
                  <option value="reserved" ${table.status == 'reserved' ? 'selected' : ''}>Đã đặt trước</option>
                  <option value="maintenance" ${table.status == 'maintenance' ? 'selected' : ''}>Bảo trì</option>
                </select>
              </div>
            </div>
          </div>
          <div class="mt-3">
            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
            <a href="${pageContext.request.contextPath}/admin/tables" class="btn btn-secondary">Hủy</a>
          </div>
        </form>
      </div>
    </div>
  </div>
</main>

<%@ include file="../layouts/footer.jsp" %> 