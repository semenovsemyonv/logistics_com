package com.example.logistics.company.repositories;

import com.example.logistics.company.models.Warehouse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface WarehouseRepository  extends JpaRepository<Warehouse, Long> {
}
