<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
  <head>
    <title>Login Administrator</title>
    <script
      src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
      crossorigin="anonymous"
    ></script>
    <link
      href="https://fonts.googleapis.com/css?family=Montserrat:400,700&display=swap"
      rel="stylesheet"
      type="text/css"
    />
    <link
      href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic&display=swap"
      rel="stylesheet"
      type="text/css"
    />
    <link
      href="${pageContext.request.contextPath}/resources/css/styles.css"
      rel="stylesheet"
    />
  </head>
  <body class="h-100">
    <div id="layoutAuthentication">
      <div id="layoutAuthentication_content">
        <main>
          <div class="container">
            <div class="row justify-content-center">
              <div class="col-lg-5">
                <div class="card shadow-lg border-0 rounded-lg mt-5">
                  <div class="card-header">
                    <h3 class="text-center font-weight-light my-4">
                      Login Administrator
                    </h3>
                  </div>
                  <div class="card-body">
                    <c:if test="${error != null}">
                      <div class="alert alert-danger" role="alert">
                        <c:out value="${error}" />
                      </div>
                    </c:if>
                    <c:if test="${message != null}">
                      <div class="alert alert-success" role="alert">
                        <c:out value="${message}" />
                      </div>
                    </c:if>
                    <form
                      action="${pageContext.request.contextPath}/admin/login"
                      method="post"
                    >
                      <div class="form-floating mb-3">
                        <input
                          class="form-control"
                          id="inputEmail"
                          type="email"
                          placeholder="name@example.com"
                          name="email"
                          required
                          value="${email}"
                        />
                        <label for="inputEmail">Email address</label>
                      </div>
                      <div class="form-floating mb-3">
                        <input
                          class="form-control"
                          id="inputPassword"
                          type="password"
                          placeholder="Password"
                          name="password"
                          required
                        />
                        <label for="inputPassword">Password</label>
                      </div>
                      <div
                        class="d-flex align-items-center justify-content-center mt-4 mb-0"
                      >
                        <button type="submit" class="btn btn-primary">
                          Login
                        </button>
                      </div>
                    </form>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </main>
      </div>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
      crossorigin="anonymous"
    ></script>
    <script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
  </body>
</html>
