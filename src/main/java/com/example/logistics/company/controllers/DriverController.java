package com.example.logistics.company.controllers;

import com.example.logistics.company.models.Driver;
import com.example.logistics.company.services.DriverService;
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
@RequestMapping("/driver")
public class DriverController {
    private final DriverService driverService;
    private final UserService userService;

    @GetMapping
    public String driver(Principal principal, Model model) {
        model.addAttribute("user", userService.getByPrincipal(principal));
        model.addAttribute("drivers", driverService.getAll());
        return "driver";
    }

    @PostMapping
    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    public String post(Driver driver) {
        if (driver.getId() == null)
            driverService.create(driver);
        else
            driverService.update(driver);
        return "redirect:/driver";
    }

    @PostMapping("/delete/{id}")
    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    public String delete(@PathVariable Long id) {
        driverService.deleteById(id);
        return "redirect:/driver";
    }
}
