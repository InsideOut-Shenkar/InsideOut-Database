-- Connect to the Database
\c InsideOutDB;

-- Disable Foreign Key Checks
SET session_replication_role = 'replica';

-- Create a function to drop all tables
DO $$
DECLARE
    r RECORD;
BEGIN
    -- Loop through all table names in the current database
    FOR r IN (SELECT tablename FROM pg_tables WHERE schemaname = 'public') LOOP
        -- Drop each table
        EXECUTE 'DROP TABLE IF EXISTS ' || quote_ident(r.tablename) || ' CASCADE';
    END LOOP;
END $$;

-- Enable Foreign Key Checks
SET session_replication_role = 'origin';
