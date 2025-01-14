package com.example.logistics.company.dto;

import lombok.*;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PasswordDTO {
    private String oldPassword;
    private String newPassword;
}
