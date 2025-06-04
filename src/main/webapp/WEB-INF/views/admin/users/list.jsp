<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../layouts/header.jsp" %>
<%@ include file="../layouts/sidebar.jsp" %>

<main>
  <div class="container-fluid px-4">
    <h1 class="mt-4">Quản lý Người dùng</h1>
    <ol class="breadcrumb mb-4">
      <li class="breadcrumb-item">
        <a href="${pageContext.request.contextPath}/admin">Dashboard</a>
      </li>
      <li class="breadcrumb-item active">Người dùng</li>
    </ol>
    
    <c:if test="${error != null}">
      <div class="alert alert-danger" role="alert">
        <c:out value="${error}"/>
      </div>
    </c:if>
    
    <c:if test="${message != null}">
      <div class="alert alert-success">
        <c:out value="${message}"/>
      </div>
    </c:if>
    
    <a
        href="${pageContext.request.contextPath}/admin/users/add"
        class="btn btn-primary mb-3"
    >Thêm người dùng</a>
    
    <div class="d-flex justify-content-between align-items-center mb-3">
      <div class="d-flex align-items-center gap-3">
        <div class="d-flex align-items-center">
          <label for="itemsPerPage" class="me-2">Số item mỗi trang:</label>
          <select class="form-select" id="itemsPerPage" style="width: 150px" onchange="changeItemsPerPage(this.value)">
            <option value="5" ${itemsPerPage == 5 ? 'selected' : ''}>5</option>
            <option value="10" ${itemsPerPage == 10 ? 'selected' : ''}>10</option>
            <option value="20" ${itemsPerPage == 20 ? 'selected' : ''}>20</option>
            <option value="50" ${itemsPerPage == 50 ? 'selected' : ''}>50</option>
          </select>
        </div>
        
        <div class="d-flex align-items-center">
          <label for="role" class="me-2">Vai trò:</label>
          <select class="form-select" id="role" style="width: 150px" onchange="filterByRole(this.value)">
            <option value="all" ${selectedRole == null ? 'selected' : ''}>Tất cả</option>
            <option value="admin" ${selectedRole == 'admin' ? 'selected' : ''}>Admin</option>
            <option value="customer" ${selectedRole == 'customer' ? 'selected' : ''}>Customer</option>
          </select>
        </div>
        
        <div class="d-flex align-items-center">
          <label for="keyword" class="me-2">Tìm kiếm:</label>
          <div class="input-group" style="width: 300px">
            <div class="position-relative flex-grow-1">
              <input
                  type="text"
                  class="form-control"
                  id="keyword"
                  placeholder="Tìm theo tên, email, số điện thoại..."
                  value="${keyword}"
              >
              <c:if test="${keyword != null && !empty keyword}">
                <button 
                  type="button" 
                  class="btn-close position-absolute top-50 end-0 translate-middle-y me-2"
                  style="display: block; padding: 0.5rem;"
                  onclick="clearKeyword()"
                  aria-label="Clear search"
                ></button>
              </c:if>
            </div>
            <button class="btn btn-outline-secondary" type="button" onclick="search()">
              <i class="fas fa-search"></i>
            </button>
          </div>
        </div>
      </div>
      <div class="text-muted">
        <c:choose>
          <c:when test="${totalItems == 0}">
            Không có kết quả nào
          </c:when>
          <c:otherwise>
            Hiển thị ${(currentPage - 1) * itemsPerPage + 1} - ${currentPage * itemsPerPage > totalItems ? totalItems : currentPage * itemsPerPage} của ${totalItems} người dùng
          </c:otherwise>
        </c:choose>
      </div>
    </div>
    
    <div class="card mb-4">
      <div class="card-header">
        <i class="fas fa-table me-1"></i>
        Danh sách người dùng
        <c:if test="${keyword != null}">
          <span class="ms-2 text-muted">
            Kết quả tìm kiếm cho: "${keyword}"
            <c:if test="${selectedRole != null}">
              - Vai trò: ${selectedRole}
            </c:if>
          </span>
        </c:if>
      </div>
      <div class="card-body">
        <table id="userTable" class="table table-striped table-bordered">
          <thead>
          <tr>
            <th class="text-center col-1" scope="col">STT</th>
            <th class="text-center col-1" scope="col">Mã người dùng</th>
            <th class="text-center col-2" scope="col">Tên</th>
            <th class="text-center col-2" scope="col">Email</th>
            <th class="text-center col-2" scope="col">Số điện thoại</th>
            <th class="text-center col-1" scope="col">Vai trò</th>
            <th class="text-center col-2" scope="col">Ngày tạo</th>
            <th class="text-center col-1" colspan="2" scope="col">Thao tác</th>
          </tr>
          </thead>
          
          <tbody>
          <c:if test="${users.size() == 0}">
            <tr>
              <td colspan="8" class="text-center align-middle text-danger">Không có người dùng nào</td>
            </tr>
          </c:if>
          <c:forEach items="${users}" var="user" varStatus="loop">
            <tr>
              <td class="text-center align-middle">${(currentPage - 1) * itemsPerPage + loop.index + 1}</td>
              <td class="text-center align-middle">${user.id}</td>
              <td class="text-center align-middle">${user.name}</td>
              <td class="text-center align-middle">${user.email}</td>
              <td class="text-center align-middle">${user.phone}</td>
              <td class="text-center align-middle">
                <c:choose>
                  <c:when test="${user.role == 'admin'}">
                    <span class="badge bg-primary">Admin</span>
                  </c:when>
                  <c:when test="${user.role == 'customer'}">
                    <span class="badge bg-secondary">Customer</span>
                  </c:when>
                </c:choose>
              </td>
              <td class="text-center align-middle">
                <fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy HH:mm:ss"/>
              </td>
              <td class="text-center align-middle">
                <a
                    href="${pageContext.request.contextPath}/admin/users/${user.id}/edit"
                    class="btn btn-warning d-flex justify-content-center align-items-center mx-auto w-fit"
                    style="width: fit-content; height: 38px; color: #282727"
                >
                  <i class="fas fa-edit"></i>
                </a>
              </td>
              <td class="text-center align-middle">
                <button
                    onclick="deleteUser('${user.id}')"
                    class="btn btn-danger d-flex justify-content-center align-items-center mx-auto w-fit"
                    style="width: fit-content; height: 38px;"
                  ${user.email == sessionScope.adminUser.email ? 'disabled' : ''}
                  ${user.email == sessionScope.adminUser.email ? 'title="You can not delete your account"' : ''}
                >
                  <i class="fas fa-trash"></i>
                </button>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
        
        <!-- Phân trang -->
        <c:if test="${totalItems > 0}">
          <nav aria-label="Page navigation" class="mt-4">
            <ul class="pagination justify-content-center">
              <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                <a class="page-link"
                   href="${pageContext.request.contextPath}/admin/users?page=${currentPage - 1}&itemsPerPage=${itemsPerPage}${keyword != null ? '&keyword='.concat(keyword) : ''}${selectedRole != null ? '&role='.concat(selectedRole) : ''}"
                   aria-label="Previous">
                  <span aria-hidden="true">&laquo;</span>
                </a>
              </li>
              
              <li class="page-item ${currentPage == 1 ? 'active' : ''}">
                <a class="page-link"
                   href="${pageContext.request.contextPath}/admin/users?page=1&itemsPerPage=${itemsPerPage}${keyword != null ? '&keyword='.concat(keyword) : ''}${selectedRole != null ? '&role='.concat(selectedRole) : ''}">
                  1
                </a>
              </li>
              
              <c:if test="${currentPage > 4}">
                <li class="page-item disabled">
                  <span class="page-link">...</span>
                </li>
              </c:if>
              
              <c:forEach begin="${Math.max(2, currentPage - 2)}"
                         end="${Math.min(totalPages - 1, currentPage + 2)}"
                         var="i">
                <li class="page-item ${currentPage == i ? 'active' : ''}">
                  <a class="page-link"
                     href="${pageContext.request.contextPath}/admin/users?page=${i}&itemsPerPage=${itemsPerPage}${keyword != null ? '&keyword='.concat(keyword) : ''}${selectedRole != null ? '&role='.concat(selectedRole) : ''}">
                      ${i}
                  </a>
                </li>
              </c:forEach>
              
              <c:if test="${currentPage < totalPages - 3}">
                <li class="page-item disabled">
                  <span class="page-link">...</span>
                </li>
              </c:if>
              
              <c:if test="${totalPages > 1}">
                <li class="page-item ${currentPage == totalPages ? 'active' : ''}">
                  <a class="page-link"
                     href="${pageContext.request.contextPath}/admin/users?page=${totalPages}&itemsPerPage=${itemsPerPage}${keyword != null ? '&keyword='.concat(keyword) : ''}${selectedRole != null ? '&role='.concat(selectedRole) : ''}">
                      ${totalPages}
                  </a>
                </li>
              </c:if>
              
              <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                <a class="page-link"
                   href="${pageContext.request.contextPath}/admin/users?page=${currentPage + 1}&itemsPerPage=${itemsPerPage}${keyword != null ? '&keyword='.concat(keyword) : ''}${selectedRole != null ? '&role='.concat(selectedRole) : ''}"
                   aria-label="Next">
                  <span aria-hidden="true">&raquo;</span>
                </a>
              </li>
            </ul>
          </nav>
        </c:if>
      </div>
    </div>
  </div>
