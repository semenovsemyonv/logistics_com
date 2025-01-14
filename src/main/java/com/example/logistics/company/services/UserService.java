package com.example.logistics.company.services;

import com.example.logistics.company.dto.PasswordDTO;
import com.example.logistics.company.models.Role;
import com.example.logistics.company.models.User;
import com.example.logistics.company.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.util.List;
import java.util.Set;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public User create(User user) {
        if (userRepository.existsByEmail(user.getEmail())) {
            return null;
        }
        return userRepository.save(
                User.builder()
                        .name(user.getName())
                        .email(user.getEmail())
                        .password(passwordEncoder.encode(user.getPassword()))
                        .contactNumber(user.getContactNumber())
                        .warehouse(user.getWarehouse())
                        .roles(user.getRoles().isEmpty() ? Set.of(Role.ROLE_USER) : user.getRoles())
                        .build()
        );
    }

    public User updateByAdmin(User user) {
        if (user.getPassword().isEmpty()) {
            return userRepository.save(
                    User.builder()
                            .id(user.getId())
                            .name(user.getName())
                            .email(user.getEmail())
                            .contactNumber(user.getContactNumber())
                            .password(userRepository.findById(user.getId()).get().getPassword())
                            .warehouse(user.getWarehouse())
                            .roles(user.getRoles().isEmpty() ? Set.of(Role.ROLE_USER) : user.getRoles())
                            .build()
            );
        }
        else {
            return userRepository.save(
                    User.builder()
                            .id(user.getId())
                            .name(user.getName())
                            .email(user.getEmail())
                            .password(passwordEncoder.encode(user.getPassword()))
                            .contactNumber(user.getContactNumber())
                            .warehouse(user.getWarehouse())
                            .roles(user.getRoles().isEmpty() ? Set.of(Role.ROLE_USER) : user.getRoles())
                            .build()
            );
        }
    }

    public User updatePasswordByPrincipal(Principal principal, PasswordDTO passwordDTO) {
        User principalUser = userRepository.findByEmail(principal.getName());
        if(passwordEncoder.matches(passwordDTO.getOldPassword(), principalUser.getPassword())) {
            return userRepository.save(
                    User.builder()
                            .id(principalUser.getId())
                            .password(passwordEncoder.encode(passwordDTO.getNewPassword()))
                            .email(principalUser.getEmail())
                            .roles(principalUser.getRoles())
                            .contactNumber(principalUser.getContactNumber())
                            .warehouse(principalUser.getWarehouse())
                            .name(principalUser.getName())
                            .build()
            );
        }
        else {
            return null;
        }
    }

    public User getByPrincipal(Principal principal) {
        if (principal == null)
            return null;
        return userRepository.findByEmail(principal.getName());
    }

    public User getById(Long id) {
        return userRepository.findById(id).get();
    }

    public List<User> getAll() {
        return userRepository.findAll();
    }

    public void deleteById(Long id) {
        userRepository.deleteById(id);
    }

    public void registerAdmin() {
        userRepository.save(
            User.builder()
                    .name("admin")
                    .contactNumber("")
                    .email("admin@admin")
                    .password(passwordEncoder.encode("admin"))
                    .roles(Set.of(Role.ROLE_ADMIN))
                    .build()
        );
    }
}
