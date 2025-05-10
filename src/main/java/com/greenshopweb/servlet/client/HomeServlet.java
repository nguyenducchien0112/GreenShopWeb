package com.greenshopweb.servlet.client;

import com.greenshopweb.beans.Category;
import com.greenshopweb.beans.Product;
import com.greenshopweb.service.CategoryService;
import com.greenshopweb.service.ProductService;
import com.greenshopweb.utils.Protector;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "HomeServlet", value = "")
public class HomeServlet extends HttpServlet {
    private final CategoryService categoryService = new CategoryService();
    private final ProductService productService = new ProductService();

    private static final int PRODUCTS_PER_CATEGORY = 9; // Số sản phẩm hiển thị cho mỗi danh mục

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> categories = Protector.of(() -> categoryService.getAll())
                .get(ArrayList::new);

        Map<Category, List<Product>> productsByCategory = new HashMap<>();

        for (Category category : categories) {
            List<Product> productsInCategory = Protector.of(() ->
                            productService.getOrderedPartByCategoryId(PRODUCTS_PER_CATEGORY, 0, "createdAt", "DESC", category.getId()))
                    .get(ArrayList::new);
            productsByCategory.put(category, productsInCategory);
        }

        request.setAttribute("productsByCategory", productsByCategory);
        request.setAttribute("categories", categories);

        request.getRequestDispatcher("/WEB-INF/views/homeView.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {}
}