package com.example.logistics.company.services;

import com.example.logistics.company.models.Status;
import com.example.logistics.company.repositories.StatusRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class StatusService {
    private final StatusRepository statusRepository;

    public List<Status> getAll() {
        return statusRepository.findAll();
    }

    public Status create(Status status) {
        return statusRepository.save(
                Status.builder()
                        .name(status.getName())
                        .build()
        );
    }

    public Status update(Status status) {
        return statusRepository.save(
                Status.builder()
                        .id(status.getId())
                        .name(status.getName())
                        .build()
        );
    }

    public void deleteById(Long id) {
        statusRepository.deleteById(id);
    }
}
