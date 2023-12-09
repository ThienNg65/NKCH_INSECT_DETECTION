# NKCH_INSECT_DETECTION

Overview:
Tên đề tài: Xây dựng mô hình nhận dạng côn trùng dựa trên hình ảnh
Mã đề tài: THS2023-54
1. Nghiên cứu quy trình xây dựng mô hình phát hiện đối tượng trong ảnh
Sử dụng mô hình YOLOv8 cho việc thực hiện phân loại:
![image](https://github.com/ThienNg65/NKCH_INSECT_DETECTION/assets/112293169/84e06965-bdc1-4709-a620-e3f5a2700b11)

 
2. Thu nhập hình ảnh và xây dựng cơ sở dữ liệu cho hệ thống nhận diện côn trùng
![image](https://github.com/ThienNg65/NKCH_INSECT_DETECTION/assets/112293169/8f22db5c-e818-4e72-bc3b-077c389aeefb)

  
3. Xậy dựng mô hình phát hiện đối tượng trong ảnh
Huấn luyện mô hình trên Google Colab:
![image](https://github.com/ThienNg65/NKCH_INSECT_DETECTION/assets/112293169/7c7090a0-d1fd-44ff-a0e0-0570725e62ca)

 
4. Xây dựng giao diện ứng dụng
•	Màn hình chính: Màn hình này hiển thị một danh sách các loài côn trùng nhất định và cho phép người dùng có thể xem thông tin chi tiết khi click vào. Bên dưới màn hình chính là một thanh bottom navigation bar chứa 3 chức năng điều hướng cho phép người dùng truy cập vào trang chủ, chức năng chụp ảnh và truy cập vào xem hồ sơ người dùng.

![image](https://github.com/ThienNg65/NKCH_INSECT_DETECTION/assets/112293169/91327f7b-fcc6-48e2-b342-c28564a726f0)
Hình 1. Màn hình chính

•	Màn hình chụp ảnh: Màn hình này cho phép người dùng chụp ảnh côn trùng bằng máy ảnh của điện thoại hoặc chọn hình ảnh có sẵn trên điện thoại.

![image](https://github.com/ThienNg65/NKCH_INSECT_DETECTION/assets/112293169/4d97dee4-b3b6-4fa3-9e0b-1f67583326b6)
Hình 2. Màn hình chụp ảnh

•	Màn hình kết quả: Màn hình này hiển thị kết quả phân loại của ảnh côn trùng. Kết quả phân loại sẽ bao gồm một số loài côn trùng gần nhất với kết quả do mô hình chẩn đoán.

![image](https://github.com/ThienNg65/NKCH_INSECT_DETECTION/assets/112293169/d53e5c38-b045-4e4d-8ad0-ca118da6b5ee)
Hình 3. Màn hình kết quả

•	Thông tin chi tiết côn trùng: Sau khi nhận dạng được côn trùng, người dùng có thể truy cập vào xem thông tin chi tiết của côn trùng ấy bằng cách nhập vào mũi tên chuyển trang. Thông tin sẽ bao gồm tên khoa học, loài, chi, bộ, lớp, ngành, giới và những thông tin bên lề như hình thức sinh sản, thiên địch hay những đặc trưng của côn trùng ấy. 

![image](https://github.com/ThienNg65/NKCH_INSECT_DETECTION/assets/112293169/1e86fd93-9763-40ff-b1b9-f3cad86057bc)
Hình 4. Màn hình thể hiện thông tin chi tiết côn trùng

•	Trang cá nhân người dùng: Chức năng này cho phép người dùng có thể thêm hoặc thay đổi thông tin cá nhân của người sử dụng

![image](https://github.com/ThienNg65/NKCH_INSECT_DETECTION/assets/112293169/d9622b6e-3173-490d-9856-9e3227938765)
Hình 5. Trang cá nhân người dùng

•	Màn hình đăng nhập: Nơi người dùng nhập thông tin đăng nhập của họ để truy cập vào ứng dụng. Nếu người dùng chưa có tài khoản thì có thể đăng ký người dùng mới. Trên màn hình này bao gồm các text field cho phép người dùng nhập email và mật khẩu để đăng nhập, một text button “Quên mật khẩu” để người dùng có thể đặt lại mật khẩu.

![image](https://github.com/ThienNg65/NKCH_INSECT_DETECTION/assets/112293169/581eb554-335f-4713-9836-50cadc09cfd1)
Hình 6. Màn hình đăng nhập

•	Màn hình đăng ký: Màn hình này là nơi người dùng tạo tài khoản mới nếu chưa có tài khoản đăng nhập. Bao gồm các text field yêu cầu nhập email, nhập mật khẩu và nhập lại mật khẩu.

![image](https://github.com/ThienNg65/NKCH_INSECT_DETECTION/assets/112293169/7450784f-ff73-4953-800b-298b130de87e)
Hình 7. Màn hình đăng ký

Ngoài các chức năng trên, ứng dụng còn cung cấp một số chức năng phụ như:
•	Chức năng ngăn kéo: Thanh Drawer cho phép người dùng truy cập vào màn hình chính, danh sách yêu thích, danh sách côn trùng đã tra cứu, tìm kiếm cũng như có thể đăng xuất khỏi hệ thống.

![image](https://github.com/ThienNg65/NKCH_INSECT_DETECTION/assets/112293169/b12bd0fe-f32f-4806-a3bb-81c2518ab0dc) 
Hình 8. Thanh Drawer



•	Chức năng tìm kiếm phân loại theo họ, bộ hoặc loài: Màn hình bao gồm thanh tìm kiếm và được hiển thị theo dạng danh sách các loài côn trùng dựa trên từ khóa mà người dùng nhập vào từ bàn phím Android, cho phép người dùng tìm kiếm nhiều loài côn trùng theo ý muốn.

![image](https://github.com/ThienNg65/NKCH_INSECT_DETECTION/assets/112293169/ad5f426d-ed49-4062-beb9-0e99b05828fb)              
Hình 9. Chức năng tìm kiếm theo phân loại

•	Chức năng danh sách yêu thích: Chức năng này sẽ cho phép người sử dụng lưu lại các loài côn trùng đặc biệt hoặc cần xem lại nhiều lần mà không cần vào thanh tìm kiếm. 

![image](https://github.com/ThienNg65/NKCH_INSECT_DETECTION/assets/112293169/19b324a6-2901-4915-8f39-30fbf916dd1e)
Hình 10. Danh sách yêu thích

•	Chức năng xem lại những tìm kiếm gần đây: Chức năng sẽ hỗ trợ người dùng dễ dàng hơn trong việc xem lại các loài côn trùng đã được nhận dạng trước đây.

![image](https://github.com/ThienNg65/NKCH_INSECT_DETECTION/assets/112293169/7faa34d2-9edf-4ff0-b9bf-3868eaec2d86) 
Hình 11. Đã tra cứu gần đây

•	Danh sách mở rộng được phân cấp theo họ và bộ của loài côn trùng: Khi truy cập vào loài côn trùng nào đó, ngoài việc cho thế xem đặc điểm chi tiết côn trùng người dùng còn có thế xem qua danh sách các loài côn trùng được phân loại theo họ và bộ tương ứng với loài đó theo dạng thanh cuộn ngang.

![image](https://github.com/ThienNg65/NKCH_INSECT_DETECTION/assets/112293169/9458bb69-ae12-4a0c-92b0-00ebe4a3e2ca)
Hình 12. Danh sách mở rộng

5. Tích hợp mô hình nhận diện, cơ sở dữ liệu vào trong ứng dụng

![image](https://github.com/ThienNg65/NKCH_INSECT_DETECTION/assets/112293169/61281bd2-ffd9-4020-8161-c6d6cac21cff)
 

