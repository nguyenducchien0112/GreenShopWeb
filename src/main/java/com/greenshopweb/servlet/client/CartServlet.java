package com.greenshopweb.servlet.client;

import com.greenshopweb.beans.Order;
import com.greenshopweb.beans.OrderItem;
import com.greenshopweb.dto.ErrorMessage;
import com.greenshopweb.dto.OrderRequest;
import com.greenshopweb.dto.SuccessMessage;
import com.greenshopweb.service.CartService;
import com.greenshopweb.service.OrderItemService;
import com.greenshopweb.service.OrderService;
import com.greenshopweb.utils.JsonUtils;
import com.greenshopweb.utils.Protector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "CartServlet", value = "/cart")
public class CartServlet extends HttpServlet {
    private final OrderService orderService = new OrderService();
    private final OrderItemService orderItemService = new OrderItemService();
    private final CartService cartService = new CartService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/cartView.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy đối tượng orderRequest từ JSON trong request
        OrderRequest orderRequest = JsonUtils.get(request, OrderRequest.class);

        // Tạo order
        Order order = new Order(
                0L,
                orderRequest.getUserId(),
                1,
                orderRequest.getDeliveryMethod(),
                orderRequest.getDeliveryPrice(),
                LocalDateTime.now(),
                null
        );
        long orderId = Protector.of(() -> orderService.insert(order)).get(0L);

        String successMessage = "Đã đặt hàng và tạo đơn hàng thành công!";
        String errorMessage = "Đã có lỗi truy vấn!";

        Runnable doneFunction = () -> JsonUtils.out(
                response,
                new SuccessMessage(200, successMessage),
                HttpServletResponse.SC_OK);
        Runnable failFunction = () -> JsonUtils.out(
                response,
                new ErrorMessage(404, errorMessage),
                HttpServletResponse.SC_NOT_FOUND);

        if (orderId > 0L) {
            List<OrderItem> orderItems = orderRequest.getOrderItems().stream().map(orderItemRequest -> new OrderItem(
                    0L,
                    orderId,
                    orderItemRequest.getProductId(),
                    orderItemRequest.getPrice(),
                    orderItemRequest.getDiscount(),
                    orderItemRequest.getQuantity(),
                    LocalDateTime.now(),
                    null
            )).collect(Collectors.toList());

            Protector.of(() -> {
                        orderItemService.bulkInsert(orderItems);
                        cartService.delete(orderRequest.getCartId());
                    })
                    .done(r -> doneFunction.run())
                    .fail(e -> failFunction.run());
        } else {
            failFunction.run();
        }
    }
}
