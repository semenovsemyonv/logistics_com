package com.example.logistics.company.repositories;

import com.example.logistics.company.models.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderRepository  extends JpaRepository<Order, Long> {
    @Query(
            value = "SELECT * FROM orders o\n" +
                    "WHERE o.id IN (\n" +
                    "\tSELECT dn.order_id FROM delivery_notes dn WHERE date =\n" +
                    "\t(SELECT MAX(date) FROM delivery_notes dn2 WHERE dn.order_id = dn2.order_id)\n" +
                    "\tAND dn.acceptance = true\n" +
                    "\tAND dn.user_id IN (SELECT u.id FROM users u WHERE u.warehouse_id = :warehouseId)\n" +
                    "\tORDER BY dn.order_id\n" +
                    ")\n",
            nativeQuery = true)
    List<Order> findByWarehouseId(@Param("warehouseId") Long id);
}
