package com.example.logistics.company.services;

import com.example.logistics.company.models.Warehouse;
import com.example.logistics.company.repositories.WarehouseRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class WarehouseService {
    private final WarehouseRepository warehouseRepository;

    public List<Warehouse> getAll() {
        return warehouseRepository.findAll();
    }

    public Warehouse getById(Long id) {
        return warehouseRepository.findById(id).get();
    }

    public Warehouse create(Warehouse warehouse) {
        return warehouseRepository.save(
                Warehouse.builder()
                        .address(warehouse.getAddress())
                        .build()
        );
    }

    public Warehouse update(Warehouse warehouse) {
        return warehouseRepository.save(
                Warehouse.builder()
                        .id(warehouse.getId())
                        .address(warehouse.getAddress())
                        .build()
        );
    }

    public void deleteById(Long id) {
        warehouseRepository.deleteById(id);
    }
}
