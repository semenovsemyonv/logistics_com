package com.example.logistics.company.controllers;

import com.example.logistics.company.models.Status;
import com.example.logistics.company.services.StatusService;
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
@RequestMapping("/status")
public class StatusController {
    private final UserService userService;
    private final StatusService statusService;

    @GetMapping
    public String status(Principal principal, Model model) {
        model.addAttribute("user", userService.getByPrincipal(principal));
        model.addAttribute("statuses", statusService.getAll());
        return "status";
    }

    @PostMapping
    @PreAuthorize("hasRole('ADMIN')")
    public String post(Status status) {
        if(status.getId() == null)
            statusService.create(status);
        else
            statusService.update(status);
        return "redirect:/status";
    }

    @PostMapping("/delete/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public String delete(@PathVariable Long id) {
        statusService.deleteById(id);
        return "redirect:/status";
    }
}
