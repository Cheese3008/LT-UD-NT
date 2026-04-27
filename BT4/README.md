# BT4 - Exercise Week 4 Flutter/Dart

## 1. Giới thiệu

Đây là project Flutter được thực hiện cho **BT4 - Exercise Week 4**.  
Project bao gồm các bài thực hành về:

- `ListView`
- `GridView.count()`
- `GridView.extent()`
- `SharedPreferences`
- `Asynchronous Programming`
- `Isolate` trong Flutter
- `Isolate` trong Dart console application

Mục tiêu của bài là luyện tập cách xây dựng giao diện Flutter, lưu trữ dữ liệu cục bộ, xử lý bất đồng bộ và chạy tác vụ nặng bằng isolate để tránh làm treo giao diện.

---

## 2. Cấu trúc thư mục

```text
lib/
├── main.dart
├── screens/
│   ├── home_screen.dart
│   ├── contact_list_screen.dart
│   ├── grid_view_screen.dart
│   ├── shared_preferences_screen.dart
│   ├── async_user_screen.dart
│   └── factorial_isolate_screen.dart
└── isolate_console_challenge.dart

assets/
└── images/
    ├── 9.png
    ├── 10.png
    ├── 11.png
    ├── 12.png
    ├── 15.png
    ├── 16.png
    ├── 17.png
    ├── 18.png
    ├── 19.png
    ├── 20.png
    ├── 21.png
    └── 22.png
```

---

## 3. Các chức năng đã thực hiện

### 3.1. Home Screen

Màn hình chính hiển thị danh sách các bài tập trong tuần 4.

Các màn hình được điều hướng từ Home Screen:

1. ListView Exercise
2. GridView Exercise
3. SharedPreferences Exercise
4. Async Programming Exercise
5. Isolate Factorial Exercise

---

### 3.2. ListView Exercise

Màn hình này tạo danh sách liên hệ bằng `ListView.separated`.

Chức năng chính:

- Hiển thị danh sách 10 liên hệ.
- Mỗi liên hệ có:
  - Ảnh đại diện tạm thời.
  - Tên liên hệ.
  - Số điện thoại.
  - Email.
  - Nút nhắn tin.
- Danh sách có thể cuộn.
- Giao diện sử dụng `Card`, `ListTile`, `CircleAvatar` và icon để dễ nhìn hơn.

---

### 3.3. GridView Exercise

Màn hình này hiển thị gallery gồm 12 hình ảnh trong thư mục `assets/images`.

Project sử dụng cả hai loại GridView theo yêu cầu:

#### Section 1: GridView.count()

Thông số:

```dart
crossAxisCount: 3
mainAxisSpacing: 8
crossAxisSpacing: 8
childAspectRatio: 1
```

Tiêu đề:

```text
Fixed Column Grid
```

#### Section 2: GridView.extent()

Thông số:

```dart
maxCrossAxisExtent: 150
mainAxisSpacing: 10
crossAxisSpacing: 10
childAspectRatio: 0.8
```

Tiêu đề:

```text
Responsive Grid
```

Chức năng bổ sung:

- Giao diện dùng màu pastel.
- Mỗi item có ảnh, nhãn và bo góc.
- Khi chọn một hình trong `Responsive Grid`, màn hình sẽ tự cuộn lên hình tương ứng trong `Fixed Column Grid`.
- Hình tương ứng trong `Fixed Column Grid` được highlight bằng viền nổi bật.

---

### 3.4. SharedPreferences Exercise

Màn hình này dùng package `shared_preferences` để lưu dữ liệu cục bộ.

Chức năng chính:

- Nhập tên người dùng.
- Lưu tên bằng nút `Save Name`.
- Hiển thị tên đã lưu bằng nút `Show Name`.
- Xử lý trường hợp chưa có dữ liệu.
- Xóa dữ liệu đã lưu bằng nút `Clear Data`.

Chức năng mở rộng:

- Lưu thêm tuổi.
- Lưu thêm email.
- Hiển thị thời gian lưu gần nhất.
- Thiết kế giao diện pastel, bo góc mềm, có icon minh họa.

---

### 3.5. Asynchronous Programming Exercise

Màn hình này mô phỏng quá trình tải dữ liệu bất đồng bộ bằng `Future.delayed`.

Luồng hoạt động:

1. Người dùng nhấn nút `Load User`.
2. Ứng dụng hiển thị thông báo:

```text
Loading user...
```

3. Ứng dụng chờ 3 giây.
4. Sau đó hiển thị:

```text
User loaded successfully!
```

Mục đích:

- Thực hành `async`.
- Thực hành `await`.
- Thực hành `Future.delayed`.
- Cập nhật giao diện bằng `setState()`.

---

### 3.6. Isolate Factorial Exercise

Màn hình này tính giai thừa của một số lớn, mặc định là:

```text
30000!
```

Chức năng chính:

- Nhập số cần tính giai thừa.
- Tính giai thừa bằng `compute()`.
- Chạy tác vụ nặng trong isolate riêng.
- Hiển thị trạng thái loading trong lúc tính toán.
- Hiển thị kết quả sau khi hoàn thành.

Kết quả hiển thị gồm:

- Số đã tính.
- Tổng số chữ số của kết quả.
- Thời gian tính toán.
- 80 chữ số đầu.
- 80 chữ số cuối.

Mục đích:

- Tránh làm treo UI khi xử lý tác vụ nặng.
- Thực hành sử dụng `compute()` trong Flutter.
- Thực hành xử lý số nguyên lớn bằng `BigInt`.

---

### 3.7. Dart Console Isolate Challenge

File:

```text
lib/isolate_console_challenge.dart
```

Chức năng:

- Tạo một ứng dụng Dart console.
- Khởi tạo một isolate chạy nền.
- Worker isolate gửi số ngẫu nhiên mỗi giây.
- Main isolate nhận số và cộng dồn.
- Khi tổng vượt quá 100, main isolate gửi lệnh dừng.
- Worker isolate thoát bằng `Isolate.exit()`.

Chạy file bằng lệnh:

```cmd
dart run lib/isolate_console_challenge.dart
```

Ví dụ kết quả:

```text
Main isolate started.
Worker isolate connected.
Received number: 15
Current sum: 15
--------------------------
Received number: 18
Current sum: 33
--------------------------
Sum exceeded 100.
Sending stop command to worker isolate...
Worker isolate exited gracefully.
Main isolate finished.
```

---

## 4. Checklist hoàn thành

| Yêu cầu | Trạng thái |
|---|---|
| ListView danh sách liên hệ | Hoàn thành |
| Mỗi contact có avatar placeholder | Hoàn thành |
| GridView.count() | Hoàn thành |
| GridView.extent() | Hoàn thành |
| Gallery 12 ảnh/icon | Hoàn thành |
| SharedPreferences Save Name | Hoàn thành |
| SharedPreferences Show Name | Hoàn thành |
| Xử lý khi chưa có dữ liệu | Hoàn thành |
| Clear Data | Hoàn thành |
| Lưu age, email | Hoàn thành |
| Hiển thị timestamp | Hoàn thành |
| Async loading 3 giây | Hoàn thành |
| Hiển thị User loaded successfully | Hoàn thành |
| Tính 30000! bằng compute/isolate | Hoàn thành |
| Hiển thị loading khi tính toán | Hoàn thành |
| Dart console isolate gửi số ngẫu nhiên | Hoàn thành |
| Main isolate cộng tổng và gửi stop command | Hoàn thành |
| Worker isolate thoát bằng Isolate.exit() | Hoàn thành |

---
