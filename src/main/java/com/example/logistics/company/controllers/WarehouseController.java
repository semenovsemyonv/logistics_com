package com.example.logistics.company.controllers;

import com.example.logistics.company.models.Warehouse;
import com.example.logistics.company.services.DeliveryNoteService;
import com.example.logistics.company.services.OrderService;
import com.example.logistics.company.services.UserService;
import com.example.logistics.company.services.WarehouseService;
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
@RequestMapping("/warehouse")
public class WarehouseController {
    private final UserService userService;
    private final WarehouseService warehouseService;
    private final OrderService orderService;
    private final DeliveryNoteService deliveryNoteService;

    @GetMapping("/{id}")
    public String ordersByWarehouse(@PathVariable Long id, Principal principal, Model model) {
        model.addAttribute("user", userService.getByPrincipal(principal));
        model.addAttribute("warehouse", warehouseService.getById(id));
        model.addAttribute("orders", orderService.getByWarehouse(id));
        model.addAttribute("deliveryNotes", deliveryNoteService.getByWarehouse(id));
        return "concrete_warehouse";
    }

    @GetMapping("/my")
    public String ordersByMyWarehouse(Principal principal, Model model) {
        model.addAttribute("user", userService.getByPrincipal(principal));
        model.addAttribute("warehouse", warehouseService.getById(userService.getByPrincipal(principal).getWarehouse().getId()));
        model.addAttribute("orders", orderService.getByWarehouse(userService.getByPrincipal(principal).getWarehouse().getId()));
        model.addAttribute("deliveryNotes", deliveryNoteService.getByWarehouse(userService.getByPrincipal(principal).getWarehouse().getId()));
        return "concrete_warehouse";
    }

    @GetMapping
    public String warehouse(Principal principal, Model model) {
        model.addAttribute("user", userService.getByPrincipal(principal));
        model.addAttribute("warehouses", warehouseService.getAll());
        return "warehouse";
    }

    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public String post(Warehouse warehouse) {
        if(warehouse.getId() == null)
            warehouseService.create(warehouse);
        else
            warehouseService.update(warehouse);
        return "redirect:/warehouse";
    }

    @PostMapping("/delete/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public String delete(@PathVariable Long id) {
        warehouseService.deleteById(id);
        return "redirect:/warehouse";
    }
}
