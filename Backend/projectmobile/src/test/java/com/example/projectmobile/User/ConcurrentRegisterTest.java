package com.example.projectmobile.User;

import com.example.projectmobile.Dto.RegisterDtoUser;
import com.example.projectmobile.service.UserService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

@SpringBootTest
public class ConcurrentRegisterTest {

    @Autowired
    private UserService userService;

    @Test
    public void testConcurrentRegister() throws InterruptedException {

        int numberOfThreads = 10;
        ExecutorService executor = Executors.newFixedThreadPool(numberOfThreads);

        for (int i = 0; i < numberOfThreads; i++) {
            int finalI = i;

            executor.submit(() -> {
                try {
                    RegisterDtoUser userDto = new RegisterDtoUser();
                    userDto.setName("User " + finalI);
                    userDto.setEmail("test" + finalI + "@example.com");
                    userDto.setPassword("123456");
                    userDto.setConfirm_password("123456");
                    userDto.setNumberphone("0123456789");

                    String result = userService.registerUser(userDto);
                    System.out.println("Thread " + finalI + ": " + result);

                } catch (Exception e) {
                    System.out.println("Thread " + finalI + " Error: " + e.getMessage());
                }
            });
        }

        executor.shutdown();
        executor.awaitTermination(10, TimeUnit.SECONDS);
    }
}
