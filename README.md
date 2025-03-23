# Valorant Ajanları Mobil Uygulaması

Bu proje, Valorant API'sini kullanarak ajanların ve detaylı bilgilerinin görüntülendiği bir mobil uygulamadır. Flutter ile geliştirilmiştir ve kullanıcıların ajanları listeleyebilmesi, detaylarını görebilmesi, favorilere ekleyebilmesi ve favori ajanlarını yönetebilmesi için tasarlanmıştır.

## Proje Açıklaması

Ajanları ve detaylı bilgilerini görüntülemek için Valorant API ile arayüz oluşturan bir mobil uygulama geliştirdim. Bu proje, Flutter geliştirme becerilerimi, kodlama uygulamalarımı ve problem çözme yeteneklerimi değerlendirmek için tasarlanmıştır.

## API Bilgileri

- **Base URL:** `https://valorant-api.com/v1`
- **Kullanılacak Uçlar:**
  - `/agents` - Tüm ajanları çeker
  - `/agents/{agentUuid}` - Belirli bir ajanın detayını çeker
  - `/agents?isPlayableCharacter=true` - Oynanabilecek karakterleri filtreler

## Temel Gereksinimler

### Uygulama Fonksiyonelleri

1. **Ajanlar Liste Görünümü**
   - Ajanları düzenli bir şekilde görüntüleme
   - İlgili ajan bilgilerini gösterme
   - Uygun yükleme durumlarını uygulama
   - Hata senaryolarını etkili bir şekilde yönetme

2. **Ajan Detay Görünümü**
   - Kapsamlı ajan bilgilerini sunma
   - Ajan yeteneklerini görüntüleme

3. **Ajan Favorilere Ekleme/Güncelleme/Silme Görünümü**
   - Eklenmek istenen ajan BAŞLIK ve AÇIKLAMA alınarak yerel bir veritabanına kaydedilir.
   - Ajan’ı favorilerken tutulacak bilgiler:
     1. Eşsiz bir başlık.
     2. Bu ajanla ilgili almak istediği notlar.
     3. Ajan'ın bilgileri
   - Başlık ve Açıklama güncellenebilmektedir.
   - Ajan favorilerden çıkarılabilmektedir.

4. **Favori Ajanlar Liste Görünümü**
   - İlgili ajan bilgilerini gösterme
   - Uygun yükleme durumlarını uygulama
   - Hata senaryolarını etkili bir şekilde yönetme

### Teknik Gereksinimler

1. **Uygulama Yapısı**
   - Organize edilmiş proje yapısı
   - Dil desteği eklenmesi
   - Network için Dio kullanılacaktır
   - State yönetimi için Stacked kullanılacaktır
   - Uygun mimari pattern kullanımı
   - Yeniden kullanılabilir bileşenler oluşturma
   - Temiz kod sorumluluğu

2. **Veri Yönetimi**
   - Verimli durum yönetimi implementasyonu
   - API entegrasyonunun düzgün yönetimi
   - Etkili veri akışı yönetimi
   - Uç durumlar ve hataların yönetimi

3. **Kullanıcı Arayüzü**
   - Responsive tasarım oluşturma
   - Uygun yükleme durumları
   - Animasyonlar ile destekleme

### Bonus Özellikler (Henüz uygulanmadı)
- API çağrılarını azaltmak için cache yapısı
- Test yazılması
- Daha akıcı kullanıcı etkileşimi için animasyonlar ve Responsie UI geliştirmeleri

## Sayfalama (Pagination)

Bu uygulama, çok sayıda ajan verisini düzgün bir şekilde göstermek için **sayfalama (pagination)** kullanmaktadır. **Ajanlar Liste Görünümü**'nde, veriler API'den alındığında, tüm ajanların tek bir ekranda yüklenmesi yerine, veriler sayfalar halinde getirilir. Bu sayede, kullanıcıların uygulamanın hızını ve performansını daha verimli bir şekilde deneyimlemeleri sağlanır.

#### Sayfalama Özellikleri

