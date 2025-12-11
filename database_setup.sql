-- ================================================
-- SUPABASE DATABASE SETUP FOR LAB LOG BOOK
-- ================================================
-- Execute this SQL in Supabase SQL Editor

-- Create patients table
CREATE TABLE IF NOT EXISTS patients (
    id BIGSERIAL PRIMARY KEY,
    no INTEGER NOT NULL,
    nama TEXT NOT NULL,
    jenis_pemeriksaan TEXT NOT NULL,
    harga DECIMAL(10,2) NOT NULL,
    jasa_petugas DECIMAL(10,2) NOT NULL,
    jasa_dokter DECIMAL(10,2) NOT NULL,
    tanggal DATE NOT NULL,
    petugas TEXT NOT NULL,
    dokter TEXT NOT NULL,
    catatan TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_patients_tanggal ON patients(tanggal);
CREATE INDEX IF NOT EXISTS idx_patients_nama ON patients(nama);
CREATE INDEX IF NOT EXISTS idx_patients_petugas ON patients(petugas);
CREATE INDEX IF NOT EXISTS idx_patients_created_at ON patients(created_at);

-- Enable Row Level Security (RLS)
ALTER TABLE patients ENABLE ROW LEVEL SECURITY;

-- Create policies for public access (adjust as needed)
-- For development/testing - allows all operations
CREATE POLICY "Allow public access for all operations" ON patients
    FOR ALL USING (true);

-- Alternative: More restrictive policy - read-only for public
-- Uncomment the following if you want read-only access
/*
CREATE POLICY "Allow public read access" ON patients
    FOR SELECT USING (true);

CREATE POLICY "Allow authenticated write access" ON patients
    FOR INSERT WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "Allow authenticated update access" ON patients
    FOR UPDATE USING (auth.role() = 'authenticated');

CREATE POLICY "Allow authenticated delete access" ON patients
    FOR DELETE USING (auth.role() = 'authenticated');
*/

-- Add some sample data for testing (optional)
-- Comment out if you want to start with empty table
/*
INSERT INTO patients (
    no, 
    nama, 
    jenis_pemeriksaan, 
    harga, 
    jasa_petugas, 
    jasa_dokter, 
    tanggal, 
    petugas, 
    dokter, 
    catatan
) VALUES 
(
    1,
    'John Doe',
    'Hematologi',
    150000,
    25000,
    50000,
    CURRENT_DATE,
    'Petugas A',
    'Dr. Smith',
    'Pasien baru'
),
(
    2,
    'Jane Doe',
    'Kimia Klinik',
    200000,
    30000,
    75000,
    CURRENT_DATE,
    'Petugas B',
    'Dr. Johnson',
    'Follow up pemeriksaan'
);
*/

-- Create a function to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_patients_updated_at 
    BEFORE UPDATE ON patients 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- Add comments for documentation
COMMENT ON TABLE patients IS 'Tabel untuk menyimpan data pasien laboratorium';
COMMENT ON COLUMN patients.id IS 'Primary key - ID unik pasien';
COMMENT ON COLUMN patients.no IS 'Nomor urut pasien';
COMMENT ON COLUMN patients.nama IS 'Nama lengkap pasien';
COMMENT ON COLUMN patients.jenis_pemeriksaan IS 'Jenis pemeriksaan laboratorium';
COMMENT ON COLUMN patients.harga IS 'Harga pemeriksaan (rupiah)';
COMMENT ON COLUMN patients.jasa_petugas IS 'Jasa untuk petugas laboratorium';
COMMENT ON COLUMN patients.jasa_dokter IS 'Jasa untuk dokter';
COMMENT ON COLUMN patients.tanggal IS 'Tanggal pemeriksaan';
COMMENT ON COLUMN patients.petugas IS 'Nama petugas yang melakukan pemeriksaan';
COMMENT ON COLUMN patients.dokter IS 'Nama dokter yang menangani';
COMMENT ON COLUMN patients.catatan IS 'Catatan tambahan (opsional)';
COMMENT ON COLUMN patients.created_at IS 'Timestamp pembuatan record';
COMMENT ON COLUMN patients.updated_at IS 'Timestamp terakhir update record';

-- ================================================
-- VERIFICATION QUERIES
-- ================================================

-- Check if table was created successfully
SELECT 
    table_name,
    table_type
FROM information_schema.tables 
WHERE table_name = 'patients';

-- Check table structure
\d patients;

-- Check if indexes were created
SELECT 
    indexname,
    indexdef
FROM pg_indexes 
WHERE tablename = 'patients';

-- Check RLS status
SELECT 
    schemaname,
    tablename,
    rowsecurity
FROM pg_tables 
WHERE tablename = 'patients';

-- Check policies
SELECT 
    policyname,
    permissive,
    roles,
    cmd,
    qual
FROM pg_policies 
WHERE tablename = 'patients';

-- ================================================
-- USAGE EXAMPLES
-- ================================================

-- Insert a new patient record
/*
INSERT INTO patients (
    no, 
    nama, 
    jenis_pemeriksaan, 
    harga, 
    jasa_petugas, 
    jasa_dokter, 
    tanggal, 
    petugas, 
    dokter, 
    catatan
) VALUES (
    1,
    'Nama Pasien',
    'Hematologi',
    150000.00,
    25000.00,
    50000.00,
    '2025-12-11',
    'Nama Petugas',
    'Nama Dokter',
    'Catatan tambahan'
);
*/

-- Query all patients
/*
SELECT 
    id,
    no,
    nama,
    jenis_pemeriksaan,
    harga,
    jasa_petugas,
    jasa_dokter,
    (harga + jasa_petugas + jasa_dokter) as total,
    tanggal,
    petugas,
    dokter,
    catatan,
    created_at,
    updated_at
FROM patients
ORDER BY created_at DESC;
*/

-- Query patients by date
/*
SELECT *
FROM patients
WHERE tanggal = '2025-12-11'
ORDER BY no;
*/

-- Update a patient record
/*
UPDATE patients
SET 
    nama = 'Nama Baru',
    harga = 200000.00,
    updated_at = NOW()
WHERE id = 1;
*/

-- Delete a patient record
/*
DELETE FROM patients
WHERE id = 1;
*/

-- ================================================
-- MAINTENANCE QUERIES
-- ================================================

-- Check table size
/*
SELECT 
    pg_size_pretty(pg_total_relation_size('patients')) as table_size,
    pg_size_pretty(pg_relation_size('patients')) as data_size,
    pg_size_pretty(pg_total_relation_size('patients') - pg_relation_size('patients')) as index_size;
*/

-- Check for duplicate entries (if needed)
/*
SELECT 
    no,
    nama,
    tanggal,
    COUNT(*) as duplicate_count
FROM patients
GROUP BY no, nama, tanggal
HAVING COUNT(*) > 1;
*/

-- Clean up old records (if needed - be careful!)
/*
DELETE FROM patients
WHERE created_at < NOW() - INTERVAL '1 year';
*/

-- ================================================
-- END OF SETUP
-- ================================================