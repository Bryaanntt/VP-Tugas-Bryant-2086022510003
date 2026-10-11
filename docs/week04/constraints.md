## Error 1: Row overflow horizontal

**Error:** `Melakukan rendering text dengan jumlah yang sangat banyak`

**Aturan yang dilanggar:** Row memberi anaknya lebar tak terbatas, sehingga `Text` yang panjang meminta lebar sebesar teksnya dan melebihi lebar layar, padahal tidak ada yang menyuruhnya mengalah.

**Fix:** Bungkus `Text` dengan `Expanded` supaya hanya memakai sisa lebar, lalu beri `maxLines: 1` dan `overflow: TextOverflow.ellipsis`.

Sebelum: ![error 1 sebelum](/images/error1.jpeg)
Sesudah: ![error 1 sesudah](/images/fixed1.jpeg)

## Error 2: ListView di dalam Column

**Error:** `Melakukan rendering daftar (ListView) di dalam Column tanpa batas tinggi`

**Aturan yang dilanggar:** Column memberi anaknya tinggi tak terbatas, sedangkan ListView mencoba setinggi isinya (juga tak terbatas), sehingga constraint yang turun tidak punya batas dan ListView tidak tahu harus setinggi apa.

**Fix:** Bungkus `ListView` dengan `Expanded` supaya Column memberinya tinggi terbatas, yaitu sisa ruang yang ada.

Sebelum: ![error 2 sebelum](/images/error2.jpeg)
Sesudah: ![error 2 sesudah](/images/fixed2.jpeg)

## Error 3: Column overflow vertikal

**Error:** `Melakukan rendering banyak kotak dalam jumlah yang sangat banyak sehingga melebihi tinggi layar`

**Aturan yang dilanggar:** Column berisi 30 kotak, masing-masing setinggi 50 dp (total 1500 dp). Tinggi yang tersedia hanya sekitar 730 dp, dan Column tidak bisa di-scroll sehingga ukurannya melebihi constraint dari parent. Selisihnya 770 dp, sehingga memunculkan garis hitam kuning di layar.

**Fix:** Bungkus Column dengan `SingleChildScrollView` supaya kelebihan tinggi bisa digulir.

Sebelum: ![error 3 sebelum](/images/error3.jpeg)
Sesudah: ![error 3 sesudah](/images/fixed3.jpeg)