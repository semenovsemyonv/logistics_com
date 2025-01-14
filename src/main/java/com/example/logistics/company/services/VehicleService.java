package com.example.logistics.company.services;

import com.example.logistics.company.models.Vehicle;
import com.example.logistics.company.repositories.VehicleRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class VehicleService {
    private final VehicleRepository vehicleRepository;

    public Vehicle create(Vehicle vehicle) {
        return vehicleRepository.save(
                Vehicle.builder()
                        .model(vehicle.getModel())
                        .registrationNumber(vehicle.getRegistrationNumber())
                        .status(vehicle.getStatus())
                        .driver(vehicle.getDriver())
                        .build()
        );
    }

    public List<Vehicle> getAll() {
        return vehicleRepository.findAll();
    }

    public Vehicle getById(Long id) {
        return vehicleRepository.findById(id).get();
    }

    public void deleteById(Long id) {
        vehicleRepository.deleteById(id);
    }

    public Vehicle update(Vehicle vehicle) {
        return vehicleRepository.save(
                Vehicle.builder()
                        .id(vehicle.getId())
                        .model(vehicle.getModel())
                        .status(vehicle.getStatus())
                        .registrationNumber(vehicle.getRegistrationNumber())
                        .driver(vehicle.getDriver())
                .build()
        );
    }
}