</main>

<script>
    function deleteUser(id) {
        if (confirm("Bạn có chắc chắn muốn xóa người dùng này?")) {
            fetch("${pageContext.request.contextPath}/admin/users/" + id, {
                method: "DELETE"
            }).then(() => {
                window.location.reload();
            })
        }
    }

    function changeItemsPerPage(value) {
        const currentUrl = new URL(window.location.href);
        currentUrl.searchParams.set("itemsPerPage", value);
        currentUrl.searchParams.set("page", "1"); // Reset về trang 1 khi thay đổi số lượng items
        window.location.href = currentUrl.toString();
    }

    function filterByRole(role) {
        const currentUrl = new URL(window.location.href);
        if (role && role !== 'all') {
            currentUrl.searchParams.set("role", role);
        } else {
            currentUrl.searchParams.delete("role");
        }
        currentUrl.searchParams.set("page", "1"); // Reset về trang 1 khi thay đổi filter
        window.location.href = currentUrl.toString();
    }

    function search() {
        const keyword = document.getElementById('keyword').value.trim();
        const currentUrl = new URL(window.location.href);

        if (keyword) {
            currentUrl.searchParams.set("keyword", keyword);
        } else {
            currentUrl.searchParams.delete("keyword");
        }

        currentUrl.searchParams.set("page", "1"); // Reset về trang 1 khi tìm kiếm
        window.location.href = currentUrl.toString();
    }

    function clearKeyword() {
        const currentUrl = new URL(window.location.href);
        currentUrl.searchParams.delete("keyword");
        currentUrl.searchParams.set("page", "1"); // Reset về trang 1 khi xóa từ khóa
        window.location.href = currentUrl.toString();
    }

    // Thêm sự kiện Enter cho ô tìm kiếm
    document.getElementById('keyword').addEventListener('keypress', function (e) {
        if (e.key === 'Enter') {
            search();
        }
    });
</script>

<%@ include file="../layouts/footer.jsp" %>
