-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ========== ORGANIZATIONS ==========
CREATE TABLE organizations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- ========== EMPLOYEES ==========
CREATE TABLE employees (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    organization_id UUID REFERENCES organizations ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    role VARCHAR(30) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- ========== EMPLOYEE IN ORG ROLES ==========
CREATE TABLE employee_organization_roles (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    employee_id UUID REFERENCES employees ON DELETE CASCADE,
    organization_id UUID REFERENCES organizations ON DELETE CASCADE,
    role VARCHAR(30) NOT NULL,
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    UNIQUE (employee_id, organization_id)
);

-- ========== CLIENTS ==========
CREATE TABLE clients (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    organization_id UUID REFERENCES organizations ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- ========== LOCATIONS ==========
CREATE TABLE locations (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    organization_id UUID REFERENCES organizations ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    address TEXT,
    timezone VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- ========== EVENT SERIES ==========
CREATE TABLE event_series (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    organization_id UUID REFERENCES organizations ON DELETE CASCADE,
    employee_id UUID REFERENCES employees ON DELETE CASCADE,
    client_id UUID REFERENCES clients ON DELETE SET NULL,
    location_id UUID REFERENCES locations ON DELETE SET NULL,
    title VARCHAR(255),
    recurrence_rule TEXT,
    start_date TIMESTAMP NOT NULL,
    end_date TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- ========== EVENTS ==========
CREATE TABLE events (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    series_id UUID REFERENCES event_series ON DELETE SET NULL,
    organization_id UUID REFERENCES organizations ON DELETE CASCADE,
    employee_id UUID REFERENCES employees ON DELETE CASCADE,
    client_id UUID REFERENCES clients ON DELETE SET NULL,
    location_id UUID REFERENCES locations ON DELETE SET NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    status VARCHAR(20) DEFAULT 'scheduled',
    meeting_link TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL
);

-- ========== EVENT EXCEPTIONS ==========
CREATE TABLE event_exceptions (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    series_id UUID REFERENCES event_series ON DELETE CASCADE,
    exception_date TIMESTAMP NOT NULL,
    reason TEXT
);
