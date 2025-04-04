package com.davydovskyi.crm.repository;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.davydovskyi.crm.entity.Organization;

@Repository
public interface OrganizationRepository extends JpaRepository<Organization, UUID> {

}