- **Veri Yükleme**: Ajanların bilgileri, API uç noktasından sayfalama ile alınır. Her sayfa belirli sayıda ajan içerir.
- **Daha Fazla Yükle**: Kullanıcı, listeyi aşağı kaydırarak yeni sayfaları yükleyebilir. Bu özellik, daha fazla veri yüklenene kadar sürekli olarak aktif kalır.
- **Performans Optimizasyonu**: Sayfalama, veri miktarını sınırlayarak uygulamanın hızını artırır. Kullanıcı yalnızca ihtiyacı olan veriyi yükler ve bu da daha hızlı bir deneyim sağlar.


#### Sayfalama Arayüzü
- **Listeyi Kaydırma**: Kullanıcı, ajanlar listesinde kaydırma işlemi yaparak yeni sayfalar yüklenmesini sağlayabilir.
- **Yükleniyor Göstergesi**: Yeni veriler yüklenirken kullanıcıya uygun bir yükleniyor göstergesi sunulur.
- **Hata Yönetimi**: Sayfalama sırasında herhangi bir hata oluşursa, kullanıcıya uygun bir hata mesajı gösterilir ve uygulama düzgün bir şekilde hata yönetimi yapar.

Bu sayfalama mekanizması, uygulamanın kullanıcı deneyimini iyileştirir ve büyük veri setlerinin verimli bir şekilde işlenmesini sağlar.



## Localization (Çoklu Dil Desteği)

Bu projede **localization** (yerelleştirme) özelliği, uygulamanın farklı dillerdeki kullanıcılar için uyarlanmasını sağlar. Dil dosyaları JSON formatında saklanmakta ve `assets/languages/` dizininde yer almaktadır. Mevcut diller arasında **Türkçe** ve **İngilizce** bulunmaktadır.

### Dil Dosyaları
Dil dosyaları, her dil için ayrı bir JSON dosyası içerir. Örnek olarak:
- `assets/languages/tr.json` – Türkçe çeviriler
- `assets/languages/en.json` – İngilizce çeviriler

JSON dosyalarının örnek yapısı şu şekildedir:
```json
{
  "deleteAgentSuccessfulTitle": "Deletion Successful",
  "editAgentSuccessfulTitle": "Update Successful",
  "enterTitleAndDescription": "Enter Your Favorite Title and Description",
  "favoriteAgentNotSaved": "Could not save to favorites.",
  "titleNotSameBeforeTitle": "You must enter a title different from the previous one!",
}
```

### Dil Seçimi ve Kullanımı
Flutter'da yerelleştirme, kullanıcı arayüzündeki metinlerin çevrilmesini sağlar. Uygulama, dil dosyalarını flutter_localizations paketini ve JSON dosyalarını kullanarak yönetir.

Dil Dosyalarının Yapılandırılması
Dil dosyaları, assets/languages/ dizininde saklanır.

Uygulamanın dil desteğini aktif hale getirmek için, pubspec.yaml dosyasına gerekli ayarlamalar yapılmalıdır:

## Test

Bu projede, uygulamanın farklı bileşenlerinin doğru çalıştığından emin olmak için birim testleri (unit tests) ve widget testleri kullanılmıştır. Testler, uygulamanın sağlam ve hatasız çalışmasını sağlamak için sürekli entegrasyon süreçlerinde yer alacaktır.

### Test Özellikleri
- **Birim Testleri**: API entegrasyonları ve temel iş mantığı için birim testleri yazılmıştır. Bu testler, uygulamanın her bileşeninin doğru işlediğini doğrulamak için kullanılır.
- **Widget Testleri**: Uygulama arayüzü bileşenlerinin doğru şekilde görüntülenip tepki verdiğini kontrol eden widget testleri bulunmaktadır.
- **Mocking**: API çağrıları için mock veri kullanılarak testler yapılmıştır. Bu, gerçek API çağrılarını taklit etmek için Mockito veya benzer bir kütüphane ile sağlanmıştır.

Testler, projeyi geliştirmeye devam ederken kodun kararlılığını korumaya yardımcı olur ve hataların erken aşamada tespit edilmesini sağlar.

