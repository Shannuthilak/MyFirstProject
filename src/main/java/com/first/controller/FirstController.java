package com.first.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/first")
@RequiredArgsConstructor
public class FirstController {

	@GetMapping("/view")
	public ResponseEntity<String> viewFirstPage() {
		return ResponseEntity.ok().body("Hello!");
	}
}
