package com.davydovskyi.crm.service;

import java.util.UUID;

import org.springframework.stereotype.Component;

import com.davydovskyi.crm.entity.Organization;
import com.davydovskyi.crm.repository.OrganizationRepository;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class OrganizationService {
    private final OrganizationRepository organizationRepository;

    public UUID createOrganization(String name) {
        var organization = new Organization(name);
        organizationRepository.save(organization);
        return organization.getId();
    }

    public Organization getOrganization(UUID id) {
        return organizationRepository.findById(id).orElse(null);
    }

    public void updateOrganization(UUID id, String name) {
        Organization organization = getOrganization(id);
        if (organization != null) {
            organization.setName(name);
            organizationRepository.save(organization);
        }
    }

    public void deleteOrganization(UUID id) {
        organizationRepository.deleteById(id);
    }
}
