package com.example.projectmobile.model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import java.time.LocalDateTime;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "ResetPass")
public class ForgotPassword {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String otp;
    @Column(name = "real_time")
    private LocalDateTime realtime;

    @ManyToOne
    @JoinColumn(name = "userId")
    private User user;
}
