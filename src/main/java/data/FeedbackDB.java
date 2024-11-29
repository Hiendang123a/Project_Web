package data;

import ENumeration.EOrderStatus;
import business.Feedback;
import business.Order;

import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import javax.persistence.TypedQuery;

public class FeedbackDB {
    public static boolean insertFeedback(Feedback feedback) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        EntityTransaction transaction = em.getTransaction();

        try {
            transaction.begin();

            em.persist(feedback);

            // Commit giao dịch nếu cả hai thao tác đều thành công
            transaction.commit();
            return true;
        } catch (RuntimeException e) {
            if (transaction.isActive()) {
                transaction.rollback(); // Rollback nếu có lỗi xảy ra
            }
            return false;

        } finally {
            em.close(); // Đảm bảo đóng EntityManager
        }
    }

    public static Feedback getFeedbackByOrderId(Long orderId) {
        EntityManager em = DBUtil.getEmFactory().createEntityManager();
        try {
            String query = "SELECT f FROM Feedback f WHERE f.order.id = :orderId";
            TypedQuery<Feedback> tq = em.createQuery(query, Feedback.class);
            tq.setParameter("orderId", orderId);
            return tq.getSingleResult();
        } catch (Exception e) {
            return null;
        } finally {
            em.close();
        }
    }
}