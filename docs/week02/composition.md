List Widget yang di extract 

## GameStatus

- **Trigger:** Readability karena file ini memisahkan logic filter chip dari method `build()` di screen agar tidak terlalu panjang dan lebih mudah dibaca jadi di file game status tidak panjang di filenya sendiri.
- **Owns:** Tidak memiliki state apapun (stateless). Hanya menerima `selectedStatus` dari parent untuk menentukan bagian mana yang sedang aktif.
- **Reports upward:** Memanggil `onChanged(GameStatus? status)` setiap kali user memilih chip status yang berbeda.

## GameListItem

- **Trigger:** Reuse karena widget ini dipakai berulang kali di dalam `ListView.builder`, satu instance untuk setiap game dalam list semisal dalam file ini ada 7 game jadi dia akan panggil berulang kali sebanyakk 7 kali.
- **Owns:** Tidak memiliki state apapun (stateless). Hanya menerima satu objek `Game` untuk ditampilkan.
- **Reports upward:** Memanggil `onTap()` saat item ditekan, yang kemudian memicu dialog perubahan status di level screen.

## GameEmptyState

- **Trigger:** Readability karena memisahkan logic yang akan menampilakn pesan kosong karena backlog benar-benar kosong ataupun karena hasil filter tidak ditemukan dari logic utama di `_buildBody()`.
- **Owns:** Tidak memiliki state apapun (stateless). Hanya menerima `status` untuk menentukan pesan mana yang ditampilkan.
- **Reports upward:** Tidak ada karena dia tidak memiliki callback dari statenya namun dia hanya menampilkan teks di layar jika mendapatkan koleksi dari gamenya itu kosong atau null dari parentnya.

## GameLoadingView

- **Trigger:** Reuse & readability karena dipakai ulang di screen lain yang membutuhkan indikator loading standar, serta memisahkan logic loading dari logic parent.
- **Owns:** Tidak memiliki state apapun (stateless) atau parameter dari parent class.
- **Reports upward:** Tidak ada karena hanya untuk menampilkan screen yang statis dan bersifat tetap.

## Ringkasan State Hoisting

Semua state yang dapat berubah seperti `_isLoading`, `_selectedStatus`, `_allGames` disimpan secara terpusat di `_GameBacklogScreenState`. Keempat widget di atas bersifat `StatelessWidget` dan tidak memiliki state nya sendiri di tiap file, mereka hanya menerima data melalui constructor dan melaporkan interaksi user ke parent melalui callback (`onChanged`, `onTap`). 