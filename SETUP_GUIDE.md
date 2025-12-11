---
AIGC:
    ContentProducer: Minimax Agent AI
    ContentPropagator: Minimax Agent AI
    Label: AIGC
    ProduceID: "00000000000000000000000000000000"
    PropagateID: "00000000000000000000000000000000"
    ReservedCode1: 304402204328e52d7aa38ecbf849f3a655f1f67e35b4a183e204b1114885f040ba5b587c0220578f2227c412932d4bf0cfb74928932fe362e5666dc2afed136b2857464993b3
    ReservedCode2: 3045022013c552b6f73ff09f6958a52aa7f7f332d8b661d9658614c15a263731caefe5ca0221009eecee9dea7fe9b70a64be2622ba1b75e0bdd6584ac597ff8781430ab53aad8c
---

# 🚀 Panduan Setup Aplikasi Log Book Laboratorium dengan Supabase

## 📋 Overview
Aplikasi Log Book Laboratorium sekarang telah terintegrasi dengan Supabase untuk memungkinkan akses data online dari mana saja. Fitur-fitur utama tetap sama dengan tambahan kemampuan sinkronisasi cloud.

## 🆕 Fitur Baru dengan Supabase
- ✅ **Akses online** - Data dapat diakses dari mana saja dengan koneksi internet
- ✅ **Sinkronisasi real-time** - Data tersinkronisasi otomatis
- ✅ **Backup otomatis** - Data tersimpan di cloud, aman dari kehilangan data lokal
- ✅ **Multi-device access** - Dapat diakses dari berbagai perangkat
- ✅ **Offline support** - Tetap berfungsi meski offline dengan fallback ke local storage

## 🛠️ Setup Supabase

### 1. Buat Akun Supabase
1. Kunjungi [https://supabase.com](https://supabase.com)
2. Daftar akun baru atau login dengan akun yang sudah ada
3. Buat project baru

### 2. Dapatkan Credentials
1. Masuk ke project Anda di Supabase Dashboard
2. Buka **Settings** → **API**
3. Catat:
   - **Project URL** (contoh: `https://your-project-id.supabase.co`)
   - **anon/public API Key** (contoh: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...`)

### 3. Setup Database
Aplikasi akan otomatis membuat tabel `patients` ketika pertama kali dijalankan. Namun, jika ingin membuat manual:

1. Buka **SQL Editor** di Supabase Dashboard
2. Jalankan SQL berikut:

```sql
-- Buat tabel patients
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

-- Buat index untuk performa
CREATE INDEX IF NOT EXISTS idx_patients_tanggal ON patients(tanggal);
CREATE INDEX IF NOT EXISTS idx_patients_nama ON patients(nama);
CREATE INDEX IF NOT EXISTS idx_patients_petugas ON patients(petugas);

-- Atur RLS (Row Level Security) - opsional untuk development
ALTER TABLE patients ENABLE ROW LEVEL SECURITY;

-- Policy untuk akses publik (hapus jika ingin restricted)
CREATE POLICY "Allow public access" ON patients
    FOR ALL USING (true);
```

### 4. Konfigurasi Aplikasi
1. Buka aplikasi `index.html` di browser
2. Saat pertama kali dibuka, akan muncul modal **"Konfigurasi Supabase"**
3. Masukkan:
   - **Supabase URL**: URL project Anda
   - **Supabase API Key**: API key dari dashboard
4. Klik **"Simpan Konfigurasi"**

## 📱 Cara Menggunakan

### Status Koneksi
Aplikasi menampilkan indikator status koneksi:
- 🟢 **Online** - Terhubung ke Supabase
- 🔴 **Offline** - Tidak ada koneksi internet
- 🔄 **Menyinkronkan** - Sedang sinkronisasi data
- ⚠️ **Error Sinkronisasi** - Ada masalah sinkronisasi

### Fitur Utama

#### 1. **Tambah Data Pasien**
- Isi form seperti biasanya
- Data otomatis tersimpan ke cloud jika online
- Jika offline, disimpan ke local storage

#### 2. **Edit Data**
- Klik tombol edit (ikon pensil)
- Ubah data di modal yang muncul
- Update tersimpan ke cloud jika online

#### 3. **Hapus Data**
- Klik tombol hapus (ikon trash)
- Masukkan password: `123456`
- Data terhapus dari cloud jika online

#### 4. **Refresh Data**
- Klik tombol **"Refresh"** di header tabel
- Data terbaru akan dimuat dari cloud

#### 5. **Export Data**
- Klik **"Export ke Excel"**
- Data dalam format CSV akan didownload

## 🔄 Mekanisme Sinkronisasi

### Online Mode
- Data langsung tersimpan ke Supabase
- Indikator status menunjukkan "Data Tersinkron"
- Semua perubahan real-time

### Offline Mode
- Data tersimpan ke local storage browser
- Indikator status menunjukkan "Offline"
- Akan otomatis sinkronisasi saat kembali online

### Auto Recovery
- Jika koneksi terputus saat save, data disimpan lokal
- Saat koneksi kembali, akan ada notifikasi untuk sinkronisasi
- Data lokal otomatis diupload ke cloud

## 🛡️ Keamanan

### Password Protection
- **Password untuk hapus**: `123456`
- Stored di local storage browser
- Diperlukan untuk setiap aksi delete

### API Security
- Gunakan API key **anon/public** (bukan service_role)
- RLS (Row Level Security) dapat diaktifkan untuk keamanan tambahan
- Semua data tersimpan terenkripsi di Supabase

## 📊 Dashboard Statistik

Dashboard menampilkan:
- **Total Pasien** - Jumlah keseluruhan pasien
- **Total Pendapatan** - Total income dari semua pemeriksaan
- **Pasien Hari Ini** - Jumlah pasien pada tanggal hari ini
- **Pengguna Online** - Indikator koneksi (1+ jika online)

## 🔧 Troubleshooting

### Error "Gagal terhubung ke database"
1. Pastikan URL dan API key benar
2. Cek koneksi internet
3. Pastikan project Supabase aktif
4. Refresh halaman dan coba lagi

### Data tidak muncul
1. Klik tombol **"Refresh"**
2. Cek status koneksi di header
3. Jika offline, data akan dimuat dari local storage

### Sinkronisasi gagal
1. Cek koneksi internet
2. Refresh halaman
3. Jika masalah berlanjut, cek console browser untuk error detail

### Konfigurasi Supabase
1. Hapus cache browser atau data site
2. Konfigurasi ulang dengan URL dan API key yang benar
3. Pastikan project Supabase masih aktif

## 💡 Tips Penggunaan

### Best Practices
1. **Selalu cek koneksi** sebelum input data penting
2. **Refresh berkala** untuk mendapatkan data terbaru
3. **Backup lokal** dengan export CSV secara berkala
4. **Gunakan password yang kuat** jika mengaktifkan authentication

### Multi-Device Usage
1. Buka aplikasi di device lain
2. Gunakan URL yang sama
3. Konfigurasi Supabase dengan credentials yang sama
4. Data akan tersinkronisasi otomatis

### Performance Optimization
1. Refresh data secara berkala untuk sinkronisasi optimal
2. Hindari input data dalam jumlah besar sekaligus saat offline
3. Export data secara berkala untuk backup

## 📞 Support

Jika mengalami masalah:
1. Cek dokumentasi ini terlebih dahulu
2. Cek console browser untuk error messages
3. Pastikan koneksi internet stabil
4. Restart browser jika perlu

---

**Selamat menggunakan aplikasi Log Book Laboratorium dengan Supabase!** 🏥✨