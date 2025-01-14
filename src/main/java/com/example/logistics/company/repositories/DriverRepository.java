package com.example.logistics.company.repositories;

import com.example.logistics.company.models.Driver;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DriverRepository extends JpaRepository<Driver, Long> {
    @Query(
            value = "SELECT d.id, d.contact_number, d.name FROM drivers d\n" +
                    "LEFT JOIN vehicles v ON d.id = v.driver_id\n" +
                    "WHERE v.driver_id IS NULL",
            nativeQuery = true)
    List<Driver> findWhereVehicleNull();
}
