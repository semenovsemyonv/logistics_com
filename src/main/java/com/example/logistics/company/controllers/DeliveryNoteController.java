package com.example.logistics.company.controllers;

import com.example.logistics.company.models.DeliveryNote;
import com.example.logistics.company.services.*;
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
@RequestMapping("/delivery_note")
public class DeliveryNoteController {
    private final UserService userService;
    private final DeliveryNoteService deliveryNoteService;
    private final VehicleService vehicleService;
    private final OrderService orderService;

    @GetMapping
    public String deliveryNote(Principal principal, Model model) {
        model.addAttribute("user", userService.getByPrincipal(principal));
        model.addAttribute("deliveryNotes", deliveryNoteService.getAll());
        model.addAttribute("users", userService.getAll());
        model.addAttribute("vehicles", vehicleService.getAll());
        model.addAttribute("orders", orderService.getAll());
        return "delivery_note";
    }

    @GetMapping("/add")
    public String addDeliveryNote(Principal principal, Model model) {
        model.addAttribute("user", userService.getByPrincipal(principal));
        model.addAttribute("deliveryNotes", deliveryNoteService.getAll());
        model.addAttribute("users", userService.getAll());
        model.addAttribute("vehicles", vehicleService.getAll());
        model.addAttribute("orders", orderService.getAll());
        return "add_delivery_note";
    }

    @PostMapping("/add")
    public String postAdd(DeliveryNote deliveryNote) {
            deliveryNoteService.create(deliveryNote);

        return "redirect:/warehouse/my";
    }

    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public String post(DeliveryNote deliveryNote) {
        if(deliveryNote.getId() == null)
            deliveryNoteService.create(deliveryNote);
        else
            deliveryNoteService.update(deliveryNote);

        return "redirect:/delivery_note";
    }

    @PostMapping("/delete/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public String delete(@PathVariable Long id) {
        deliveryNoteService.deleteById(id);

        return "redirect:/delivery_note";
    }
}
