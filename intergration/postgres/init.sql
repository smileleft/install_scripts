-- init.sql
-- reports table

CREATE DATABASE sadb;
\connect sadb;

CREATE TABLE IF NOT EXISTS reports (
  id                  BIGSERIAL PRIMARY KEY,
  message_id          VARCHAR,
  report_path         TEXT,
  format              VARCHAR,
  create_dt           TIMESTAMPTZ,
  update_dt           TIMESTAMPTZ,
  create_user_id      VARCHAR,
  last_update_user_id VARCHAR,
  title               TEXT,
  category            VARCHAR,
  type                VARCHAR,
  security_level      VARCHAR,
  identification_details TEXT
);

CREATE INDEX IF NOT EXISTS idx_reports_type_createdt ON reports (type, create_dt DESC);

CREATE INDEX IF NOT EXISTS idx_reports_title ON reports (title);

-- targets table
CREATE TABLE IF NOT EXISTS targets (
  id          BIGSERIAL PRIMARY KEY,
  report_id   BIGINT NOT NULL,
  target_id   VARCHAR,
  category    VARCHAR,
  report_type VARCHAR,
  be_number   VARCHAR,
  mgrs        VARCHAR,
  latlon      JSONB,
  FOREIGN KEY (report_id) REFERENCES reports(id)
);

-- index creation for report_id of targets table
CREATE INDEX IF NOT EXISTS idx_targets_report_id ON targets (report_id);


-- imagery table
CREATE TABLE IF NOT EXISTS imagery (
  id                BIGSERIAL PRIMARY KEY,
  report_id         BIGINT NOT NULL,
  imagery_path      TEXT,
  acquisition_time  TIMESTAMPTZ,
  registration_time TIMESTAMPTZ,
  satellite         VARCHAR,
  coverage_wkt      TEXT,
  tilt_angle        NUMERIC,
  pitch_angle       NUMERIC,
  azimuth_angle     NUMERIC,
  FOREIGN KEY (report_id) REFERENCES reports(id)
);


CREATE INDEX IF NOT EXISTS idx_imagery_report_id ON imagery (report_id);

CREATE TYPE role AS ENUM ('admin', 'viewer');

-- users table
CREATE TABLE users (
    id 			UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    empNumber		TEXT UNIQUE NOT NULL,
    username 		TEXT NOT NULL,
    password_hash 	TEXT NOT NULL,
    role 		role NOT NULL,
    created_at 		TIMESTAMPTZ DEFAULT now(),
    last_login 		TIMESTAMPTZ
);


-- audit_logs table
CREATE TABLE audit_logs (
    id 		BIGSERIAL PRIMARY KEY,
    type 	TEXT NOT NULL,
    user_id 	UUID REFERENCES users(id) ON DELETE SET NULL,
    ip 		TEXT,
    details 	TEXT,
    timestamp 	TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_audit_logs_type_timestamp ON audit_logs (type, timestamp DESC);

CREATE INDEX IF NOT EXISTS idx_audit_logs_user_id ON audit_logs (user_id);

\connect postgres;

CREATE DATABASE grafana;

CREATE DATABASE infisical;