Testleri çalıştırmak için şu komutu kullanabilirsiniz:
```bash
flutter test
```


## Nasıl Kullanılır?

1. **Projeyi Klonlayın:**
   ```bash
   git clone https://github.com/oguzhanoozer/Valorant-Agents-Explorer.git

2. **Projeyi açın ve bağımlılıkları yükleyin:**
   ```bash
   flutter pub get

3. **Uygulamayı başlatın:**
   ```bash
   flutter run


### Katkıda Bulunma
Katkılarınızı bekliyoruz! Lütfen aşağıdaki adımları izleyin:

Fork yapın
Yeni bir branch oluşturun (git checkout -b feature/AmazingFeature)
Değişikliklerinizi yapın ve commit edin (git commit -m 'Add some AmazingFeature')
Branch'inizi push edin (git push origin feature/AmazingFeature)
Pull request oluşturun

### İletişim
Proje ile ilgili herhangi bir sorunuz veya öneriniz için aşağıdaki iletişim kanallarından bana ulaşabilirsiniz:

- Email: oguzoozer@gmail.com
- GitHub: https://github.com/oguzhanoozer


## Klasör Yapısı

📦 assets  
┣ 📂 fonts - Uygulamada kullanılan özel yazı tiplerini içerir.  
┣ 📂 icons - Uygulama genelinde kullanılan ikon dosyaları.  
┣ 📂 images - Uygulama içindeki görseller ve resim dosyaları.  
┗ 📂 localizations - Farklı diller için yerelleştirme dosyaları.

📦 test  
┣ 📜 agent\_detail.json - Ajan detayları için kullanılan test verileri.  
┗ 📜 agent\_list.json - Ajan listesi için kullanılan test verileri.

📦 lib  
┣ 📂 core - Uygulamanın temel yapı taşlarını barındırır.  
┃ ┣ 📂 configs - Uygulama genelinde kullanılan yapılandırma ayarları.  
┃ ┣ 📂 constants - Sabit değerler ve uygulama genelinde kullanılan değişmezler.  
┃ ┣ 📂 theme - Uygulamanın tema ayarları ve stil dosyaları.  
┃ ┗ 📂 exceptions - Özel hata ve istisna sınıfları.  
┣ 📂 init - Uygulamanın başlatılması ve bağımlılık yönetimi için gerekli dosyalar.  
┣ 📂 models - Uygulama verilerini temsil eden veri modelleri.  
┣ 📂 routing - Navigasyon ve yönlendirme işlemleri.  
┃ ┣ 📂 guards - Yönlendirme sırasında belirli koşulları kontrol eden koruyucular.  
┃ ┣ 📂 observers - Navigasyon olaylarını izleyen gözlemciler.  
┃ ┣ 📜 app\_navigation.dart - Uygulamanın navigasyon ayarlarını içerir.  
┃ ┣ 📜 app\_router.dart - Uygulama yönlendirme işlemlerini yönetir.  
┃ ┗ 📜 app\_router.gr.dart - Otomatik oluşturulan yönlendirici dosyası.  
┣ 📂 services - Uygulama servisleri ve iş mantığı.  
┃ ┣ 📂 api - API ile ilgili işlemler ve dosyalar.  
┃ ┃ ┣ 📂 clients - API istemcileri, sunucu ile iletişimi sağlar.  
┃ ┃ ┣ 📂 constants - API ile ilgili sabit değerler.  
┃ ┃ ┣ 📂 interceptors - API istek ve yanıtlarını kesen ve işleyen kesiciler.  
┃ ┃ ┗ 📜 api\_service.dart - API servislerini yöneten ana dosya.  
┃ ┣ 📂 app - Uygulama genel servisleri.  
┃ ┃ ┣ 📂 local\_storage - Yerel depolama işlemleri.  
┃ ┃ ┣ 📂 localization - Uygulamanın yerelleştirme işlemleri.  
┃ ┃ ┗ 📂 theme - Tema yönetimi ve ayarları.  
┃ ┃ ┃ ┣ 📜 base\_service.dart - Temel servis sınıfı.  
┃ ┃ ┃ ┗ 📜 theme\_controller.dart - Tema değişikliklerini yöneten kontrolcü.  
┣ 📂 ui - Kullanıcı arayüzü bileşenleri ve ekranlar.  
┃ ┣ 📂 dialogs - Kullanıcıya gösterilen diyalog pencereleri.  
┃ ┣ 📂 screens - Uygulamanın farklı ekranları.  
┃ ┃ ┣ 📂 agent - Ajanlarla ilgili ekranlar.  
┃ ┃ ┣ 📂 favorites - Favori öğelerle ilgili ekranlar.  
┃ ┃ ┣ 📂 main - Ana ekranlar ve giriş noktaları.  
┃ ┃ ┣ 📂 settings - Ayar ekranları.  
┃ ┃ ┣ 📂 skeletons - Yükleme sırasında gösterilen iskelet ekranlar.  
┃ ┃ ┣ 📂 splash - Uygulama açılış ekranı.  
┃ ┃ ┣ 📜 base\_screen\_args.dart - Ekranlar arası veri aktarımı için argümanlar.  
┃ ┃ ┣ 📜 base\_screen\_controller.dart - Ekran kontrolcüsü.  
┃ ┃ ┣ 📜 base\_screen\_view.dart - Ekran görünüm bileşeni.  
┃ ┃ ┗ 📜 base\_screen\_widget.dart - Ekran widget bileşeni.  
┃ ┗ 📂 widgets - Özel ve genel widget bileşenleri.  
┃ ┃ ┣ 📂 custom\_widgets - Uygulamaya özgü özel widget'lar.  
┃ ┃ ┗ 📂 widgets - Genel amaçlı widget'lar.  
┃ ┃ ┃ ┣ 📜 custom\_activity\_indicator.dart - Özel yükleme göstergesi.  
┃ ┃ ┃ ┣ 📜 create\_adaptive\_widgets.dart - Farklı platformlar için uyarlanabilir widget'lar.  
┃ ┃ ┃ ┣ 📜 cupertino\_widgets.dart - iOS stilinde widget'lar.  
┃ ┃ ┃ ┣ 📜 custom\_base\_widgets.dart - Temel özel widget'lar.  
┃ ┃ ┃ ┣ 📜 material\_widgets.dart - Material tasarım stilinde widget'lar.  
┃ ┃ ┃ ┣ 📜 agent\_list\_tile.dart - Ajan liste öğesi.  
┃ ┃ ┃ ┣ 📜 app\_bar.dart - Uygulama çubuğu bileşeni.  
┃ ┃ ┃ ┣ 📜 base\_list\_view.dart - Temel liste görünümü.  
┃ ┃ ┃ ┣ 📜 custom\_network\_image.dart - Özel ağ resmi bileşeni.  
┃ ┃ ┃ ┣ 📜 gesture\_detector.dart - Jest algılayıcı bileşeni.  
┃ ┃ ┃ ┣ 📜 icon\_button.dart - İkon butonu bileşeni.  
┃ ┃ ┃ ┣ 📜 label\_button.dart - Etiket butonu bileşeni.  
┃ ┃ ┃ ┣ 📜 scaffold.dart - Scaffold widget bileşeni.  
┃ ┃ ┃ ┣ 📜 text\_field.dart - Metin alanı bileşeni.  
┃ ┃ ┃ ┗ 📜 text.dart - Metin bileşeni.

📜 main.dart - Uygulamanın başlangıç noktası ve ana dosyası.

📦 linux - Platforma özgü dosyalar ve ayarlar.  
📦 macos - Platforma özgü dosyalar ve ayarlar.  
📦 windows - Platforma özgü dosyalar ve ayarlar.

📦 test  
┣ 📜 agent\_client\_test.dart - Ajan istemci testleri.  
┣ 📜 agent\_client\_test.mocks.dart - Mock dosyaları.  
┣ 📜 agent\_client.mocks.dart - Mock dosyaları.  
┗ 📜 widget\_test.dart - Widget testleri.
