package com.example.logistics.company.services;

import com.example.logistics.company.models.DeliveryNote;
import com.example.logistics.company.repositories.DeliveryNoteRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class DeliveryNoteService {
    private final DeliveryNoteRepository deliveryNoteRepository;

    public List<DeliveryNote> getAll() {
        return deliveryNoteRepository.findAll();
    }

    public List<DeliveryNote> getByWarehouse(Long id) {
        return deliveryNoteRepository.findByWarehouseId(id);
    }

    public DeliveryNote getById(Long id) {
        return deliveryNoteRepository.findById(id).get();
    }

    public DeliveryNote create(DeliveryNote deliveryNote) {
        return deliveryNoteRepository.save(
                DeliveryNote.builder()
                        .user(deliveryNote.getUser())
                        .vehicle(deliveryNote.getVehicle())
                        .order(deliveryNote.getOrder())
                        .date(deliveryNote.getDate())
                        .acceptance(deliveryNote.isAcceptance())
                        .commentary(deliveryNote.getCommentary())
                        .build()
        );
    }

    public DeliveryNote update(DeliveryNote deliveryNote) {
        return deliveryNoteRepository.save(
                DeliveryNote.builder()
                        .id(deliveryNote.getId())
                        .user(deliveryNote.getUser())
                        .vehicle(deliveryNote.getVehicle())
                        .order(deliveryNote.getOrder())
                        .date(deliveryNote.getDate())
                        .acceptance(deliveryNote.isAcceptance())
                        .commentary(deliveryNote.getCommentary())
                        .build()
        );
    }

    public void deleteById(Long id) {
        deliveryNoteRepository.deleteById(id);
    }
}
