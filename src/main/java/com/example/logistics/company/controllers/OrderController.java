package com.example.logistics.company.controllers;

import com.example.logistics.company.models.Order;
import com.example.logistics.company.services.OrderService;
import com.example.logistics.company.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
@RequestMapping("/order")
public class OrderController {
    private final UserService userService;
    private final OrderService orderService;

    @GetMapping
    public String order(Principal principal, Model model) {
        model.addAttribute("user", userService.getByPrincipal(principal));
        model.addAttribute("orders", orderService.getAll());
        return "order";
    }

    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public String post(Order order) {
        if(order.getId() == null)
            orderService.create(order);
        else
            orderService.update(order);
        return "redirect:/order";
    }

    @PostMapping("/delete/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public String delete(@PathVariable Long id) {
        orderService.deleteById(id);
        return "redirect:/order";
    }
}
