# FlexiBank - Aplikasi Mobile Banking Aksesibel

**FlexiBank** adalah aplikasi mobile banking inovatif yang dirancang khusus untuk mengutamakan aksesibilitas, dengan fokus memenuhi standar **WCAG 2.1 (Web Content Accessibility Guidelines)** untuk membantu pengguna dengan keterbatasan fisik, motorik, maupun penglihatan.

---

## 🌟 Fitur Utama Aksesibilitas

Aplikasi ini dilengkapi dengan fitur khusus yang dapat diaktifkan melalui menu **Pengaturan Aksesibilitas**:

1. **Dynamic Button Sizing**: Tombol di seluruh aplikasi dapat diubah ukurannya menjadi **Standard**, **Large**, atau **Maximum** agar lebih mudah ditekan oleh pengguna dengan keterbatasan motorik halus.
2. **Text Scaling**: Ukuran teks dapat disesuaikan (Standard, Large, Maximum) untuk kenyamanan membaca pengguna yang mengalami gangguan penglihatan (low vision).
3. **Assistive Touch Menu**: Menu melayang (floating menu bubble) yang menyediakan akses cepat ke navigasi utama (Home, Transfer, History, Settings) serta mengaktifkan kontrol suara.
4. **Voice Control Overlay**: Antarmuka perintah suara yang memungkinkan navigasi aplikasi secara *hands-free* dengan mengucapkan kata kunci seperti *"Beranda"*, *"Transfer"*, *"Riwayat"*, *"Tagihan"*, *"QRIS"*, atau *"Pengaturan"*.

---

## 📸 Dokumentasi Seluruh Halaman Aplikasi

Berikut adalah penjelasan dan daftar seluruh halaman (screen) pada aplikasi FlexiBank beserta panduan tangkapan layar (screenshot). Silakan simpan gambar screenshot Anda di folder `/screenshots` dengan nama file yang sesuai agar tampil secara otomatis di bawah ini:

### 1. Halaman Login & Registrasi

| Halaman | Deskripsi | Gambar |
|---|---|---|
| **01. Login Screen** | Halaman awal untuk masuk menggunakan Email dan Kata Sandi. Dilengkapi tombol login yang terhubung ke provider aksesibilitas. | ![Login Screen](screenshots/01_login.png) |
| **02. Biometric Login** | Login cepat dan aman menggunakan sensor sidik jari (biometrik) untuk memudahkan pengguna tanpa harus mengetik kata sandi. | ![Biometric Login Screen](screenshots/02_biometric_login.png) |
| **03. Register Screen** | Form pendaftaran akun baru lengkap dengan input KTP dan simulasi pemindaian dokumen. | ![Register Screen](screenshots/03_register.png) |

---

### 2. Antarmuka Utama & Transaksi

| Halaman | Deskripsi | Gambar |
|---|---|---|
| **04. Home / Dashboard** | Menampilkan kartu saldo utama, pintasan transaksi cepat (Transfer, QRIS, Tagihan, Riwayat), dan daftar transaksi hari ini. | ![Home Screen](screenshots/04_home.png) |
| **05. Transfer Menu** | Pilihan tujuan transfer, baik ke sesama rekening bank maupun e-wallet. | ![Transfer Screen](screenshots/05_transfer.png) |
| **06. Input Penerima (Bank)** | Form memasukkan nomor rekening tujuan dengan keyboard numerik yang besar dan mudah ditekan. | ![Input Penerima Bank Screen](screenshots/06_input_penerima_bank.png) |
| **07. Input Penerima (E-Wallet)** | Form transfer e-wallet (GoPay, OVO, Dana, ShopeePay, dll) dengan dropdown pilihan tujuan yang pas di tengah. | ![Input Penerima E-Wallet Screen](screenshots/07_input_penerima_ewallet.png) |
| **08. Input Nominal** | Antarmuka memasukkan nominal transfer menggunakan Numpad khusus berukuran besar. | ![Input Nominal Screen](screenshots/08_input_nominal.png) |
| **09. Konfirmasi Transfer** | Halaman ringkasan detail penerima, bank, dan jumlah transfer sebelum transaksi diproses dengan tombol aksi yang aksesibel. | ![Konfirmasi Transfer Screen](screenshots/09_konfirmasi_transfer.png) |
| **10. Detail Transaksi** | Bukti transfer/transaksi sukses yang rapi, berisikan nomor referensi, status, dan rincian lengkap transfer. | ![Detail Transaksi Screen](screenshots/10_detail_transaksi.png) |

---

### 3. Pembayaran Tagihan & QRIS

| Halaman | Deskripsi | Gambar |
|---|---|---|
| **11. Daftar Tagihan** | Menampilkan kategori tagihan seperti Listrik PLN, Air PDAM, BPJS Kesehatan, Internet/TV Kabel, dll. | ![Tagihan Screen](screenshots/11_tagihan.png) |
| **12. Detail Tagihan** | Detail nominal tagihan bulanan pelanggan yang harus dibayarkan. | ![Detail Tagihan Screen](screenshots/12_detail_tagihan.png) |
| **13. Konfirmasi Tagihan** | Ringkasan dan konfirmasi pembayaran tagihan sebelum saldo dipotong. | ![Konfirmasi Tagihan Screen](screenshots/13_konfirmasi_tagihan.png) |
| **14. QRIS Payment** | Scan QR Code merchant untuk pembayaran praktis secara langsung. | ![QRIS Screen](screenshots/14_qris.png) |

---

### 4. Riwayat & Pengaturan

| Halaman | Deskripsi | Gambar |
|---|---|---|
| **15. Riwayat Transaksi** | Daftar rekaman seluruh aktivitas keluar-masuk saldo secara berkala berdasarkan hari (Today, Yesterday, etc.). | ![History Screen](screenshots/15_history.png) |
| **16. Pengaturan Aksesibilitas** | Pusat kendali untuk menyalakan/mematikan Assistive Touch, Voice Control, serta mengatur skala teks dan ukuran tombol. | ![Settings Screen](screenshots/16_settings.png) |

---

## 🛠️ Tech Stack & Dependencies

Aplikasi ini dikembangkan menggunakan framework:
*   **Flutter (Dart)**
*   **Provider** (State Management untuk pengaturan Aksesibilitas)
*   **Shared Preferences** (Penyimpanan lokal untuk menyimpan status opsi aksesibilitas secara persisten)

---

## 🚀 Cara Menjalankan Aplikasi

### Persyaratan:
1. Flutter SDK versi terbaru terinstal.
2. Emulator Android atau perangkat fisik terhubung.

### Langkah-langkah:
1. Jalankan perintah untuk mendapatkan dependensi:
   ```bash
   flutter pub get
   ```
2. Jalankan aplikasi dalam mode pengembangan:
   ```bash
   flutter run
   ```
3. Untuk membuat file APK rilis yang siap diinstal di handphone Android:
   ```bash
   flutter build apk --release
   ```
   *File APK hasil build akan tersimpan di:*  
   `build/app/outputs/flutter-apk/app-release.apk`
