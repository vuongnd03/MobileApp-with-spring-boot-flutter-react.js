package com.example.projectmobile.responsity;

import com.example.projectmobile.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UserReponsity extends JpaRepository<User, Integer> {
    Optional<User> findByemail(String email);
    Optional<User> findById(Integer userid);
}
