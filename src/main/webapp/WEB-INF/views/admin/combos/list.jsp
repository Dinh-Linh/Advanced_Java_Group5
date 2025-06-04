<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib
    prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include
    file="../layouts/header.jsp" %>
<%@ include file="../layouts/sidebar.jsp" %>

<main>
  <div class="container-fluid px-4">
    <h1 class="mt-4">Quản lý Combo</h1>
    <ol class="breadcrumb mb-4">
      <li class="breadcrumb-item">
        <a href="${pageContext.request.contextPath}/admin">Dashboard</a>
      </li>
      <li class="breadcrumb-item active">Combo</li>
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
        href="${pageContext.request.contextPath}/admin/combos/add"
        class="btn btn-primary mb-3"
    >Thêm combo</a
    >
    
    <div class="d-flex justify-content-between align-items-center mb-3">
      <div class="d-flex align-items-center gap-3">
        <div class="d-flex align-items-center">
          <label for="statusFilter" class="me-2">Lọc theo trạng thái:</label>
          <select class="form-select" id="statusFilter" style="width: 200px">
            <option value="all">Tất cả</option>
            <option value="available" ${selectedStatus == 'available' ? 'selected' : ''}>Đang bán</option>
            <option value="unavailable" ${selectedStatus == 'unavailable' ? 'selected' : ''}>Không bán</option>
          </select>
        </div>
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
          <label for="keyword" class="me-2">Tìm kiếm:</label>
          <div class="input-group" style="width: 300px">
            <div class="position-relative flex-grow-1">
              <input
                  type="text"
                  class="form-control"
                  id="keyword"
                  placeholder="Tìm theo tên combo..."
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
            Hiển thị ${(currentPage - 1) * itemsPerPage + 1} - ${currentPage * itemsPerPage > totalItems ? totalItems : currentPage * itemsPerPage} của ${totalItems} combo
          </c:otherwise>
        </c:choose>
      </div>
    </div>
    
    <div class="card mb-4">
      <div class="card-header">
        <i class="fas fa-table me-1"></i>
        Danh sách combo
        <c:if test="${keyword != null}">
          <span class="ms-2 text-muted">
            Kết quả tìm kiếm cho: "${keyword}"
            <c:if test="${selectedStatus != null && selectedStatus != 'all'}">
              - Trạng thái: ${selectedStatus == 'available' ? 'Đang bán' : 'Không bán'}
            </c:if>
          </span>
        </c:if>
      </div>
      <div class="card-body">
        <table id="comboTable" class="table table-striped table-bordered">
          <thead>
          <tr>
            <th class="text-center col-1" scope="col">STT</th>
            <th class="text-center col-1" scope="col">Mã combo</th>
            <th class="text-center col-1" scope="col">Hình ảnh</th>
            <th class="text-center col-2" scope="col">Tên combo</th>
            <th class="text-center col-1" scope="col">Giá</th>
            <th class="text-center col-1" scope="col">Trạng thái</th>
            <th class="text-center col-1" colspan="2" scope="col">Thao tác</th>
          </tr>
          </thead>
          
          <tbody>
          <c:if test="${combos.size() == 0}">
            <tr>
              <td colspan="8" class="text-center align-middle text-danger">Không có combo nào</td>
            </tr>
          </c:if>
          <c:forEach items="${combos}" var="combo" varStatus="loop">
            <tr>
              <td class="text-center align-middle">${(currentPage - 1) * itemsPerPage + loop.index + 1}</td>
              <td class="text-center align-middle">${combo.id}</td>
              <td class="text-center align-middle">
                <img
                    src="${not empty combo.imageUrl ? combo.imageUrl : 'https://picsum.photos/100/100?random='.concat(combo.id)}"
                    alt="Combo ${combo.id}"
                    style="width: 100px; height: 100px; object-fit: cover"
                />
              </td>
              <td class="text-center align-middle">${combo.name}</td>
              <td class="text-center align-middle">${combo.price}</td>
              <td class="text-center align-middle">
                <c:choose>
                  <c:when test="${combo.status == 'available'}">
                    <button class="btn btn-outline-success mx-auto" style="width: 120px; height: 38px;">Đang bán
                    </button>
                  </c:when>
                  <c:otherwise>
                    <button class="btn btn-outline-danger mx-auto" style="width: 120px; height: 38px;">Không bán
                    </button>
                  </c:otherwise>
                </c:choose>
              </td>
              <td class="text-center align-middle">
                <a
                    href="${pageContext.request.contextPath}/admin/combos/${combo.id}/edit"
                    class="btn btn-warning d-flex justify-content-center align-items-center mx-auto w-fit"
                    style="width: fit-content; height: 38px; color: #282727"
                >
                  <i class="fas fa-edit"></i>
                </a>
              </td>
              <td class="text-center align-middle">
                <button
                    onclick="deleteCombo('${combo.id}')"
                    class="btn btn-danger d-flex justify-content-center align-items-center mx-auto w-fit"
                    style="width: fit-content; height: 38px;"
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
                   href="${pageContext.request.contextPath}/admin/combos?page=${currentPage - 1}&itemsPerPage=${itemsPerPage}${keyword != null ? '&keyword='.concat(keyword) : ''}${selectedStatus != null && selectedStatus != 'all' ? '&status='.concat(selectedStatus) : ''}"
                   aria-label="Previous">
                  <span aria-hidden="true">&laquo;</span>
                </a>
              </li>
              
              <li class="page-item ${currentPage == 1 ? 'active' : ''}">
                <a class="page-link"
                   href="${pageContext.request.contextPath}/admin/combos?page=1&itemsPerPage=${itemsPerPage}${keyword != null ? '&keyword='.concat(keyword) : ''}${selectedStatus != null && selectedStatus != 'all' ? '&status='.concat(selectedStatus) : ''}">
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
                     href="${pageContext.request.contextPath}/admin/combos?page=${i}&itemsPerPage=${itemsPerPage}${keyword != null ? '&keyword='.concat(keyword) : ''}${selectedStatus != null && selectedStatus != 'all' ? '&status='.concat(selectedStatus) : ''}">
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
                     href="${pageContext.request.contextPath}/admin/combos?page=${totalPages}&itemsPerPage=${itemsPerPage}${keyword != null ? '&keyword='.concat(keyword) : ''}${selectedStatus != null && selectedStatus != 'all' ? '&status='.concat(selectedStatus) : ''}">
                      ${totalPages}
                  </a>
                </li>
              </c:if>
              
              <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                <a class="page-link"
                   href="${pageContext.request.contextPath}/admin/combos?page=${currentPage + 1}&itemsPerPage=${itemsPerPage}${keyword != null ? '&keyword='.concat(keyword) : ''}${selectedStatus != null && selectedStatus != 'all' ? '&status='.concat(selectedStatus) : ''}"
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
    function deleteCombo(id) {
        if (confirm("Bạn có chắc chắn muốn xóa combo này?")) {
            fetch("${pageContext.request.contextPath}/admin/combos/" + id, {
                method: "DELETE"
            }).then((response) => {
                if (response.ok) {
                    window.location.reload();
                } else {
                    alert("Có lỗi xảy ra khi xóa combo");
                }
            });
        }
    }

    function changeItemsPerPage(value) {
        const currentUrl = new URL(window.location.href);
        currentUrl.searchParams.set("itemsPerPage", value);
        currentUrl.searchParams.set("page", "1"); // Reset về trang 1 khi thay đổi số lượng items
        window.location.href = currentUrl.toString();
    }

    document.getElementById("statusFilter").addEventListener("change", function () {
        const status = this.value;
        const currentUrl = new URL(window.location.href);

        if (status && status !== 'all') {
            currentUrl.searchParams.set("status", status);
        } else {
            currentUrl.searchParams.delete("status");
        }
        currentUrl.searchParams.set("page", "1"); // Reset về trang 1 khi thay đổi trạng thái

        window.location.href = currentUrl.toString();
    });

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
