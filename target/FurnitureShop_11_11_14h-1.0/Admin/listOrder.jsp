<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:import url="header.jsp" />
<%--------------------------------------------------------%>
<c:import url="sidebar.jsp" />
<script>
    document.addEventListener("DOMContentLoaded", function() {
        document.title = "Danh sách đơn hàng";
        const listStaffElement = document.getElementById("list-category");
        if (listStaffElement) {
            listStaffElement.classList.add("active");
        }
    });
</script>

<div class="page-wrapper">
    <div class="content">

        <div class="page-header" style="display: flex; justify-content: space-between; align-items: flex-start; padding: 20px; border-bottom: 1px solid #ddd;">
            <!-- Phần thông tin khách hàng -->
            <div class="customer-profile" style="display: flex; gap: 20px; align-items: stretch; height: auto;">
                <!-- Ảnh đại diện -->
                <div href="javascript:void(0);" class="product-img" style="flex-shrink: 0; height: 200px; width: 180px; display: flex; align-items: stretch;">
                    <img src="data:image/jpeg;base64,${customer.avatar}"
                         alt="Avatar"
                         style="height: 100%; width: 100%; object-fit: cover; display: block;" />
                </div>

                <!-- Thông tin khách hàng -->
                <div id="customer-info">
                    <div>
                        <span>Họ và tên:</span>
                        <span>${customer.name}</span>
                    </div>
                    <div>
                        <span>Số điện thoại:</span>
                        <span>${customer.phone}</span>
                    </div>
                    <div>
                        <span>Email:</span>
                        <span>${customer.email}</span>
                    </div>
                    <div>
                        <span>Địa chỉ:</span>
                        <span>${customer.address}</span>
                    </div>
                    <div>
                        <span>Trạng thái:</span>
                        <span>${customer.status}</span>
                    </div>
                </div>
            </div>

            <!-- Phần Quản lý đơn hàng -->
            <div class="page-title" style="text-align: right; margin-top: 20px;">
                <h4 style="font-weight: bold; font-size: 1.8em; margin: 0; font-family: 'Poppins', sans-serif; color: #333;">Quản Lý Đơn Hàng</h4>
                <h6 style="font-size: 1.1em; color: #777; margin: 5px 0 0; font-family: 'Roboto', sans-serif;">Tìm kiếm/xem phản hồi/xem chi tiết đơn hàng</h6>
            </div>
        </div>

        <form action="${pageContext.request.contextPath}/admin/customer-order" method="get"
              id="listForm">
            <div class="card">

                <div class="card-body">
                    <div class="search-header"
                         style="text-align: left; margin-bottom: 15px; padding: 10px; border-left: 5px solid #28a745; border-radius: 5px;">
                        <h6 class="search-title"
                            style="font-size: 1.2em; font-weight: 400; color: #4a4a4a; font-family: 'Poppins', sans-serif; font-style: italic; margin: 0;
           padding: 8px 12px; display: flex; align-items: center; background-color: #f9fbfd; border-radius: 8px;
           box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); text-shadow: 0px 1px 1px rgba(0, 0, 0, 0.1); letter-spacing: 0.5px;">
                            🔍 <span style="margin-left: 10px;">Tìm Kiếm Đơn Hàng</span>
                        </h6>

                    </div>
                    <div class="card-body pb-0">
                        <div class="row">
                            <input type="hidden" name="customerId" value="${searchOrder.customerId}" placeholder="Nhập mã khách hàng...">
                            <div class="col-lg-2 col-sm-6 col-12">
                                <div class="form-group">
                                    <input type="text" name="id"  value="${searchOrder.id}" placeholder="Nhập mã sản phẩm...">
                                </div>
                            </div>

                            <div class="col-lg-2 col-sm-6 col-12">
                                <div class="form-group">
                                    <input type="date"  name="orderDate" value="${searchOrder.orderDate}" class="form-control ">
                                </div>
                            </div>

                            <div
                                    class="col-lg-2 col-sm-6 col-12 ms-auto">
                                <button type="button"
                                        class="btn btn-success"
                                        id="btnSearchOrder">
                                    <svg xmlns="http://www.w3.org/2000/svg"
                                         width="16"
                                         height="16"
                                         fill="currentColor"
                                         class="bi bi-search"
                                         viewBox="0 0 16 16">
                                        <path
                                                d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0">
                                        </path>
                                    </svg>
                                    Tìm Kiếm
                                </button>
                            </div>
                        </div>
                    </div>
                    <br>
                    <div class="table-responsive">
                        <table class="table" id="orderList">

                            <thead>
                            <tr>
                                <th>
                                    <label class="checkboxs">
                                        <input type="checkbox" id="select-all">
                                        <span class="checkmarks"></span>
                                    </label>
                                </th>
                                <th>Mã Đơn Hàng</th>
                                <th>Ngày Đặt Hàng</th>
                                <th>Trạng Thái</th>
                                <th>Xem Chi Tiết</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td>
                                        <label class="checkboxs">
                                            <input type="checkbox">
                                            <span class="checkmarks"></span>
                                        </label>
                                    </td>
                                    <td>${order.id}</td>
                                    <td>
                                        <fmt:formatDate value="${order.orderDate}" pattern="MM/dd/yyyy" />
                                    </td>
                                    <td>
                                            <span class="badges
                                                <c:choose>
                                                    <c:when test="${order.status == 'DELIVERING'}">bg-lightgreen</c:when>
                                                    <c:when test="${order.status == 'WAITING_PROCESS'}">bg-warning</c:when>
                                                    <c:when test="${order.status == 'CANCELED'}">bg-danger</c:when>
                                                    <c:when test="${order.status == 'DELIVERED'}">bg-primary</c:when>
                                                    <c:when test="${order.status == 'ACCEPTED'}">bg-info</c:when>
                                                    <c:when test="${order.status == 'REFUNDED'}">bg-secondary</c:when>
                                                    <c:when test="${order.status == 'FEEDBACKED'}">bg-success</c:when>
                                                    <c:otherwise>bg-secondary</c:otherwise>
                                                </c:choose>
                                            ">
                                                    ${order.status}
                                            </span>
                                    </td>
                                    <td>
                                        <a class="me-3" onclick="viewFeedbackCustomer(${order.id})" title="Xem Phản Hồi">
                                            <img src="${pageContext.request.contextPath}/assets/img/icons/edit.svg" alt="Edit">
                                        </a>
                                        <a class="me-3" onclick="viewListProduct(${order.id})" title="Xem Chi Tiết">
                                            <img src="${pageContext.request.contextPath}/assets/img/icons/product.svg" alt="Product">
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <!-- Phân trang -->
                    <div class="container mt-5">
                        <div class="d-flex justify-content-center pagination form-group">
                            <button id="prev-page" type="button" class="btn btn-primary me-2" disabled>&lt;</button>
                            <span id="page-info" class="align-self-center">Page 1 of X</span>
                            <button id="next-page" type="button" class="btn btn-primary ms-2">&gt;</button>
                        </div>
                    </div>
                </div>

            </div>
        </form>
    </div>
