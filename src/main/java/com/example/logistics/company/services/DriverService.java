package com.example.logistics.company.services;

import com.example.logistics.company.models.Driver;
import com.example.logistics.company.repositories.DriverRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class DriverService {
    private final DriverRepository driverRepository;

    public List<Driver> getAll() {
        return driverRepository.findAll();
    }

    public List<Driver> getAllWhereVehicleIsNull() {
        return driverRepository.findWhereVehicleNull();
    }

    public Driver getById(Long id) {
        return driverRepository.findById(id).get();
    }

    public Driver create(Driver driver) {
        return driverRepository.save(
                Driver.builder()
                        .name(driver.getName())
                        .vehicle(driver.getVehicle())
                        .contactNumber(driver.getContactNumber())
                        .build()
        );
    }

    public Driver update(Driver driver) {
        return driverRepository.save(
                Driver.builder()
                        .id(driver.getId())
                        .name(driver.getName())
                        .vehicle(driver.getVehicle())
                        .contactNumber(driver.getContactNumber())
                        .build()
        );
    }

    public void deleteById(Long id) {
        driverRepository.deleteById(id);
    }
}
