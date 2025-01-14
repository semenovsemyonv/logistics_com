package com.example.logistics.company.repositories;

import com.example.logistics.company.models.Status;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StatusRepository  extends JpaRepository<Status, Long> {
}
