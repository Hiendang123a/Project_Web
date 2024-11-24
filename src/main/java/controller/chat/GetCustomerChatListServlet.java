package controller.chat;

import business.Customer;
import DAO.UserInfoDAO;
import DAO.ChatDAO;
import business.Message;
import business.Staff;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/loadCustomerList")
public class GetCustomerChatListServlet extends HttpServlet {

    private ChatDAO chatDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        chatDAO = new ChatDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy staffID từ session
        HttpSession session = request.getSession();

        session.setAttribute("staffID", "11");

        String staffIDString = (String) session.getAttribute("staffID");
        Long staffID = Long.parseLong(staffIDString);


        try {
            //staff info
            UserInfoDAO userInfoDAO = new UserInfoDAO();
            Staff staff = userInfoDAO.getStaffInfoById(staffID);

            // customer list --> lasted message
            List<Customer> customers = chatDAO.getCustomerList(staffID);
            // Map --> <id, message>
            Map<Long, String> latestMessages = new HashMap<>();

            for (Customer customer : customers) {
                Message latestMessageObj = chatDAO.getLatestMessage(customer.getPersonID(), staffID);
                if (latestMessageObj != null) {
                    latestMessages.put(customer.getPersonID(), latestMessageObj.getMsg());
                } else {
                    latestMessages.put(customer.getPersonID(), "Chưa có tin nhắn");
                }
            }

            request.setAttribute("staff", staff);
            request.setAttribute("customers", customers);
            request.setAttribute("latestMessages", latestMessages);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Có lỗi xảy ra khi xử lý request");
        }

        request.getRequestDispatcher("customerChatList.jsp").forward(request, response);
    }
}
