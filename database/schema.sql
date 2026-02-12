-- Esquema de Base de Datos para Agente de Búsqueda Laboral
-- Compatible con PostgreSQL

CREATE TABLE IF NOT EXISTS job_offers (
    id SERIAL PRIMARY KEY,
    hash_id VARCHAR(64) UNIQUE NOT NULL, -- Hash generado (MD5/SHA256) de URL o Título+Empresa para evitar duplicados
    
    -- Datos Crudos
    title VARCHAR(255) NOT NULL,
    company VARCHAR(255),
    location VARCHAR(255),
    url TEXT NOT NULL,
    description TEXT,
    salary_raw VARCHAR(255),
    
    -- Metadatos del Origen
    source_portal VARCHAR(50) NOT NULL, -- Ej: 'LinkedIn', 'Computrabajo', 'ZonaJobs'
    posted_date DATE, -- Fecha de publicación extraída
    discovered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Datos Normalizados (Llenados por el Agente/IA)
    normalized_role VARCHAR(100), -- Ej: 'Frontend', 'Backend', 'DevOps'
    normalized_seniority VARCHAR(50), -- Ej: 'Junior', 'Senior', 'Traill'
    normalized_modality VARCHAR(50), -- Ej: 'Remote', 'Hybrid', 'OnSite'
    tech_stack TEXT[], -- Array de tecnologías detectadas: ['React', 'Node.js']
    match_score DECIMAL(5, 2), -- Puntaje de afinidad (0-100)
    
    -- Estado del Proceso
    status VARCHAR(20) DEFAULT 'new', -- 'new', 'analyzed', 'applied', 'discarded'
    is_active BOOLEAN DEFAULT TRUE
);

CREATE INDEX idx_job_hash ON job_offers(hash_id);
CREATE INDEX idx_job_status ON job_offers(status);
CREATE INDEX idx_job_score ON job_offers(match_score DESC);
