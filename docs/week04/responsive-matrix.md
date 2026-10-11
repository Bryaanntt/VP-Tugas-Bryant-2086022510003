# Responsive Matrix - Week 04

Layar yang diuji: Game Backlog (`GameBacklogScreen`).
Hasil akhir: `flutter test test/homework04_test.dart` menghasilkan 19 kasus lulus (All tests passed).

## Matriks screen × test

| Screen | Small phone (320 dp) | Large phone (430 dp) | Tablet (800 dp) | Landscape | Long text | Empty state | Long list | Keyboard | Dark mode | Notch dan gesture bar |
|---|---|---|---|---|---|---|---|---|---|---|
| Game Backlog | Pass | Pass | Pass | Pass | Pass | Pass | Pass | Pass | Pass | Pass |

## Detail per test

| Test | Hasil | Masalah awal | Perbaikan |
|---|---|---|---|
| Small phone (320 dp) | Pass | Tidak ada kegagalan di test. Teks header, judul game, dan chip status berpotensi melebihi lebar layar sempit | Pencegahan: `maxLines` dan `overflow: TextOverflow.ellipsis` pada judul, subjudul, judul game, dan label chip. Baris filter dibungkus `SingleChildScrollView` horizontal |
| Large phone (430 dp) | Pass | Tidak ada masalah | Tidak perlu perbaikan khusus. Layout tetap `ListView` karena lebar masih di bawah 600 dp |
| Tablet (800 dp) | Pass | Tampilan hanya melebar mengikuti layar, struktur tidak berubah (test gagal: `GridView` tidak ditemukan) | `LayoutBuilder` dengan breakpoint 600 dp: di bawahnya `ListView`, di atasnya `GridView` 2 kolom (3 kolom mulai 1000 dp) |
| Landscape | Pass | Tinggi layar pendek berisiko overflow, dan lebar yang bertambah membuat tablet dan large phone berpindah ke grid | Header diringkas saat tinggi tersedia kurang dari 320 dp (lihat baris Keyboard) |
| Long text (200 karakter) | Pass | Judul panjang berisiko merusak layout, terutama pada grid yang tinggi selnya dikunci 96 dp | `maxLines: 2` dan ellipsis pada judul item, `maxLines: 1` pada chip status |
| Empty state | Pass | Awalnya tanpa aksi dan tidak dikenali test (test gagal: `Key('empty-state')` tidak ditemukan) | Ikon, pesan, dan tombol aksi ("Lihat semua" saat ada filter atau pencarian aktif, atau "Muat ulang"), serta `Key('empty-state')` |
| Long list (500 item) | Pass | Daftar yang tidak lazy akan membangun semua item sekaligus | `ListView.builder` dan `GridView.builder`, tanpa `shrinkWrap`. Hanya item yang terlihat yang dibangun (kurang dari 100) |
| Keyboard | Pass | Pada layar pendek disertai keyboard (landscape, tinggi tersisa sekitar 140 dp), terjadi `RenderFlex overflowed by 8.0 pixels on the bottom` | Ditambahkan kolom pencarian `SearchBar` dengan `Key('search-field')`. Saat tinggi tersedia kurang dari 320 dp, judul dikecilkan dan subjudul disembunyikan. Saat kurang dari 200 dp, blok judul disembunyikan seluruhnya. Kolom pencarian selalu tampil. Test memastikan kolom pencarian dan daftar berakhir di atas area keyboard (260 dp pada portrait, 180 dp pada landscape) |
| Dark mode | Pass | Warna yang ditulis langsung tidak mengikuti tema dan bisa tidak terbaca di mode gelap | Semua warna dan teks diambil dari `ColorScheme.fromSeed` dan `textTheme`, dengan `theme` dan `darkTheme`. Test dijalankan dengan `ThemeMode.dark` di tiga ukuran layar. Pemeriksaan manual di emulator Pixel 7 dengan tema gelap menunjukkan judul, kolom pencarian, chip filter, chip status, dan nama game tetap terbaca |
| Notch dan gesture bar (bonus) | Pass | Konten bisa tertutup area notch atau gesture bar | `SafeArea` membungkus seluruh isi layar |
| Pencarian (tambahan) | Pass | Tidak ada, ini fitur baru untuk mendukung test keyboard | `SearchBar` memfilter judul game. Hasil kosong menampilkan empty state dengan pesan khusus pencarian |
