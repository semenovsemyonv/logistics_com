package com.example.logistics.company.controllers;

import com.example.logistics.company.dto.PasswordDTO;
import com.example.logistics.company.models.Role;
import com.example.logistics.company.models.User;
import com.example.logistics.company.services.UserService;
import com.example.logistics.company.services.WarehouseService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;
    private final WarehouseService warehouseService;

    @GetMapping("/register_admin")
    public void registerAdmin() {
        userService.registerAdmin();
    }

    @GetMapping("/settings")
    public String settings(Principal principal, Model model) {
        model.addAttribute("user", userService.getByPrincipal(principal));
        return "settings";
    }

    @PostMapping("/settings")
    public String postSettings(Principal principal, PasswordDTO passwordDTO) {
        userService.updatePasswordByPrincipal(principal, passwordDTO);
        return "redirect:/";
    }

    @GetMapping
    public String mainPage(Principal principal, Model model) {
        model.addAttribute("user", userService.getByPrincipal(principal));
        return "index";
    }

    @GetMapping("/login")
    public String login(Principal principal, Model model) {
        if(principal == null) {
            return "login";
        } else {
            model.addAttribute("user", userService.getByPrincipal(principal));
            return "index";
        }
    }

    @PostMapping("/user")
    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    public String registration(User user) {
        if(user.getId() == null)
            userService.create(user);
        else
            userService.updateByAdmin(user);
        return "redirect:/user";
    }

    @GetMapping("/user")
    public String user(Principal principal, Model model) {
        model.addAttribute("user", userService.getByPrincipal(principal));
        model.addAttribute("users", userService.getAll());
        model.addAttribute("warehouses", warehouseService.getAll());

        model.addAttribute("roles", Role.values());
        return "user";
    }

    @PostMapping("/user/delete/{id}")
    @PreAuthorize("hasAuthority('ROLE_ADMIN')")
    public String delete(@PathVariable Long id) {
        userService.deleteById(id);
        return "redirect:/user";
    }
}
