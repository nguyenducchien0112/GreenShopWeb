package com.greenshopweb.servlet.admin.product;

import com.greenshopweb.beans.Category;
import com.greenshopweb.beans.Product;
import com.greenshopweb.service.CategoryService;
import com.greenshopweb.service.ProductService;
import com.greenshopweb.utils.Protector;
import com.greenshopweb.utils.TextUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;

@WebServlet(name = "ProductDetailServlet", value = "/admin/productManager/detail")
public class ProductDetailServlet extends HttpServlet {
    private final ProductService productService = new ProductService();
    private final CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        long id = Protector.of(() -> Long.parseLong(request.getParameter("id"))).get(0L);
        Optional<Product> productFromServer = Protector.of(() -> productService.getById(id)).get(Optional::empty);

        if (productFromServer.isPresent()) {
            Product product = productFromServer.get();
            product.setDescription(TextUtils.toParagraph(Optional.ofNullable(product.getDescription()).orElse("")));

            Optional<Category> categoryFromServer = Protector.of(() -> categoryService.getByProductId(id)).get(Optional::empty);

            request.setAttribute("product", product);
            request.setAttribute("category", categoryFromServer.orElseGet(Category::new));
            request.getRequestDispatcher("/WEB-INF/views/productDetailView.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/productManager");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}
}