</div>
<div class="modal fade" id="feedback">
    <div class="modal-dialog">
        <div class="modal-content" id="feedbackCustomer">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Phản Hồi Của Khách Hàng</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="$('#feedback').modal('hide')">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <p id="feedback-description"></p>
                <div id="feedback-rate">
                </div>
                <div id="imageFeedback" style="margin-top: 10px;">
                    <!-- Danh sách ảnh sẽ được thêm vào đây bằng JavaScript -->
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="$('#feedback').modal('hide')">Hủy Thao Tác</button>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" id="productOfOrderList" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
    <div class="modal-dialog modal-xl" role="document" style="max-width: 90%; width: 90%;">
        <div class="modal-content" id="orderModalContent">
            <div class="modal-header" id="orderModalHeader">
                <h5 class="modal-title" id="modalTitle">Chi Tiết Hóa Đơn</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="$('#productOfOrderList').modal('hide')">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="orderModalBody">
                <!-- Thông tin thanh toán -->
                <div id="paymentInfo">
                    <h5>Thông Tin Thanh Toán</h5>
                    <table>
                        <tr>
                            <td class="payment-label">Tổng chi phí:</td>
                            <td class="payment-value" id="paymentTotalPrice">13,500,000 VNĐ</td>
                        </tr>
                        <tr>
                            <td class="payment-label">Mã giảm giá:</td>
                            <td class="payment-value" id="paymentCoupon">Giảm giá 5%</td>
                        </tr>
                        <tr>
                            <td class="payment-label">Phương thức thanh toán:</td>
                            <td class="payment-value" id="paymentMethod">Cash on Delivery</td>
                        </tr>
                        <tr>
                            <td class="payment-label">Tiền thanh toán:</td>
                            <td class="payment-value" id="paymentMoney">2,000,000 VNĐ</td>
                        </tr>
                    </table>
                </div>
                <!-- Danh sách sản phẩm -->
                <div id="productList">
                    <h5>Danh Sách Sản Phẩm</h5>
                    <div class="table-responsive1">
                        <table class="table table-bordered1">
                            <thead>
                            <tr>
                                <th>STT</th>
                                <th>Nội Thất</th>
                                <th>Mô Tả</th>
                                <th>Giá Một Sản Phẩm</th>
                                <th>Trạng Thái</th>
                                <th>Số Lượng</th>
                                <th>Tổng Chi Phí</th>
                            </tr>
                            </thead>
                            <tbody id="productOrderTableBody">
                            <!-- Dữ liệu sẽ được điền động từ JavaScript -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="modal-footer" id="orderModalFooter">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="$('#productOfOrderList').modal('hide')">Đóng</button>
            </div>
        </div>
    </div>
</div>

<!-- Modal for showing large image -->
<!-- Modal for showing large image -->
<div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="imageModalLabel"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="$('#imageModal').modal('hide')">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <!-- Ảnh lớn sẽ hiển thị ở đây -->
                <img id="largeImage" src="" alt="Large Feedback Image" style="width: 100%; max-height: 600px;"/>
            </div>
        </div>
    </div>
</div>


<script src="scripts/pagination.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/feather.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.slimscroll.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath}/js/dataTables.bootstrap4.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/plugins/select2/js/select2.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalert2.all.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/plugins/sweetalert/sweetalerts.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/script.js"></script>
<script src="${pageContext.request.contextPath}/https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
<script src="${pageContext.request.contextPath}/https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>

<script src="${pageContext.request.contextPath}/ordercustomer/pageorderCustomer.js"></script>
<script src="${pageContext.request.contextPath}/ordercustomer/loadAndSearchOrder.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/ordercustomer/customer.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/ordercustomer/modelDetailBill.css">



<jsp:include page="${pageContext.request.contextPath}/ordercustomer/loadFeedback.jsp"></jsp:include>
<jsp:include page="${pageContext.request.contextPath}/ordercustomer/loadProductOfOrder.jsp"></jsp:include>
<c:import url="footer.jsp"/>