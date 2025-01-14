package com.example.logistics.company.repositories;

import com.example.logistics.company.models.DeliveryNote;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DeliveryNoteRepository extends JpaRepository<DeliveryNote, Long> {
    @Query(
            value = "SELECT * FROM delivery_notes dn\n" +
                    "    WHERE dn.user_id IN (SELECT u.id FROM users u WHERE u.warehouse_id = :warehouseId)\n" +
                    "    ORDER BY dn.date DESC",
            nativeQuery = true)
    List<DeliveryNote> findByWarehouseId(@Param("warehouseId") Long id);
}
