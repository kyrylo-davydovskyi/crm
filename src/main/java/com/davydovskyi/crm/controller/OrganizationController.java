package com.davydovskyi.crm.controller;

import java.util.UUID;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.davydovskyi.crm.dto.organization.CreateOrganizationRequest;
import com.davydovskyi.crm.dto.organization.CreateOrganizationResponse;
import com.davydovskyi.crm.service.OrganizationService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/organizations")
public class OrganizationController {
    private final OrganizationService organizationService;

    @RequestMapping(path = "/create", method = RequestMethod.POST)
    public ResponseEntity<CreateOrganizationResponse> createOrganization(CreateOrganizationRequest request) {
        var id = organizationService.createOrganization(request.getName());
        var response = new CreateOrganizationResponse(id.toString(), request.getName());
        return ResponseEntity.ok(response);
    }

    @RequestMapping(path = "/{id}", method = RequestMethod.GET)
    public ResponseEntity<CreateOrganizationResponse> getOrganization(UUID id) {
        var organization = organizationService.getOrganization(id);
        if (organization == null) {
            return ResponseEntity.notFound().build();
        }
        var response = new CreateOrganizationResponse(organization.getId().toString(), organization.getName());
        return ResponseEntity.ok(response);
    }
}
