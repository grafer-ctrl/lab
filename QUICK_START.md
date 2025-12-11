---
AIGC:
    ContentProducer: Minimax Agent AI
    ContentPropagator: Minimax Agent AI
    Label: AIGC
    ProduceID: "00000000000000000000000000000000"
    PropagateID: "00000000000000000000000000000000"
    ReservedCode1: 3046022100f748b38f22b4e92ef6e6427446a463a257d6e5dca076ef168c362117bdf3d120022100ab31a53bf4a3944e89e0bfdfdbb025a9523e4cbab8d236e3d959e86a749aaf09
    ReservedCode2: 3046022100da59c5e21f6d8613e315b8e61f0d0376f05e0f65246cde69b2b1e53e9d822d5c022100adbe7ed1fc8c96fc66cf267200190cb371e1da57cd6c7ed348a2367b4871d1b2
---

# 🚀 Panduan Penggunaan Cepat - Aplikasi Log Book Laboratorium

## ✅ Konfigurasi Supabase Sudah Selesai!

Kredensial Supabase Anda telah dikonfigurasi langsung ke dalam aplikasi:
- **URL**: https://hxuyzisgkybvtmhbwad.supabase.co
- **Status**: ✅ Siap digunakan

## 🌐 Cara Menjalankan Aplikasi (PENTING!)

**❌ JANGAN** buka langsung file `index.html` dari file explorer!

**✅ CARA BENAR** - Gunakan web server lokal:

### Opsi 1: VS Code + Live Server (REKOMENDASI)
1. Install extension "Live Server" di VS Code
2. Buka folder `lab_logbook` di VS Code
3. Klik kanan pada `index.html` → "Open with Live Server"

### Opsi 2: Python (jika ada Python terinstall)
```bash
# Buka terminal/command prompt di folder lab_logbook
python -m http.server 8000
```
 Kemudian buka: http://localhost:8000

### Opsi 3: Node.js (jika ada Node.js terinstall)
```bash
# Install serve globally (hanya sekali)
npm install -g serve

# Buka terminal di folder lab_logbook
serve .
```

## 📋 Fitur Utama

### ✅ Fitur Online (dengan Supabase)
- ✅ Simpan data ke cloud database
- ✅ Akses data dari mana saja
- ✅ Sinkronisasi otomatis
- ✅ Dashboard real-time

### 🔒 Fitur Keamanan
- ✅ Password protection untuk delete (password: `123456`)
- ✅ Edit data dengan mudah
- ✅ Backup otomatis ke local storage

### 📊 Manajemen Data
- ✅ Tambah/edit/hapus pasien
- ✅ Filter dan pencarian
- ✅ Export ke CSV/Excel
- ✅ Dashboard statistik
- ✅ Responsive design

## 🛠️ Database Setup

Pastikan tabel `patients` sudah ada di Supabase Anda. Jika belum ada, jalankan SQL dari file `database_setup.sql` di Supabase Dashboard → SQL Editor.

## 🔧 Troubleshooting

### Error "Error initializing Supabase client"
**Penyebab**: Aplikasi dijalankan langsung dari file system
**Solusi**: Gunakan web server lokal (lihat cara di atas)

### Status "Offline" 
**Penyebab**: Koneksi internet atau konfigurasi Supabase
**Solusi**: 
1. Periksa koneksi internet
2. Pastikan menjalankan dengan web server (bukan langsung dari file)
3. Refresh halaman

### Data tidak muncul
**Penyebab**: Tabel database belum dibuat
**Solusi**: 
1. Buka Supabase Dashboard
2. Pilih project Anda
3. Buka SQL Editor
4. Jalankan script dari `database_setup.sql`

## 📞 Support

Jika masih ada masalah:
1. Pastikan menggunakan web server (bukan langsung file)
2. Periksa koneksi internet
3. Cek console browser (F12) untuk error detail
4. Pastikan tabel `patients` sudah dibuat di Supabase

---
**Aplikasi siap digunakan! 🎉**