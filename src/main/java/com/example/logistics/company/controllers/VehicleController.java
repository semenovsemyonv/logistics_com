package com.example.logistics.company.controllers;

import com.example.logistics.company.models.Vehicle;
import com.example.logistics.company.services.DriverService;
import com.example.logistics.company.services.StatusService;
import com.example.logistics.company.services.UserService;
import com.example.logistics.company.services.VehicleService;
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
@RequestMapping("/vehicle")
public class VehicleController {
    private final UserService userService;
    private final VehicleService vehicleService;
    private final StatusService statusService;
    private final DriverService driverService;

    @GetMapping
    public String vehicle(Principal principal, Model model) {
        model.addAttribute("user", userService.getByPrincipal(principal));
        model.addAttribute("vehicles", vehicleService.getAll());
        model.addAttribute("statuses", statusService.getAll());
        model.addAttribute("freeDrivers", driverService.getAllWhereVehicleIsNull());
        return "vehicle";
    }

    @PostMapping
    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    public String post(Vehicle vehicle) {
        if(vehicle.getId() == null)
            vehicleService.create(vehicle);
        else
            vehicleService.update(vehicle);
        return "redirect:/vehicle";
    }

    @PostMapping("/delete/{id}")
    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    public String delete(@PathVariable Long id) {
        vehicleService.deleteById(id);
        return "redirect:/vehicle";
    }
}
