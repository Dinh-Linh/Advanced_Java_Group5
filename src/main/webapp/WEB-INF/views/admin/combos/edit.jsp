<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../layouts/header.jsp" %>
<%@ include file="../layouts/sidebar.jsp" %>

<main>
  <div class="container-fluid px-4">
    <h1 class="mt-4">Chỉnh sửa Combo</h1>
    <ol class="breadcrumb mb-4">
      <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin">Dashboard</a></li>
      <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/combos">Combo</a></li>
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
        Chỉnh sửa thông tin combo
      </div>
      <div class="card-body">
        <form id="editForm" action="${pageContext.request.contextPath}/admin/combos/${combo.id}" method="POST">
          <div class="row">
            <div class="col-md-9">
              <div class="mb-3">
                <label for="id" class="form-label">ID</label>
                <input type="text" class="form-control disabled" disabled id="id" name="id" readonly value="${combo.id}">
              </div>

              <div class="mb-3">
                <label for="name" class="form-label">Tên combo</label>
                <input type="text" class="form-control" id="name" name="name" value="${combo.name}" required>
              </div>
              
              <div class="mb-3">
                <label for="description" class="form-label">Mô tả</label>
                <textarea class="form-control" id="description" name="description"
                          required>${combo.description}</textarea>
              </div>
              
              <div class="mb-3">
                <label for="price" class="form-label">Giá</label>
                <div class="input-group">
                  <input type="number" class="form-control" id="price" name="price" value="${combo.price}" required>
                  <span class="input-group-text">VND</span>
                </div>
              </div>
              
              <div class="mb-3">
                <label for="status" class="form-label">Trạng thái</label>
                <select class="form-select" id="status" name="status">
                  <option value="available" ${combo.status == 'available' ? 'selected' : ''}>Đang bán</option>
                  <option value="unavailable" ${combo.status == 'unavailable' ? 'selected' : ''}>Hết hàng</option>
                </select>
              </div>
            </div>
            
            <div class="col-md-3">
              <div class="card">
                <div class="card-header">
                  <h5 class="card-title mb-0">Hình ảnh</h5>
                </div>
                <div class="card-body text-center">
                  <div class="image-container"
                       style="width: 300px; height: 300px; margin: 0 auto; position: relative; overflow: hidden;">
                    <img id="imagePreview" src="https://picsum.photos/300/300?random=${combo.id}"
                         alt="Combo ${combo.id}" class="img-fluid"
                         style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; object-fit: cover;">
                  </div>
                </div>
                <div class="card-footer">
                  <div class="mb-0">
                    <label for="imageUrl" class="form-label">URL hình ảnh</label>
                    <input type="text" class="form-control" id="imageUrl" name="imageUrl" value="${combo.imageUrl}"
                           placeholder="https://picsum.photos/seed/ma-hinh-anh-lorem-picsum/300/300" onchange="previewImageUrl(this)" required>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="mt-3">
            <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
            <a href="${pageContext.request.contextPath}/admin/combos" class="btn btn-secondary">Hủy</a>
          </div>
        </form>
      </div>
    </div>
  </div>
</main>

<script>

    function previewImageUrl(input) {
        const preview = document.getElementById('imagePreview');
        const url = input.value;

        if (url && url.trim() !== '') {
            preview.src = url;
        } else {
            preview.src = "https://picsum.photos/300/300?random=${combo.id}";
        }
    }

    // Hiển thị hình ảnh khi trang được tải
    document.addEventListener('DOMContentLoaded', function () {
        const imageUrl = document.getElementById('imageUrl').value;
        if (imageUrl && imageUrl.trim() !== '') {
            document.getElementById('imagePreview').src = imageUrl;
        }
    });
</script>

<%@ include file="../layouts/footer.jsp" %> 