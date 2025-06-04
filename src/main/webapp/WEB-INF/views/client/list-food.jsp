<%@ page contentType="text/html; charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="org.datban.webjava.models.Food" %>

<div class="container">
  <ul class="nav nav-tabs d-flex justify-content-center" data-aos="fade-up" data-aos-delay="100">
    <li class="nav-item">
      <a class="nav-link active show" data-bs-toggle="tab" data-bs-target="#menu-starters">
        <h4>Gợi ý</h4>
      </a>
    </li>

    <li class="nav-item">
      <a class="nav-link" data-bs-toggle="tab" data-bs-target="#menu-breakfast">
        <h4>Bữa sáng</h4>
      </a>
    </li>

    <li class="nav-item">
      <a class="nav-link" data-bs-toggle="tab" data-bs-target="#menu-lunch">
        <h4>Bữa trưa</h4>
      </a>
    </li>

    <li class="nav-item">
      <a class="nav-link" data-bs-toggle="tab" data-bs-target="#menu-dinner">
        <h4>Bữa tối</h4>
      </a>
    </li>
  </ul>

  <div class="tab-content" data-aos="fade-up" data-aos-delay="200">
    <!-- Menu Gợi ý -->
    <div class="tab-pane fade active show" id="menu-starters">
      <div class="tab-header text-center">
        <p>Thực đơn</p>
        <h3>Gợi ý</h3>
      </div>

      <div class="row gy-5">
        <%
          List<Food> list = (List<Food>) request.getAttribute("foods");
          if (list == null || list.isEmpty()) {
        %>
          <p style="color: red;">Không có món ăn gợi ý nào để hiển thị.</p>
        <%
          } else {
            for (Food f : list) {
        %>
          <div class="col-lg-4 menu-item" onclick="addDish('<%= f.getName() %>')">
            <a href="<%= f.getImageUrl() %>" class="glightbox">
              <img src="<%= f.getImageUrl() %>" class="menu-img img-fluid" alt="">
            </a>
            <h4><%= f.getName() %></h4>
            <p class="ingredients"><%= f.getDescription() %></p>
            <p class="price"><%= f.getPrice() %></p>
          </div>
        <%
            }
          }
        %>
      </div>
    </div>

    <!-- Menu Bữa sáng -->
    <div class="tab-pane fade" id="menu-breakfast">
      <div class="tab-header text-center">
        <p>Thực đơn</p>
        <h3>Bữa sáng</h3>
      </div>
      <div class="row gy-5">
        <%
          List<Food> listbr = (List<Food>) request.getAttribute("foodsbr");
          if (listbr == null || listbr.isEmpty()) {
        %>
          <p style="color: red;">Không có món ăn gợi ý nào để hiển thị.</p>
        <%
          } else {
            for (Food f : listbr) {
        %>
          <div class="col-lg-4 menu-item" onclick="addDish('<%= f.getName() %>')">
            <a href="<%= f.getImageUrl() %>" class="glightbox">
              <img src="<%= f.getImageUrl() %>" class="menu-img img-fluid" alt="">
            </a>
            <h4><%= f.getName() %></h4>
            <p class="ingredients"><%= f.getDescription() %></p>
            <p class="price"><%= f.getPrice() %></p>
          </div>
        <%
            }
          }
        %>
      </div>
    </div>

    <!-- Menu Bữa trưa -->
    <div class="tab-pane fade" id="menu-lunch">
      <div class="tab-header text-center">
        <p>Thực đơn</p>
        <h3>Bữa trưa</h3>
      </div>
      <div class="row gy-5">
        <%
          List<Food> listlu = (List<Food>) request.getAttribute("foodslu");
          if (listlu == null || listlu.isEmpty()) {
        %>
          <p style="color: red;">Không có món ăn gợi ý nào để hiển thị.</p>
        <%
          } else {
            for (Food f : listlu) {
        %>
          <div class="col-lg-4 menu-item" onclick="addDish('<%= f.getName() %>')">
            <a href="<%= f.getImageUrl() %>" class="glightbox">
              <img src="<%= f.getImageUrl() %>" class="menu-img img-fluid" alt="">
            </a>
            <h4><%= f.getName() %></h4>
            <p class="ingredients"><%= f.getDescription() %></p>
            <p class="price"><%= f.getPrice() %></p>
          </div>
        <%
            }
          }
        %>
      </div>
    </div>

    <!-- Menu Bữa tối -->
    <div class="tab-pane fade" id="menu-dinner">
      <div class="tab-header text-center">
        <p>Thực đơn</p>
        <h3>Bữa tối</h3>
      </div>
      <div class="row gy-5">
        <%
          List<Food> listdn = (List<Food>) request.getAttribute("foodsdn");
          if (listdn == null || listdn.isEmpty()) {
        %>
          <p style="color: red;">Không có món ăn gợi ý nào để hiển thị.</p>
        <%
          } else {
            for (Food f : listdn) {
        %>
          <div class="col-lg-4 menu-item" onclick="addDish('<%= f.getName() %>')">
            <a href="<%= f.getImageUrl() %>" class="glightbox">
              <img src="<%= f.getImageUrl() %>" class="menu-img img-fluid" alt="">
            </a>
            <h4><%= f.getName() %></h4>
            <p class="ingredients"><%= f.getDescription() %></p>
            <p class="price"><%= f.getPrice() %></p>
          </div>
        <%
            }
          }
        %>
      </div>
    </div>
  </div>
</div> 