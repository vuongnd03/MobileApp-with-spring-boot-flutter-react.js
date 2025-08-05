package com.example.projectmobile.responsity;

import com.example.projectmobile.model.Admin;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface AdminReponsity extends JpaRepository<Admin, Integer> {
    Optional<Admin> findByemail(String email);
}
