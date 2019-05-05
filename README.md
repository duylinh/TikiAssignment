### Đây là bài test của tôi để xin việc tại Tiki.vn


### Mô tả ứng dụng 
Ứng dụng có một màn hình chính để thể hiện giả lập danh sách các từ khóa hot mà user tìm kiếm trên trang web thương mại điện tử Tiki.vn. 
### Thiết kế
[![Hot-Keyword-Photo.png](https://salt.tikicdn.com/ts/upload/a1/dc/e2/26ea3b652ba6f561491a5c928c5bb62d.png)](https://salt.tikicdn.com/ts/upload/a1/dc/e2/26ea3b652ba6f561491a5c928c5bb62d.png)

Dữ liệu lấy từ link API [https://tiki-mobile.s3-ap-southeast-1.amazonaws.com/ios/keywords.json](https://tiki-mobile.s3-ap-southeast-1.amazonaws.com/ios/keywords.json)

### Yêu cầu về UI

> Padding 2 bên 16px.

> Font size 14px.

### Yêu cầu về hiển thị nội dung từ khoá:

> Nếu nội dung chỉ có 1 từ thì sẽ hiển thị 1 dòng.

> Nội dung được align center.

> Background color của phần nội dung được lấy theo thứ tự  #16702e, #005a51, #996c00, #5c0a6b, #006d90, #974e06, #99272e, #89221f, #00345d.

> Nếu nội dung có nhiều hơn 1 từ thì sẽ hiển thị 2 dòng. **Nội dung từ khóa phải hiển thị đầy đủ, không bị truncate** Cần **tính toán** chiều rộng của vùng hiển thị nội dung sao cho **chiều rộng đó là nhỏ nhất có thể**.

### Yêu cầu chung :

> Ứng dụng được viết bằng Swift 4 trên Xcode bản mới nhất.

> Tổ chức cấu trúc cho tầng networking.

> Ứng viên làm bài và gửi lại link github của project.

> UI đẹp và Unit Test là điểm cộng thêm.


### Phân tích xử lý để hiển thị thông tin nội dung từ khoá

> Nếu nội dung chỉ có 1 từ thì sẽ hiển thị 1 dòng.

  Bước đầu tiên ta cần kiểm tra xem nôi dung bao gồm bao nhiêu từ.

  - Nếu nội dung rỗng hoặc chỉ bao gồm các khoảng trắng thì ta sẽ ẩn từ khoá.
  - Nội dung có 1 từ thì ta hiển thị 1 dòng như mô tả trên.
  - Nội dung có 2 từ trở lên thì đọc tiếp yêu cầu bên dưới và xử lý.
     
> Nội dung được align center.

  Label chứa nội dung cần được xử lý để hiển thị nội dung 'align center'
  
> Background color của phần nội dung được lấy theo thứ tự  #16702e, #005a51, #996c00, #5c0a6b, #006d90, #974e06, #99272e, #89221f, #00345d.
  Đây là một bài toán chia lấy dư.
> Nếu nội dung có nhiều hơn 1 từ thì sẽ hiển thị 2 dòng. **Nội dung từ khóa phải hiển thị đầy đủ, không bị truncate **. Cần **tính toán** chiều rộng của vùng hiển thị nội dung sao cho **chiều rộng đó là nhỏ nhất có thể**.

  Ban đầu khi mới đọc qua ta nghĩ đến phương pháp đếm các ký tự (character) để phân dữ liệu chuỗi thành 2 dòng với chiều rộng nhỏ nhất có thể. Nhưng khi vào thực tế thì ta gặp vấn đề là kích thước của các ký tự khác nhau rất nhiều 
  Ví dụ: [độ rộng chữ m] > 3*[độ rộng chữ i] ...

 ==> Vậy nên hướng tiếp cận của tôi sẽ là tính độ dài của từng từ trong chuỗi. Tiếp đến ta so sánh với tổng độ dài của chuỗi để chuỗi thành 2 dòng với chiều rộng nhỏ nhất có thể. Cụ thể việc xử lý tiếp theo như thế nào thì đi vào lập trình chi tiết sẽ có đáp án đúng nhất.

  
