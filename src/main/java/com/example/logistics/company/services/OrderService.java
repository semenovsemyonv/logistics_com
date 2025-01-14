package com.example.logistics.company.services;

import com.example.logistics.company.models.Order;
import com.example.logistics.company.repositories.OrderRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderService {
    private final OrderRepository orderRepository;

    public List<Order> getAll() {
        return orderRepository.findAll();
    }

    public List<Order> getByWarehouse(Long id) {
        return orderRepository.findByWarehouseId(id);
    }

    public Order getById(Long id) {
        return orderRepository.findById(id).get();
    }

    public Order create(Order order) {
        return orderRepository.save(
                Order.builder()
                        .number(order.getNumber())
                        .address(order.getAddress())
                        .weight(order.getWeight())
                        .build()
        );
    }

    public Order update(Order order) {
        return orderRepository.save(
                Order.builder()
                        .id(order.getId())
                        .number(order.getNumber())
                        .address(order.getAddress())
                        .weight(order.getWeight())
                        .build()
        );
    }

    public void deleteById(Long id) {
        orderRepository.deleteById(id);
    }
}
