package com.example.projectmobile.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(value = HttpStatus.NOT_FOUND)
public class ResoutNotFoundException extends RuntimeException {
    public ResoutNotFoundException(String message) {
        super(message);
    }
}
