-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 23, 2025 lúc 02:44 AM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `petshop`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `brands`
--

CREATE TABLE `brands` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `logo_url` varchar(255) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `brands`
--

INSERT INTO `brands` (`id`, `name`, `description`, `slug`, `created_at`, `logo_url`, `updated_at`) VALUES
(1, 'Royal Canin', 'Thức ăn cao cấp cho chó mèo', 'royal-canin', '2025-10-30 09:51:45.000000', '1761899016005-Royal-Canin-Logo.png', '2025-11-10 03:59:20.000000'),
(2, 'Pedigree', 'Thức ăn & bánh thưởng cho chó', 'pedigree', '2025-10-31 08:25:07.000000', '1761899107280-Pedigree-Logo-2002.png', '2025-10-31 08:25:07.000000'),
(3, 'Whiskas', 'Thức ăn hạt & pate cho mèo', 'whiskas', '2025-10-31 08:21:55.000000', '1761898915588-images.jpg', '2025-10-31 08:21:55.000000'),
(4, 'Sanicat', 'Cát vệ sinh mèo cao cấp', 'sanicat', '2025-10-31 08:26:12.000000', '1761899172296-Sanicat.jpg', '2025-10-31 08:26:12.000000'),
(5, 'SOS', 'Sữa tắm chó mèo', 'sos', '2025-10-31 08:27:48.000000', '1761899268025-SOS.png', '2025-10-31 08:27:48.000000'),
(6, 'Me-O', 'Thức ăn phổ thông cho mèo', 'meo-o', '2025-10-31 08:29:37.000000', '1761899377762-meo-o.jpg', '2025-10-31 08:29:37.000000'),
(7, 'SmartHeart', 'Thức ăn phổ thông cho chó', 'smartheart', '2025-10-31 08:29:45.000000', '1761899385262-SmartHeart.png', '2025-10-31 08:29:45.000000'),
(8, 'a', 'a', 'a', '2025-10-30 09:29:25.000000', '1761816565839-be3b6afa82037b4fbd957df3cd1fbc71.jpg', '2025-10-30 09:29:25.000000'),
(10, 'King\'s Pet', 'Sản phẩm pate đóng hộp của Việt Nam, được làm từ nguyên liệu tươi ngon và có hương vị hấp dẫn.', 'kings-pet', '2025-10-31 07:38:24.000000', '1761896304099-logo.jpg', '2025-10-31 07:38:24.000000');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `carts`
--

CREATE TABLE `carts` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `quantity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cart_detail`
--

CREATE TABLE `cart_detail` (
  `id` bigint(20) NOT NULL,
  `cart_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'Thức ăn'),
(2, 'Vệ sinh'),
(3, 'Phụ kiện');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `news`
--

CREATE TABLE `news` (
  `id` bigint(20) NOT NULL,
  `content` text DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `news`
--

INSERT INTO `news` (`id`, `content`, `created_at`, `slug`, `thumbnail`, `title`, `updated_at`, `user_id`) VALUES
(1, '<p>Nếu như bạn là một người nuôi thú cưng, mong muốn đem đến những điều tuyệt vời nhất cho “cục báo” của mình. Vậy thì, việc đưa em bé đến Pet Studio để chụp một bộ ảnh chất lượng làm kỷ niệm, là một trong những điều bạn nên thử cùng “best friend” của mình trong đời đấy.&nbsp;</p><p>Tuy nhiên, bạn vẫn chưa hiểu rõ về dịch vụ “tuy lạ mà quen” này sẽ có những gì và trải nghiệm như thế nào? Vậy thì hãy để PetShop Pet Studio giải thích và tư vấn để bạn có những thông tin chính xác về <strong>gói dịch vụ chụp hình cho thú cưng</strong> này dành cho em pet nhé!</p><h2><strong>Pet Studio Là Gì?</strong></h2><p>Pet Studio là không gian chụp hình chuyên nghiệp dành riêng cho thú cưng đã có từ rất lâu trên thế giới, nhưng lại là dịch vụ khá mới mẻ ở Việt Nam, đây là nơi ba mẹ có thể lưu giữ những khoảnh khắc đẹp nhất cho các em cún, em mèo (hoặc những loài động vật khác) đang được chăm sóc trong một mốc thời gian nhất định của các bé.&nbsp;</p><p>Khác với việc chụp hình thông thường, <strong>Pet Studio</strong> mang đến những bối cảnh đặc biệt hơn, nơi đây sẽ có đèn chuyên dụng và đội ngũ photogrpher có kinh nghiệm, giúp các em pet mang dáng vẻ xinh xắn và lộng lẫy.&nbsp;</p><p>Hơn thế nữa, chất lượng ảnh khi chụp tại Studio sẽ tốt hơn, có thể phóng lớn để lưu giữ làm kỷ niệm hoặc sử dụng cho những mục đích trình chiếu và in ấn cao cấp.</p><p>Ngoài việc chụp hình, Pet Studio còn là nơi giúp thú cưng thư giãn và tự tin hơn khi được kết hợp các hoạt động vui vẻ và từng bước làm quen với quá trình chụp ảnh.&nbsp;</p><figure class=\"image\"><img src=\"/resources/admin/images/news/1761539575578-mona-magnussen-a7bdqjeG6M4-unsplash.jpg\"></figure><h2><strong>Vì Sao Bạn Nên Đưa Thú Cưng Chụp Tại Pet Studio?</strong></h2><h3><strong>1. Lưu Giữ Kỷ Niệm Tuyệt Vời cùng Pet&nbsp;</strong></h3><p>Mỗi em pet đều có những phút giây hài hước và đáng yêu, cùng với những biểu cảm dễ thương riêng biệt. Việc chụp hình tại <strong>Pet Studio</strong> giúp em pet sở hữu những bức ảnh có chất lượng tốt hơn so với những hình ảnh chụp thường ngày, cùng với dáng vẻ chuyên nghiệp và “xịn xò”, nhờ phụ kiện và trang phục mà <strong>tiệm chụp ảnh thú cưng</strong> đã chuẩn bị sẵn cho các bé.&nbsp;</p><ol><li><strong>Photographer chuyên nghiệp và tâm lý</strong></li></ol><p>Thông thường ở các Studio nói chung, các photographer đã được đào tạo và có kinh nghiệm, biết cách khai thác những góc chụp đẹp nhất cho đối tượng chụp.&nbsp;</p><p>Riêng đối với các<strong> Studio chụp hình cho thú cưng</strong>, không chỉ cần các Photographer có kinh nghiệm, mà cũng có cả nhân viên điều hướng các bé, để các bé có thể “phô diễn” những biểu cảm dễ thương, điều này cần rất nhiều kỹ năng, sự thấu hiểu và tình yêu thương dành cho các bé, như vậy các bé mới có thể hợp tác thực hiện.&nbsp;</p>', '2025-10-28 06:54:13.000000', 'luu-lai-nhung-khoanh-khac-ac-biet-cua-em-pet-tai-pet-studio', '1761557672866-be3b6afa82037b4fbd957df3cd1fbc71.jpg', 'Lưu lại những khoảnh khắc đặc biệt của em Pet tại Pet Studio', '2025-11-10 03:59:29.000000', 1),
(3, '<p>con meo</p><figure class=\"image\"><img src=\"/resources/admin/images/news/1761366989069-be3b6afa82037b4fbd957df3cd1fbc71.jpg\"></figure><p>meo meo</p><figure class=\"image\"><img src=\"/resources/admin/images/news/1761367048940-t_i_xu_ng.jpg\"></figure>', '2025-10-28 06:54:17.000000', 'petshop-khai-truong-chi-nhanh-moi--moi-ban-ua-boss-ghe-choi', '1761367068795-mona-magnussen-a7bdqjeG6M4-unsplash.jpg', 'PETSHOP KHAI TRƯƠNG CHI NHÁNH MỚI – MỜI BẠN ĐƯA BOSS GHÉ CHƠI', '2025-10-18 16:40:15.000000', 1),
(4, '<p>Nếu như bạn là một người nuôi thú cưng, mong muốn đem đến những điều tuyệt vời nhất cho “cục báo” của mình. Vậy thì, việc đưa em bé đến Pet Studio để chụp một bộ ảnh chất lượng làm kỷ niệm, là một trong những điều bạn nên thử cùng “best friend” của mình trong đời đấy.&nbsp;</p><p>Tuy nhiên, bạn vẫn chưa hiểu rõ về dịch vụ “tuy lạ mà quen” này sẽ có những gì và trải nghiệm như thế nào? Vậy thì hãy để PetShop Pet Studio giải thích và tư vấn để bạn có những thông tin chính xác về <strong>gói dịch vụ chụp hình cho thú cưng</strong> này dành cho em pet nhé!</p><figure class=\"image\"><img src=\"/resources/admin/images/news/1761373747629-be3b6afa82037b4fbd957df3cd1fbc71.jpg\"></figure>', '2025-10-28 06:54:19.000000', 'review-hat-nutrience-cho-meo-cong-tam-va-chi-tiet-nhat', '1761373751303-be3b6afa82037b4fbd957df3cd1fbc71.jpg', 'Review hạt Nutrience cho mèo công tâm và chi tiết nhất', '2025-10-19 16:40:20.000000', 1),
(5, '<p>Những quán cà phê chó đang dần phát triển và trở thành chốn hò hẹn lý tưởng tại TP.HCM trong những năm gần đây. Tuy nhiên, để có một quán cafe thuần tuý chỉ có những chú chó Shiba lại chưa được phổ biến tại Việt Nam.</p><p>Thế nên, với tình yêu to lớn dành cho Shiba, PetShop đã cho ra đời một chi nhánh mới, đặt tên là Mame Shiba Cafe, nhằm đáp ứng những vị khách yêu thích cún nói chung và trở thành nơi chốn để gặp gỡ các chú chó Shiba nói riêng.</p><h2>Mame Shiba Cafe là gì?</h2><p>Shiba Cafe là một loại hình cà phê nổi tiếng ở Nhật Bản, nơi mà bạn có thể thưởng thức cà phê trong một&nbsp; không gian thư giãn và vui đùa cùng các chú chó Shiba – Đây những chú chó được mệnh danh sở hữu gương mặt “hạnh phúc nhất thế giới”, với tính cách dễ thương, nụ cười vô cùng đáng yêu và thân thiện.</p><p>Shiba Cafe được xem là điểm đến phổ biến đối với những người yêu thích Shiba và muốn trải nghiệm một dạng quán cà phê độc đáo.&nbsp;</p><p>Chó Shiba cũng sẽ có những dòng Shiba khác nhau, điển hình nhất vẫn là Shiba Inu. Thế nhưng, khi đến với Mame Shiba Cafe, bạn không chỉ được giao lưu cùng với em bé Shiba Inu, mà còn có thể chơi đùa cùng dòng em bé Shiba khác, cũng là nhân tố nổi bật của quán, đó là Mame Shiba.</p><figure class=\"image\"><img src=\"https://kinpetshop.com/wp-content/uploads/mame-shiba-cafe-quan-2-600x400.jpg\" alt=\"Màme Shiba Cafe là gì?\"></figure><p>Đây cũng chính là lý do mà PetShop đã đặt tên quán cà phê của mình là Mame Shiba Cafe.</p><h2>Vì sao lại gọi là Mame Shiba?</h2><p>Mame trong tiếng Nhật có nghĩa là hạt đậu. Vì người Nhật rất ưa chuộng phong cách nhỏ nhắn nên đã nhân giống dòng chó Shiba nhỏ hơn và đặt tên là Mame Shiba. Nhưng không phải cứ chó Shiba nào có kích thước nhỏ cũng có thể gọi là thuộc dòng Mame.</p><p>Các bé phải đạt tiêu chuẩn cân nặng chỉ từ 2 đến 4kg&nbsp;</p><ul><li>Con đực cao 30cm – 34cm</li><li>Con cái cao 28cm 32cm</li></ul><p>Tuy kích thước của Shiba Inu và Mame Shiba khác nhau, nhưng trên thực tế, hai dòng Shiba vẫn có đặc điểm tính cách giống hệt nhau.</p><figure class=\"image\"><img src=\"https://kinpetshop.com/wp-content/uploads/mame-shiba-cafe-tong-huu-dinh-597x400.jpeg\" alt=\"Những em bé Shiba tại Mame Shiba Cafe\"></figure><h2>Thông tin về Mame Shiba Cafe</h2><h3>Không gian tại Mame Shiba Cafe</h3><p>Trên thực tế, Mame Shiba không chỉ có khu vực dành cho cún Shiba. Mà quán có đến 3 khu vực:</p><ul><li>Cafe ngoài trời và trong nhà</li><li>Cafe cún Shiba</li><li>Cafe mèo</li></ul><p>Nếu khu vực cà phê Shiba dành cho các em bé Shiba, cà phê mèo dành cho những thành viên “cây nhà lá vườn” được chăm sóc trước đó từ PetShop, vậy thì không gian lầu trệt (trong nhà và ngoài trời) chính là nơi để các vị khách dễ dàng trò chuyện, đưa thú cưng của mình đến vui chơi thoài mái với không gian mát mẻ và tươi mới.</p><p>Ngoài ra, tại Mame Shiba luôn có những ưu đãi thú vị dành cho những vị khách thân yêu như voucher khuyến mại, những món quà lưu niệm nhỏ xinh, hay những combo dịch vụ với giá cực “yêu”.</p><figure class=\"image\"><img src=\"https://kinpetshop.com/wp-content/uploads/mame-shiba-cafe-600x400.jpg\" alt=\"Không gian Mame Shiba Cafe\"></figure><h3>“Đội ngũ nhân viên” Shiba nhà Mame Shiba Cafe</h3><p>Tại Mame Shiba Cafe, không chỉ có dòng chó Mame Shiba được nhắc đến ở trên, mà còn có cả dòng Shiba Inu. Tất cả các em bé đều đến từ quê hương Nhật Bản, hiện nay được sinh sống và chăm sóc tại 29 Tống Hữu Định, Phường Thảo Điền, Quận 2.</p><p>Hiện nay, PetShop đang nuôi 10 em bé Shiba.</p><p>Các em bé từ gia đình PetShop luôn được chăm sóc kỹ lưỡng, từ vấn đề tiêm phòng, grooming, theo dõi cân nặng mỗi tuần một lần, nhằm đảm bảo sức khoẻ cho các bé, cũng như bảo đảm an toàn tuyệt đối cho các vị khách ghé chơi.</p>', '2025-10-28 06:53:16.000000', 'mame-shiba-cafe--khong-gian-cafe-cun-cuc-yeu-danh-cho-ban', '1761615632366-be3b6afa82037b4fbd957df3cd1fbc71.jpg', 'MAME SHIBA CAFE – KHÔNG GIAN CAFE CÚN CỰC YÊU DÀNH CHO BẠN', NULL, 1),
(6, '<p>a</p><figure class=\"image\"><img src=\"/admin/images/news/1761634157317-be3b6afa82037b4fbd957df3cd1fbc71.jpg\"></figure>', '2025-10-28 06:49:18.000000', 'aa', '1761634145918-be3b6afa82037b4fbd957df3cd1fbc71.jpg', 'aa', NULL, 1),
(7, '<p>So với thức ăn hạt khô, <strong>thức ăn ướt cho mèo</strong> có nhiều lợi thế hơn cả như kích thích vị giác, giúp “Hoàng Thượng” thèm ăn, ăn ngon và dễ dàng tiêu hóa.</p><p>Không những vậy, thức ăn cho mèo ướt còn khắc phục tình trạng sức khỏe như sỏi thận, táo bón, các bệnh về đường tiết niệu, vì thức ăn ướt cho mèo con sẽ cung cấp lượng nước đủ cho thú cưng nhà bạn.</p><p>Vậy, thức ăn ướt cho mèo là gì? Thức ăn cho mèo ướt nào tốt nhất? Nên lưu ý những gì khi lựa chọn sản phẩm? Mua thức ăn ướt cho mèo con ở đâu uy tín, chất lượng? Cùng Kin Neko khám phá nhé!</p><h2><strong>Thức ăn ướt cho mèo là gì? Có nên sử dụng?</strong></h2><p>Thức ăn ướt cho mèo là một hỗn hợp gồm nhiều loại thịt khác nhau, đậu nành và những thứ khác chế biến thành. Chúng có lượng nước thấp chỉ khoảng 35%. Thức ăn cho mèo ướt thường có dạng túi và được đóng gói bảo quản cẩn thận.</p><p>Thức ăn ướt trở thành một nguồn cung cấp nước, chất dinh dưỡng cho mèo khi ăn. Một sản phẩm tuyệt vời với hương vị thơm ngon, giàu khoáng chất và <a href=\"https://kinpetshop.com/vitamin-cho-meo/\"><strong>vitamin cho mèo</strong></a> bổ sung trong một ngày.</p><p><a href=\"https://kinpetshop.com/cac-loai-pate-cho-meo/\"><strong>Pate mèo</strong></a> có độ ẩm cao, mềm phù hợp với các bé mèo có những triệu chứng bệnh về thận, gan và đường tiết niệu.</p><p>Điều đó góp phần giúp “Boss” nhà bạn giảm thiểu tối đa lượng cặn trong tiết niệu, ngăn tạo sỏi thận trong gan và đảm bảo cân bằng lượng nước có chứa trong nội tạng của mèo.</p><p>Thức ăn ướt cũng rất thích hợp với những em mèo đang ăn kiêng. Hầu hết túi nhỏ/một hộp thức ăn có chứa hàm lượng calo bằng ¼, ⅓ thức ăn hạt khô có cùng khối lượng.</p><figure class=\"image\"><img src=\"https://kinpetshop.com/wp-content/uploads/thuc-an-uot-cho-meo-loai-nao-tot-nhat.jpg\" alt=\"thức ăn ướt cho mèo loại nào tốt nhất\"></figure><h2><strong>Top 7 thức ăn ướt cho mèo chất lượng nhất bán chạy trên thị trường</strong></h2><p>Theo các chuyên gia để chọn <strong>thức ăn ướt cho mèo</strong> tốt nhất, họ căn cứ vào những tiêu chí như sau:</p><ul><li>Khả năng cung cấp chất dinh dưỡng: vitamin, khoáng chất, các chất cần thiết cho sự phát triển của mèo.</li><li>Thành phần các chất phụ gia phải có ích cho sức khỏe của mèo.</li><li>Dựa vào nhận xét, đánh giá và mức độ hài lòng của người dùng.</li><li>Thành phần thức ăn và hương vị phải đảm bảo an toàn, thơm ngon.</li></ul><p>Dưới đây, Kin Neko sẽ giới thiệu một vài sản phẩm tiêu biểu thỏa mãn các tiêu chí trên, để chủ nuôi tha hồ lựa chọn:</p><h3><strong>Thức ăn ướt cho mèo Royal Canin</strong></h3><p><strong>Thành phần chính</strong></p><ul><li>Cá và các chất dẫn xuất cá</li><li>Thịt và các chất dẫn xuất động vật</li><li>Ngũ cốc</li><li>Dầu và chất béo</li><li>Chiết xuất protein thực vật</li><li>Khoáng chất</li><li>Đường khác nhau</li><li>Các chất dẫn xuất thực vật</li></ul><p><strong>Công dụng nổi bật</strong></p><ul><li>Cung cấp nhiều chất dinh dưỡng như: chất béo, protein, tinh bột, các vitamin và khoáng chất cần thiết</li><li>Nguồn chất béo trong thức ăn với hàm lượng vừa phải, tránh nguy cơ béo phì ở mèo</li><li>Hỗ trợ ngăn ngừa điều trị các chứng bệnh về thận, tim, tiểu đường,…</li><li>Hương vị thơm ngon giúp kích thích sự thèm ăn ở mèo, ăn ngon miệng và dễ tiêu hóa hơn</li><li>Chăm sóc và duy trì độ bóng mượt, mềm mại của bộ lông</li><li>Nâng cao sức khỏe hệ thống bài tiết</li></ul><p><strong>Số lượng khuyên dùng hàng ngày</strong></p><ul><li>Nên cho “Boss” ăn Pate mèo Royal Canin&nbsp;3 lần/ngày vào các giờ và chỗ ăn cố định.</li><li>Không nên cho mèo ăn quá nhiều trong một lần, công thức chia lượng thức ăn theo cân nặng được hướng dẫn trên bao bì.</li></ul><p><strong>Giá sản phẩm</strong>: 415.000 VND</p><figure class=\"image\"><img src=\"https://kinpetshop.com/wp-content/uploads/cac-loai-thuc-an-uot-cho-meo.jpg\" alt=\"các loại thức ăn ướt cho mèo\"></figure>', '2025-10-28 07:09:42.000000', 'top-7-thuc-an-cho-meo-uot-tot-nhat-2023-khong-the-bo-qua', '1761635382262-be3b6afa82037b4fbd957df3cd1fbc71.jpg', 'Top 7 thức ăn cho mèo ướt tốt nhất 2023 không thể bỏ qua', NULL, 1),
(8, '<p>Mèo Anh lông ngắn là một trong những giống mèo phổ biến hiện nay, được đông đảo bạn trẻ yêu thích. Đối với những bạn mới nuôi giống mèo lần đầu, sẽ khá bỡ ngỡ và lúng túng không biết nên chăm sóc như thế nào.</p><p>Bài viết sau đây sẽ bật mí cho bạn cách nuôi mèo Anh lông ngắn chi tiết nhất. Khi bạn đã có được cẩm nang chăm sóc thú cưng này trong tay, đảm bảo mèo của bạn sẽ khỏe mạnh và phát triển toàn diện.</p><h2><strong>Vì sao mèo Anh lông ngắn được yêu thích?</strong></h2><p>Trước khi tìm hiểu về <strong>cách nuôi mèo Anh lông ngắn</strong>, chúng ta sẽ cùng tìm câu trả lời vì sao giống mèo này lại được ưa chuộng. Thực tế cho thấy, dù trên thị trường có bao nhiêu giống mèo mới thì loài mèo này vẫn luôn dễ dàng đốn tim được các bạn trẻ.</p><h3><strong>Nguồn gốc mèo Anh lông ngắn</strong></h3><p>Tên tiếng Anh của mèo Anh lông ngắn là British Shorthair Cat. Đây là giống mèo lâu đời nhất, có nguồn gốc từ Ai Cập trong thời kì La Mã cổ đại.</p><p><i>Mèo Anh lông ngắn là giống mèo sống lâu đời nhất</i></p><p>Vào năm 1967, Hiệp hội mèo Hoa Kỳ đã chứng nhận giống mèo này. Đến năm 1979, Hiệp hội Mèo quốc tế đã chấp nhận chúng, đến 1980 thì Hiệp hội những người yêu thích mèo chấp nhận.</p><p>Giống mèo này có tên là mèo Anh lông ngắn bởi vì sau khi chúng được mang đến nước Anh và nhận được sự yêu thích của giới quý tộc, theo thời gian giống mèo này trở nên phổ biến và có mặt ngày càng nhiều tại đây.</p><h3><strong>Đặc điểm của mèo Anh lông ngắn</strong></h3><p>Để biết được<strong> cách nuôi mèo Anh lông ngắn</strong> thì bạn cần biết đặc điểm của giống mèo này đầu tiên. Cụ thể như:</p><ul><li>Chúng có bản tính khá nhút nhát và hiền lành, không thích sự ồn ào nhưng khá nghịch ngợm.</li><li>Mèo Anh lông ngắn rất khi cất tiếng kêu.</li><li>Không giống như một số loài khác, mèo Anh lông ngắn không cần phải được ra ngoài chơi quá nhiều, chúng có thể tự vui vẻ với các đồ chơi hoặc vật dụng trong nhà.</li><li>British Shorthair khá quấn người, thích được vuốt ve và âu yếm</li><li>Khi trưởng thành chúng sẽ có xu hướng khá lười biếng, thích nằm một chỗ tận hưởng cả ngày, thích hợp cho những bạn yêu mèo nhưng khá bận rộn.</li></ul><h2><strong>Cách chăm sóc mèo Anh lông ngắn thường ngày</strong></h2><p>Làm cách nào để cho bé mèo khỏe và mũm mĩm là điều được nhiều người quan tâm. Hãy tham khảo cách chăm sóc mèo Anh lông ngắn dưới đây nhé!</p><h3><strong>Khám sức khỏe định kỳ</strong></h3><p>Khi bạn mới nhận nuôi một bé mèo Anh lông ngắn, bạn cần biết bé đã được tiêm ngừa từ chủ cũ hay chưa, đã tiêm hoặc chưa tiêm mũi nào, lúc nào cần tiêm lần nữa. Vì vậy bạn cần chuẩn bị một cuốn sổ để theo dõi sức khỏe của bé.</p><p>Tiếp theo chính là bạn nên dẫn bé đi khám sức khỏe định kỳ. Điều này sẽ giúp bạn kiểm soát được tình trạng sức khỏe của bé, nhanh chóng phát hiện những vấn đề lạ để trị kịp thời.</p><p>Bạn nên đưa bé kiểm tra tổng quát 2 lần/năm. Bạn cần kiểm tra xem mèo của mình đã được tẩy giun hay chưa, nếu chưa thì nên hỏi ý kiến của bác sĩ về việc này.</p><h3><strong>Vệ sinh răng miệng</strong></h3><p>Một điều quan trọng trong cách nuôi mèo Anh lông ngắn chính là bạn phải vệ sinh răng miệng của bé thường xuyên. Vì theo thống kê, giống mèo này sẽ có nguy cơ bị viêm nướu cao hơn vậy nên bạn hãy sử dụng loại kem đánh răng chuyên dụng nhé!</p><p><i>Bạn hãy để bé mèo làm quen với việc vệ sinh</i></p><p>Để giúp bé có thể nhanh chóng thích nghi được với việc đánh răng, bạn nên phết một lớp bánh thưởng lên bàn chải để bé nếm. Tiếp theo đó bạn sẽ đặt mèo ngồi ở một vị trí tạo sự thoải mái cho chúng và tiến hành vệ sinh răng miệng.</p><p>Bạn phết một lớp kem đánh răng lên bàn chải, nhẹ nhàng tách môi của bé ra, chà bàn chải lên răng theo chuyển động lên xuống. Trong suốt quá trình vệ sinh, bạn có thể chủ động nói chuyện, tâm sự với bé để tạo được sự thoải mái.</p><p>Một lưu ý nhỏ chính là bạn có thể sử dụng bàn chải ngón tay để vệ sinh dễ dàng hơn. Ngoài ra, bạn nên chọn kem đánh răng có hương vị cá ngừ, thịt gà,… để giúp quy trình đánh răng thuận tiện và bé mèo cũng cảm thấy dễ chịu hơn.</p><h3><strong>Chăm sóc lông và quan sát dấu hiệu lạ</strong></h3><p>Một trong những biểu hiện sức khỏe của mèo chính là thông qua bộ lông và tình trạng da. Nếu như bạn thấy bé mèo gần đây có xu hướng liếm lông hoặc cắn vào da mình quá nhiều, khả năng cao chúng đang gặp vấn đề về da.</p><p>Bạn nên kiểm tra xem da mèo có mẩn đỏ, dị ứng hay bị thương không. Những vấn đề này sẽ thường gặp đối với các bé mèo bị bọ chét, nhiễm trùng da.</p><p>Khi bạn thấy có các dấu hiệu lạ, nên nhanh chóng đưa bé mèo đến cơ sở thú y gần nhất để được thăm khám. Việc phát hiện sớm các vấn đề về lông, da sẽ giúp cho quá trình chữa trị diễn ra suôn sẻ hơn.</p><blockquote><p><i>Bạn có thể tìm mua các</i></p></blockquote><h3><strong>Giữ vệ sinh chậu cát</strong></h3><p>Điều quan trọng tiếp theo trong cách nuôi mèo Anh lông ngắn chính là cần phải giữ vệ sinh chậu cát sạch sẽ. Một số người kỹ tính còn thay cát 2 ngày/lần.</p><p>Tuy nhiên, việc làm trên khá tốn kém nên bạn có thể đổi cát cũ và thay các mới ít nhất 1 lần/tuần để đảm bảo vệ sinh. Ngoài ra bạn cần phải thường xuyên kiểm tra chậu cát xem cát có vón cục hay không và lấy đi phần chất thải của mèo ở chậu.</p><p>Một điều lưu ý khi đặt nhà vệ sinh cho mèo chính là bạn nên đặt ở chỗ riêng tư, ít người. Hạn chế tối đa việc đặt nhà vệ sinh ở nơi đông người hoặc ồn ào (cạnh tủ lạnh, máy giặt).</p><p>Khi cho cát vào chậu, bạn chỉ nên cho một lượng vừa đủ vì mèo Anh lông ngắn sẽ không thích việc có lớp cát quá dày để đi vệ sinh. Bạn có thể tham khảo bài viết <a href=\"https://kinpetshop.com/review-cac-loai-cat-ve-sinh-cho-meo/\"><strong>review các loại cát vệ sinh cho mèo</strong></a> để có thêm lựa chọn về loại cát phù hợp cho bé mèo của mình.</p><h3><strong>Gỡ rối lông mèo thường xuyên</strong></h3><p>Bộ lông của mèo sẽ góp phần quan trọng trong việc tạo vẽ thẩm mỹ của chúng. Mặc dù bộ lông của mèo Anh lông ngắn khá ngắn, tuy nhiên chúng vẫn cần được chăm sóc thường xuyên.</p><p><i>Chải lông cho mèo thường xuyên hạn chế tối đa bị búi lông</i></p><p>Mỗi ngày mèo sẽ rụng đi một lượng lông nhất định. Với thói quen vệ sinh bằng cách liếm láp cơ thể, mèo rất dễ bị tình trạng búi lông trong dạ dày vì vậy chải lông cho mèo là bước không thể thiếu trong <a href=\"https://kinpetshop.com/cach-nuoi-meo-anh-long-ngan/#cach-cham-meo-anh-long-ngan\"><strong>cách chăm mèo Anh lông ngắn</strong></a>.</p><p>Việc chải lông cho mèo sẽ giúp hạn chế tối đa tình trạng mèo liếm lông và nuốt vào bụng, gây tắc đường ruột. Chải lông còn giúp cho bạn loại bỏ đi bụi bẩn bám trên da mèo, làm cho bộ lông mượt mà hơn. Ngoài ra việc <a href=\"https://kinpetshop.com/cat-tia-long-meo/#cat-tia-long-meo-dep\">cắt tỉa lông mèo đẹp</a> cũng góp phần tạo cho bé mèo một vẻ ngoài xinh xắn và đáng yêu hơn.</p><p>Nếu như bạn thấy mèo nhà mình đang bị rối lông thì hãy chải càng sớm càng tốt. Hiện nay trên thị trường có rất nhiều loại lược chuyên dụng để chải lông mèo nên bạn có thể tham khảo nhé!</p><h3><strong>Làm sạch tai mèo, cắt móng</strong></h3><p>Bạn nên vệ sinh tai mèo thường xuyên để hạn chế bụi bẩn tích tụ vào bên trong. Thời gian lý tưởng để kiểm tra tai mèo chính là mỗi tuần/1lần. Nếu như bạn thấy bên trong tai mèo có nhiều chất bẩn, bạn có thể tham khảo ý kiến bác sĩ nên dùng sản phẩm gì để vệ sinh phù hợp, bạn cũng có thể tham khảo thêm bài viết <a href=\"https://kinpetshop.com/ve-sinh-tai-cho-meo/\"><strong>cách vệ sinh tai cho mèo</strong></a> để vệ sinh cho bé đúng cách nhé!</p><p>Thông thường các bạn sẽ có xu hướng vệ sinh tai mèo bằng tăm bông. Tuy nhiên đây là cách làm khá nguy hiểm vì có thể gây tổn thương bên trong tai mèo.</p><p>Việc vệ sinh tai mèo thường xuyên sẽ giúp cho bạn ngăn ngừa được bệnh rận ở mèo. Trong trường hợp bạn khá nhát tay, không thể tự vệ sinh vì chưa biết cách thì có thể đưa đến cơ sở thú y để được hỗ trợ.</p><p>Khi bạn thấy móng tay của mèo quá dài thì hãy nhanh chóng cắt chúng. Bạn nên tập thói quen này cho mèo từ khi chúng còn nhỏ để về sau dễ dàng cắt móng hơn.</p><h2><strong>Chế độ dinh dưỡng khi nuôi mèo anh lông ngắn</strong></h2><p><a href=\"https://kinpetshop.com/meo-an-gi/\">Nên cho mèo ăn gì</a>? là một câu hỏi luôn được đặt ra khi chúng ta nhận nuôi một bé mèo. Chính vì&nbsp;chế độ dinh dưỡng quyết định quan trọng đến sức khỏe của bé mèo nhà bạn. Việc xác định đúng nhu cầu dinh dưỡng là <strong>cách nuôi mèo Anh lông ngắn</strong> cơ bản nhất mà bạn cần nắm.</p><h3><strong>Đảm bảo thức ăn đúng độ tuổi</strong></h3><p>Đầu tiên bạn cần phải đảm bảo được thức ăn đúng với độ tuổi và nhu cầu dinh dưỡng của bé. Khi nào anh lông ngắn còn bé, chúng cần được ăn những thức ăn riêng dành cho mèo con và uống bổ sung thêm sữa nếu cần thiết.</p><p>Nhưng khi chúng đã lớn hơn 1 tuổi, chúng sẽ cần một chế độ dinh dưỡng hoàn toàn khác. Bạn có thể tham khảo bác sĩ thú y về chế độ dinh dưỡng dành cho mèo trưởng thành.</p><p>Cột mốc để phân chia giai đoạn phát triển của mèo như sau: mèo trưởng thành sẽ trên 12 tháng tuổi và mèo con sẽ dưới 12 tháng tuổi. Vì mèo trưởng thành sẽ ít năng động hơn mèo con, nên chế độ dinh dưỡng cũng vì vậy mà thay đổi.</p><h3><strong>Lựa chọn thức ăn chất lượng</strong></h3><p>Nhằm đảm bảo mèo có thể phát triển hoàn thiện, bạn cần chọn cho bé các loại thức ăn chất lượng cao. Đây là những loại thức ăn giúp cân bằng chế độ dinh dưỡng, tỷ lệ khoáng chất và vitamin được cung cấp hợp lý.</p><p><i>Lựa chọn thức ăn chất lượng giúp cơ thể cân bằng, khỏe mạnh</i></p><p>Những loại thực phẩm bổ dưỡng cho mèo sẽ bao gồm thịt, hải sản, phụ phẩm. Những thành phần này sẽ được ưu tiên vì chúng có hàm lượng axit béo và axit amin cao, thích hợp với sự phát triển của mèo.</p><p>Nếu như bạn có thời gian, bạn có thể tự chuẩn bị pate dành cho bé mèo. Pate tươi tự làm sẽ đảm bảo vệ sinh, không có chất bảo quản nên an toàn cho sức khỏe của bé. Nhược điểm duy nhất của loại pate này chính là không bảo quản được lâu nên bạn có thể cân nhắc.</p><h3><strong>Thức ăn hợp khẩu vị</strong></h3><p>Cũng giống như con người, mỗi bé mèo sẽ có một khẩu vị riêng. Một số bé sẽ thích vị hải sản như cá ngừ, tôm,… nhưng một số bé khác sẽ thích vị thịt gà. Vì vậy bạn cần phải xác định được bé mèo nhà bạn thích vị gì.</p><p>Để có thể tìm ra được khẩu vị yêu thích của thú cưng, bạn nên thử qua nhiều loại pate khác nhau để xem phản ứng của chúng. Ngoài ra thì bạn có thể xen kẽ giữa pate và hạt khô để giúp bé mèo không bị chán ăn.</p><p>Chủ thú cưng có thể mua thêm bánh thưởng, phô mai cho mèo, gel dinh dưỡng,… bổ sung vào bữa ăn hàng ngày. Tuy nhiên bạn cần lưu ý rằng đây chỉ là thực phẩm bổ trợ, không thể thay thế bữa ăn chính 100%.</p><h3><strong>Cung cấp nước sạch hàng ngày</strong></h3><p>Cho dù mèo của bạn là mèo con hay mèo trưởng thành, việc cung cấp nước sạch để chúng uống hàng ngày là điều vô cùng cần thiết. Mèo cần nước để giúp chúng tiêu hóa, giữ ấm cơ thể, loại bỏ chất thải,…</p><p><i>Mất nước có thể dẫn đến tình trạng kiệt sức ở mèo</i></p><p>Vì vậy bạn hãy đảm bảo việc cung cấp nước sạch hàng ngày cho chúng là điều cần thiết. Nếu như mèo mất nước có thể dẫn đến tình trạng táo bón, tắc nghẽn niệu đạo ở mèo đực,… Đặc biệt là vào mùa hè, việc mất nước còn làm cho mèo bị say nắng, kiệt sức.</p><p>&nbsp;</p><h3><strong>Tránh cho mèo ăn quá no</strong></h3><p>Vì mèo Anh lông ngắn là loài mèo khá lười vận động nên sẽ rất dễ xảy ra tình trạng béo phì. Nhằm hạn chế tình trạng này xảy ra, bạn chỉ nên cho mèo ăn khẩu phần vừa đủ, phù hợp với thể trạng của chúng.</p><p>Trung bình mèo Anh lông ngắn khi trưởng thành sẽ dao động từ 4.1 đến 8.2 kg. Nếu như mèo đã vượt qua ngưỡng này thì khả năng cao bé đang bị béo phì.</p><p>Mèo béo phì rất dễ bị mắc những bệnh về đường tiết niệu và xương khớp. Bạn phát hiện mèo của bạn đang tăng cân quá mức, hãy cắt giảm khẩu phần ăn cho đến khi số cân quay về tình trạng ổn định.</p><p>Bạn có thể khuyến khích mèo tập thể dục hoặc cùng chơi với mèo các trò hoạt động thể chất. Các hành động này sẽ giúp mèo đốt đi lượng mỡ thừa không cần thiết trong người, nhanh chóng lấy lại số cân nặng ban đầu.</p><blockquote><p><i>Gợi ý cho bạn những bài viết có liên quan như: </i><a href=\"https://kinpetshop.com/meo-mang-thai-bao-lau/#meo-chua-may-thang\"><i>mèo chửa mấy tháng</i></a><i>, </i><a href=\"https://kinpetshop.com/nuoi-meo-can-gi/\"><i>nuôi mèo cần gì</i></a><i> và </i><a href=\"https://kinpetshop.com/cach-nuoi-meo-con/\"><i>kinh nghiệm nuôi mèo con</i></a><i>. Các bài viết này sẽ cung cấp đến bạn những lưu ý cần thiết cho việc chăm sóc một chú mèo để đạt hiệu quả tốt nhất, hãy tham khảo ngay nhé!</i></p></blockquote><h2><strong>Kích thích hoạt động thể chất của mèo</strong></h2><p>Như chúng mình đã đề cập bên trên, hoạt động thể chất giúp cho mèo lúc đi lượng mỡ thừa trong người. Việc này còn giúp cho mèo tránh tình trạng bị trầm cảm hoặc stress. Sau đây là một vài trò chơi giúp bạn kích thích sự hoạt động thể chất ở mèo.</p><ul><li><strong>Cần câu mèo:</strong> Đây là đồ chơi mèo có hình dáng giống như một cần câu cá, được gắng một con cá giả hoặc lông vũ để câu mèo.</li></ul><p>Bạn có thể kích thích bằng cách treo cần câu lên khu vực gần đầu của mèo, di chuyển qua lại để tạo sự thu hút. Trò chơi này sẽ giúp bạn rèn luyện được tính phản xạ ở mèo.</p><ul><li><strong>Tung bóng cho mèo:</strong> Mèo Anh lông dài có xu hướng yêu thích đuổi theo các vật nhỏ, tròn, chuyển động.</li></ul><p>Vì vậy bạn có thể dùng quả bóng nhựa nhỏ, hoặc vo tròn cuộn giấy rồi vứt đi xa để mèo nhặt lại. Nếu như mèo đã bắt được bóng, hãy tiếp tục ném để bé được chơi đùa.</p><ul><li><strong>Đèn laser:</strong> Ánh đèn laser là điều khiến mèo hào hứng khi nhìn thấy. Bạn chỉ cần bật đèn, chiếu tia laser vào 1 điểm, khi mèo đến điểm đó thì hãy chuyển sang điểm khác. Trò chơi này giúp các bé mèo rất vui và thích được chơi.</li><li><strong>Bàn cào: </strong>Cào móng là một hoạt động giúp cho bé mèo được thư giãn tinh thần. Bạn có thể tham khảo một số loại bàn cào đang được bán phổ biến để chọn cho bé nhé!</li><li><strong>Cattree:</strong> Hay còn gọi là nhà cây cho mèo. Nhà cây là không gian để bé vui đùa, thư giãn, xả stress. Việc di chuyển hàng ngày sẽ giúp bé rèn luyện được thể chất.</li></ul><h2><strong>Nuôi mèo anh lông ngắn mua đồ dùng ở đâu tốt chính hãng</strong></h2><p>Có thể khẳng định rằng, cách để nuôi mèo Anh lông ngắn hiệu quả chính là cho bé sử dụng những thực phẩm chất lượng. Khi mua sản phẩm tại các địa chỉ uy tín, bạn sẽ không còn quá quan ngại về vấn đề chất lượng sản phẩm.</p><p>Một trong những thiên đường dành cho các bạn yêu mèo tại Thành phố Hồ Chí Minh chính là Kin Neko Petshop. Cửa hàng được xem là một hệ sinh thái dành cho thú cưng khi có đầy đủ các sản phẩm như thức ăn, đồ chơi, quần áo,… cho mèo. Đặc biệt là dịch vụ <a href=\"https://kinpetshop.com/khach-san-cho-meo-tphcm/\"><strong>khách sạn thú cưng TPHCM</strong></a> sẽ là một giải pháp tối ưu cho bạn khi cần chăm sóc hộ thú cưng của mình.</p><p>Điểm nổi bật làm nên tên tuổi của cửa hàng này chính là tất cả những sản phẩm đều đã qua kiểm định về chất lượng và giá thành hợp lý. Dù mèo của bạn đang ở độ tuổi nào, cần thức ăn cung cấp chất dinh dưỡng gì, tại Kin Neko đều có thể đáp ứng.</p><p>Bên cạnh đó, tại Kin Neko Petshop còn có dịch vụ Grooming, giúp chăm sóc bộ lông của bé hiệu quả, hạn chế rụng lông. Nếu như bạn vẫn chưa biết cách chải lông mèo thì dịch vụ Grooming sẽ là một giải pháp tuyệt vời để hỗ trợ bạn.</p><p>Ngoài ra trước khi bạn mua hàng sẽ được nhân viên tư vấn rõ ràng về nguồn gốc và công dụng của sản phẩm. Từ đó bạn sẽ quyết định xem sản phẩm có thực sự phù hợp với nhu cầu của mình hay không.</p><p>Kin Neko còn là trại mèo với nhiều giống mèo khác nhau, được nhập khẩu và có giấy chứng nhận về nguồn gốc của các bé. Vì vậy nếu như bạn muốn mang một bé Anh lông ngắn về nhà thì có thể ghé Kin Neko để tham khảo.</p>', '2025-10-28 07:10:38.000000', 'cam-nang-nuoi-duong-va-cham-soc-meo-anh-long-ngan-cho-nguoi-moi', '1761635438186-mona-magnussen-a7bdqjeG6M4-unsplash.jpg', 'Cẩm nang nuôi dưỡng và chăm sóc mèo Anh lông ngắn cho người mới', NULL, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `total_amount` double DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `shipping_address` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `receiver_name` varchar(255) DEFAULT NULL,
  `receiver_phone` varchar(255) DEFAULT NULL,
  `order_code` varchar(255) NOT NULL,
  `response_code` varchar(255) DEFAULT NULL,
  `transaction_code` varchar(255) DEFAULT NULL,
  `session_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_detail`
--

CREATE TABLE `order_detail` (
  `id` bigint(20) NOT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `password_reset_token`
--

CREATE TABLE `password_reset_token` (
  `id` bigint(20) NOT NULL,
  `expiry_date` datetime(6) DEFAULT NULL,
  `token` varchar(255) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `password_reset_token`
--

INSERT INTO `password_reset_token` (`id`, `expiry_date`, `token`, `user_id`) VALUES
(1, '2025-10-17 11:19:30.000000', 'dc5ac4ce-203c-4e42-9754-627dfa79589d', 12),
(2, '2025-10-17 11:20:13.000000', 'ee05e27f-555c-490e-9e89-0df41d4bb585', 36),
(3, '2025-10-17 11:23:34.000000', '9f03d82c-b93c-4994-bc22-5ac0cd4a839e', 36),
(4, '2025-10-17 11:23:48.000000', '1d63aed0-e174-47e5-bd61-79adbf27d246', 36),
(5, '2025-10-17 11:25:52.000000', '81ed0449-f545-42d6-8582-248e6116b06f', 36),
(7, '2025-10-17 11:29:50.000000', 'cd103eab-a74f-43be-b06c-9277af741b2b', 37),
(8, '2025-10-17 11:30:44.000000', 'e733fcbf-c0a7-4286-8122-54020a054dfe', 37),
(9, '2025-10-17 11:42:14.000000', '7594a17a-30c5-46de-991a-7b69b91d1e98', 12),
(10, '2025-10-17 11:42:17.000000', 'e8f8fc37-baf8-4df7-9a24-9cefa849f2eb', 12),
(11, '2025-10-17 11:47:46.000000', 'f818a2e8-9d66-41dc-9c71-01c9eb5c4cd8', 37),
(12, '2025-10-17 11:51:29.000000', '296034e4-5a26-47bd-8813-4af0b9357c15', 37),
(13, '2025-10-22 14:53:20.000000', '6c4659e8-5ac1-451f-9f5a-00d068ff0573', 37),
(14, '2025-10-22 14:55:03.000000', 'c56ffbe8-3e57-40e0-b0b5-b3dc67f5a3f0', 37),
(15, '2025-10-22 14:58:35.000000', '9198ac7f-f4f9-4c17-9bea-337a4f4b54bf', 37),
(17, '2025-10-22 15:13:19.000000', '642bdf0d-a3c6-4e02-b7ba-7f9151c11d62', 37),
(18, '2025-10-22 15:14:17.000000', 'b99660e4-67ee-43cd-97d0-fa706ba69c1b', 37),
(19, '2025-10-22 15:15:06.000000', 'fa431bc0-451c-4393-83f4-3b6fe2004936', 37),
(21, '2025-10-22 17:06:31.000000', 'c1088c7c-4e76-42d9-8cb4-4993511ac6a8', 37);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `pet_types`
--

CREATE TABLE `pet_types` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `pet_types`
--

INSERT INTO `pet_types` (`id`, `name`, `slug`) VALUES
(1, 'Mèo', 'shop-meo'),
(2, 'Chó', 'shop-cho');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `id` bigint(20) NOT NULL,
  `subcategory_id` bigint(20) DEFAULT NULL,
  `brand_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `price` double DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `slug` varchar(255) DEFAULT NULL,
  `short_desc` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`id`, `subcategory_id`, `brand_id`, `name`, `description`, `price`, `stock`, `image_url`, `created_at`, `updated_at`, `slug`, `short_desc`) VALUES
(1, 1, 3, 'Whiskas Hạt Mèo Cá Ngừ 1.2kg', 'Whiskas Hạt Mèo Cá Ngừ 1.2kg là sản phẩm hạt thức ăn cho mèo chất lượng cao, được làm từ những nguyên liệu tươi ngon, đặc biệt là cá ngừ, giúp cung cấp đầy đủ dinh dưỡng cho mèo yêu của bạn. Với công thức đặc biệt, Whiskas giúp hỗ trợ hệ tiêu hóa khỏe mạnh, cải thiện lông mượt và mang lại sức khỏe tốt cho thú cưng.\n\nCung cấp protein từ cá ngừ giúp mèo duy trì cơ bắp khỏe mạnh và năng lượng dồi dào.\n\nVitamin và khoáng chất thiết yếu giúp hỗ trợ sức khỏe toàn diện, bao gồm cả hệ miễn dịch và thị giác của mèo.\n\nHạt dễ tiêu hóa, giúp thú cưng dễ dàng hấp thu dinh dưỡng và giảm thiểu vấn đề về tiêu hóa.\n\nĐặc biệt phù hợp với mèo mọi độ tuổi, từ mèo con đến mèo trưởng thành.\n\nThực phẩm này không chỉ giúp mèo yêu của bạn duy trì sức khỏe mà còn giúp chúng có một bộ lông bóng mượt, khỏe mạnh và một tinh thần năng động. Thích hợp cho các giống mèo yêu thích vị cá ngừ!', 120000, 36, 'whiskas1.jpg', '2025-09-22 10:36:40', '2025-11-22 14:10:36', 'whiskas-hat-meo-ca-ngu-1.2kg', 'Pate mèo vị cá ngừ mềm thơm, giàu dinh dưỡng, phù hợp cho mèo mọi độ tuổi.'),
(2, 1, 6, 'Me-O Hạt Mèo Hải Sản 1.5kg', 'Me-O Hạt Mèo Hải Sản 1.5kg là sự lựa chọn hoàn hảo cho những chú mèo yêu thích hương vị hải sản tươi ngon. Với công thức cân bằng, chứa các loại hải sản cao cấp, sản phẩm này cung cấp đầy đủ các dưỡng chất thiết yếu cho mèo, bao gồm protein, vitamin và khoáng chất giúp cải thiện sức khỏe và bộ lông bóng mượt.\n\nHải sản tươi ngon cung cấp protein chất lượng cao cho sự phát triển và duy trì cơ bắp.\n\nBổ sung Omega-3 và Omega-6 giúp bảo vệ sức khỏe tim mạch và duy trì một bộ lông bóng mượt.\n\nThành phần tự nhiên, không chứa hóa chất hay phẩm màu nhân tạo, an toàn cho sức khỏe của thú cưng.\n\nCông thức dễ tiêu hóa, giúp mèo yêu của bạn có một hệ tiêu hóa khỏe mạnh và không gặp phải các vấn đề tiêu hóa.\n\nMe-O Hạt Mèo Hải Sản 1.5kg là sản phẩm hạt ăn đầy đủ dinh dưỡng cho mèo, đặc biệt là những chú mèo thích ăn các món hải sản.', 110000, 31, 'meo1.jpg', '2025-09-22 10:36:40', '2025-11-22 14:11:22', 'me-o-hat-meo-hai-san-15kg', 'Pate mèo vị cá ngừ mềm thơm, giàu dinh dưỡng, phù hợp cho mèo mọi độ tuổi.'),
(3, 2, 3, 'Whiskas Pate Mèo Vị Gà 85g', 'Whiskas Pate Mèo Vị Gà 85g là món ăn bổ sung dinh dưỡng tuyệt vời cho mèo yêu của bạn. Với vị gà thơm ngon, pate Whiskas mang đến cho mèo một bữa ăn đầy hương vị và chất lượng dinh dưỡng cao. Pate mềm, dễ ăn, phù hợp cho mèo kén ăn hoặc mèo nhỏ tuổi.\n\nHàm lượng protein từ gà giúp mèo duy trì cơ bắp khỏe mạnh.\n\nVitamin và khoáng chất thiết yếu, hỗ trợ hệ miễn dịch và sức khỏe tổng thể.\n\nKết cấu mềm mịn, dễ dàng cho mèo ăn và tiêu hóa.\n\nKhông chứa phẩm màu hay chất bảo quản độc hại, an toàn cho sức khỏe của mèo.\n\nSản phẩm này không chỉ là một món ăn bổ dưỡng mà còn giúp bạn chăm sóc thú cưng yêu quý với sự tiện lợi và dinh dưỡng vượt trội.', 15000, 97, 'whiskas_pate.jpg', '2025-09-22 10:36:40', '2025-11-22 14:11:22', 'whiskas-pate-meo-vi-ga-85g', 'Pate mèo vị cá ngừ mềm thơm, giàu dinh dưỡng, phù hợp cho mèo mọi độ tuổi.'),
(4, 2, 6, 'Me-O Pate Mèo Cá Ngừ 85g', 'Me-O Pate Mèo Cá Ngừ 85g là món ăn hoàn hảo cho những chú mèo yêu thích hương vị cá ngừ. Với công thức đặc biệt và chất lượng tuyệt vời, sản phẩm này cung cấp đầy đủ các dưỡng chất giúp mèo phát triển khỏe mạnh, duy trì bộ lông bóng mượt và năng lượng dồi dào.\n\nHương vị cá ngừ tươi ngon, là món ăn ưa thích của nhiều chú mèo.\n\nCung cấp vitamin và khoáng chất, giúp hỗ trợ sức khỏe xương, mắt và hệ miễn dịch của mèo.\n\nDễ ăn, dễ tiêu hóa với kết cấu pate mềm mịn, phù hợp với mọi giống mèo.\n\nKhông có chất bảo quản hay phẩm màu nhân tạo, an toàn cho sức khỏe của thú cưng.\n\nMe-O Pate Mèo Cá Ngừ 85g sẽ là món ăn bổ sung dinh dưỡng hoàn hảo cho mèo yêu của bạn, giúp chúng luôn khỏe mạnh và năng động.', 14000, 79, 'meo_pate.jpg', '2025-09-22 10:36:40', '2025-11-22 14:11:22', 'me-o-pate-meo-ca-ngu-85g', 'Pate mèo vị cá ngừ mềm thơm, giàu dinh dưỡng, phù hợp cho mèo mọi độ tuổi.'),
(5, 3, 3, 'Whiskas Súp Thưởng Vị Cá Hồi', 'Whiskas Súp Thưởng Vị Cá Hồi là món ăn bổ sung tuyệt vời dành cho mèo, đặc biệt là những chú mèo yêu thích vị cá hồi. Sản phẩm này không chỉ là một bữa ăn thơm ngon mà còn là món ăn vặt bổ sung năng lượng và vitamin cho mèo yêu của bạn.\n\nCung cấp omega-3 giúp bảo vệ sức khỏe tim mạch và duy trì bộ lông mềm mượt.\n\nThành phần tự nhiên, dễ tiêu hóa, giúp mèo hấp thu dinh dưỡng tốt hơn.\n\nSúp thưởng mềm mịn, dễ ăn và kích thích vị giác của mèo.\n\nKhông có chất bảo quản hay phẩm màu nhân tạo, an toàn cho thú cưng.\n\nWhiskas Súp Thưởng Vị Cá Hồi không chỉ là một món ăn vặt hấp dẫn mà còn là cách giúp bạn tạo niềm vui cho mèo yêu, đồng thời bổ sung thêm dưỡng chất cần thiết cho chúng.', 20000, 63, 'whiskas_soup.jpg', '2025-09-22 10:36:40', '2025-11-22 14:11:22', 'whiskas-sup-thuong-vi-ca-hoi', 'Súp thưởng vị cá hồi thơm ngon, kích thích ăn uống và bổ sung năng lượng cho mèo.'),
(6, 4, 4, 'Sanicat Cát Vệ Sinh 10L', 'Sanicat Cát Vệ Sinh 10L là sản phẩm cát vệ sinh chất lượng cao cho mèo, với công nghệ vón cục giúp dễ dàng vệ sinh và giữ cho không gian sống của thú cưng luôn sạch sẽ. Sản phẩm này không chỉ kiểm soát mùi hiệu quả mà còn bảo vệ sức khỏe của mèo yêu, nhờ vào các thành phần tự nhiên, an toàn và thân thiện với môi trường.\n\nKhả năng vón cục siêu tốt, giúp việc dọn dẹp nhanh chóng và dễ dàng.\n\nKhử mùi hiệu quả trong suốt thời gian sử dụng, giữ không gian luôn thơm mát.\n\nChất liệu tự nhiên, an toàn cho sức khỏe của mèo và môi trường.\n\nDễ dàng sử dụng và bảo quản, giúp tiết kiệm thời gian và công sức trong việc chăm sóc thú cưng.\n\nSanicat Cát Vệ Sinh 10L là lựa chọn lý tưởng cho các chủ nuôi mèo, giúp duy trì môi trường sống sạch sẽ và thoải mái cho mèo yêu.', 180000, 24, 'sanicat.jpg', '2025-09-22 10:36:40', '2025-11-22 14:12:55', 'sanicat-cat-ve-sinh-10l', 'Cát vệ sinh vón cục 10L khử mùi tốt, phù hợp mọi loại nhà vệ sinh cho mèo.'),
(7, 5, 5, 'SOS Sữa Tắm Cho Mèo', 'SOS Sữa Tắm Cho Mèo là sản phẩm sữa tắm chuyên dụng giúp làm sạch và dưỡng lông cho mèo, giữ cho chúng luôn thơm tho và khỏe mạnh. Sản phẩm được chiết xuất từ các thành phần tự nhiên, không gây kích ứng, đảm bảo an toàn cho làn da nhạy cảm của mèo.\n\nDưỡng lông mềm mượt, giúp bộ lông của mèo luôn bóng bẩy và dễ chải.\n\nKhử mùi hiệu quả, giữ cho mèo luôn thơm tho sau mỗi lần tắm.\n\nDành cho tất cả loại lông, đặc biệt là những chú mèo có da nhạy cảm.\n\nKhông chứa hóa chất độc hại, an toàn và nhẹ nhàng với da mèo.\n\nSOS Sữa Tắm Cho Mèo là sự lựa chọn hoàn hảo cho những chú mèo cần được chăm sóc lông và da thường xuyên, mang lại vẻ ngoài xinh đẹp và khỏe mạnh.', 220000, 20, 'sos_meo.jpg', '2025-09-22 10:36:40', '2025-11-22 14:12:55', 'sos-sua-tam-cho-meo', 'Sữa tắm cho mèo giúp làm sạch nhẹ nhàng, khử mùi và dưỡng mượt lông.'),
(8, 11, 6, 'Chuồng Mèo Nhựa Cao Cấp', 'Chuồng Mèo Nhựa Cao Cấp là lựa chọn lý tưởng để nuôi mèo trong nhà hoặc trong các không gian nhỏ. Sản phẩm được làm từ chất liệu nhựa bền bỉ, dễ dàng vệ sinh và mang lại không gian sống thoải mái cho mèo yêu. Thiết kế thoáng mát và chắc chắn, giúp bảo vệ mèo khỏi tác động từ môi trường bên ngoài.\n\nChất liệu nhựa cao cấp, dễ dàng làm sạch và chống bám bẩn.\n\nThiết kế thoáng khí, giúp không gian luôn thoáng mát và khô ráo.\n\nDễ dàng di chuyển nhờ vào cấu trúc nhẹ nhàng nhưng chắc chắn.\n\nPhù hợp cho mọi loại mèo, đặc biệt là mèo sống trong nhà hoặc trong những không gian nhỏ.\n\nChuồng Mèo Nhựa Cao Cấp không chỉ là nơi trú ẩn an toàn cho mèo mà còn giúp bảo vệ chúng khỏi các yếu tố bên ngoài, đồng thời giúp không gian sống của bạn gọn gàng hơn.', 350000, 15, 'cat_cage.jpg', '2025-09-22 10:36:40', '2025-11-22 14:12:55', 'chuong-meo-nhua-cao-cap', 'Chuồng nhựa thoáng khí, bền nhẹ, phù hợp nuôi mèo trong nhà.'),
(9, 8, 6, 'Đồ Chơi Bóng Len Cho Mèo', 'Đồ Chơi Bóng Len Cho Mèo là món đồ chơi lý tưởng để giúp mèo yêu của bạn vận động, giải trí và giảm căng thẳng. Với chất liệu len mềm mại và màu sắc bắt mắt, sản phẩm này chắc chắn sẽ làm cho mèo của bạn thích thú mỗi khi chơi đùa.\n\nChất liệu len mềm mại, an toàn cho sức khỏe của mèo khi chơi.\n\nMàu sắc bắt mắt, thu hút sự chú ý của mèo và khuyến khích chúng vận động.\n\nKích thước vừa phải, dễ dàng cho mèo cầm nắm và chơi đùa.\n\nGiúp mèo giải trí, giảm stress và tăng cường sức khỏe nhờ vào việc vận động.\n\nĐồ Chơi Bóng Len Cho Mèo không chỉ giúp mèo yêu vui vẻ mà còn hỗ trợ chúng phát triển thể chất và tinh thần một cách toàn diện.', 30000, 60, 'cat_toy.jpg', '2025-09-22 10:36:40', '2025-11-22 14:12:55', 'do-choi-bong-len-cho-meo', 'Đồ chơi bóng len mềm, an toàn cho mèo, giúp mèo vận động và giải trí.'),
(10, 13, 1, 'Royal Canin Hạt Chó Con 2kg', 'Royal Canin Hạt Chó Con 2kg là sản phẩm thức ăn đặc biệt dành cho chó con, giúp hỗ trợ sự phát triển khỏe mạnh trong giai đoạn đầu đời. Với công thức dinh dưỡng chuyên biệt, hạt thức ăn này cung cấp đầy đủ các dưỡng chất thiết yếu để chó con phát triển toàn diện về thể chất và trí tuệ.\n\nCung cấp protein cao cấp, giúp phát triển cơ bắp và mô cơ cho chó con.\n\nChứa DHA và EPA, hỗ trợ phát triển trí não và hệ thần kinh của chó con.\n\nHỗ trợ hệ tiêu hóa khỏe mạnh, với các thành phần dễ tiêu hóa giúp chó con hấp thụ tối đa dưỡng chất.\n\nThành phần vitamin và khoáng chất, giúp tăng cường sức khỏe xương và hệ miễn dịch.\n\nRoyal Canin Hạt Chó Con 2kg là lựa chọn tuyệt vời để nuôi dưỡng chó con trong giai đoạn phát triển, giúp chúng trở thành những chú chó khỏe mạnh và thông minh.', 450000, 0, 'rc_puppy.jpg', '2025-09-22 10:36:40', '2025-11-22 14:12:55', 'royal-canin-hat-cho-con-2kg', 'Hạt cho chó con giàu dinh dưỡng, hỗ trợ phát triển xương và hệ tiêu hóa.'),
(11, 13, 7, 'SmartHeart Hạt Chó Trưởng Thành 3kg', 'SmartHeart Hạt Chó Trưởng Thành 3kg là sản phẩm thức ăn dành cho chó trưởng thành, giúp duy trì sức khỏe, sức bền và năng lượng dồi dào. Với công thức chứa thành phần dinh dưỡng tối ưu, SmartHeart là lựa chọn lý tưởng để chăm sóc chó trưởng thành.\n\nCung cấp protein từ thịt gà, giúp duy trì cơ bắp khỏe mạnh.\n\nDinh dưỡng cân bằng, hỗ trợ sức khỏe toàn diện và giúp chó có bộ lông mượt mà.\n\nHàm lượng omega-3 và omega-6, giúp duy trì sức khỏe tim mạch và lông khỏe mạnh.\n\nThực phẩm dễ tiêu hóa, giúp cải thiện hệ tiêu hóa của chó.\n\nSmartHeart Hạt Chó Trưởng Thành 3kg là giải pháp hoàn hảo để chăm sóc chó trưởng thành, giúp chúng luôn khỏe mạnh và năng động.', 320000, 21, 'sh_dog.jpg', '2025-09-22 10:36:40', '2025-11-22 14:12:55', 'smartheart-hat-cho-truong-thanh-3kg', 'Hạt cho chó trưởng thành giúp duy trì sức khỏe, lông mượt và năng lượng ổn định.'),
(12, 14, 1, 'Royal Canin Pate Chó 400g', 'Royal Canin Pate Chó 400g là pate dinh dưỡng dành cho chó trưởng thành, được chế biến từ các nguyên liệu chất lượng cao, cung cấp đủ protein và vitamin để duy trì sức khỏe toàn diện cho chó. Sản phẩm có kết cấu mềm mịn, dễ ăn, phù hợp với chó trưởng thành có khẩu vị kén ăn hoặc gặp vấn đề về răng miệng.\n\nCung cấp dinh dưỡng đầy đủ, hỗ trợ sức khỏe tổng thể cho chó trưởng thành.\n\nHàm lượng protein cao, giúp phát triển cơ bắp và duy trì cơ thể khỏe mạnh.\n\nDễ tiêu hóa, với thành phần dễ dàng hấp thu và không gây khó khăn cho chó trong việc tiêu hóa.\n\nHương vị hấp dẫn, kích thích khẩu vị của chó, ngay cả với những chú chó khó tính.\n\nRoyal Canin Pate Chó 400g là lựa chọn tuyệt vời để bổ sung dinh dưỡng cho chó trưởng thành, đặc biệt là những chú chó có thói quen ăn mềm hoặc cần chế độ ăn dễ tiêu hóa.', 60000, 39, 'rc_pate.jpg', '2025-09-22 10:36:40', '2025-11-22 14:12:55', 'royal-canin-pate-cho-400g', 'Pate chó vị thịt mềm mịn, giàu protein, dễ ăn và phù hợp mọi giống chó.'),
(13, 14, 2, 'Pedigree Pate Cho Chó Vị Bò 400g', 'Pedigree Pate Cho Chó Vị Bò 400g là pate cho chó trưởng thành, với hương vị bò thơm ngon và dễ ăn. Sản phẩm được chế biến từ thịt bò tươi ngon và các thành phần dinh dưỡng cân bằng, giúp hỗ trợ sức khỏe hệ tiêu hóa và tăng cường sức đề kháng cho chó.\n\nHương vị bò thơm ngon, giúp kích thích khẩu vị của chó, làm cho bữa ăn trở nên thú vị hơn.\n\nCung cấp đầy đủ protein, hỗ trợ cơ bắp và sức khỏe tổng thể.\n\nThành phần dinh dưỡng cân đối, giúp duy trì sự khỏe mạnh của hệ tiêu hóa và xương khớp.\n\nDễ ăn và dễ tiêu hóa, phù hợp với chó trưởng thành và chó có vấn đề về tiêu hóa.\n\nPedigree Pate Cho Chó Vị Bò 400g là sự lựa chọn lý tưởng để bổ sung dinh dưỡng cho chó trưởng thành, giúp chúng luôn khỏe mạnh và tràn đầy năng lượng.', 55000, 42, 'ped_pate.jpg', '2025-09-22 10:36:40', '2025-11-22 14:12:55', 'pedigree-pate-cho-cho-vi-bo-400g', 'Pate chó vị bò 400g thơm ngon, giàu đạm, hỗ trợ tiêu hóa và sức khỏe toàn diện.'),
(14, 15, 2, 'Pedigree Bánh Thưởng 500g', 'Pedigree Bánh Thưởng 500g là loại bánh thưởng cho chó, được chế biến từ những nguyên liệu tự nhiên, bổ sung các vitamin và khoáng chất cần thiết để duy trì sức khỏe chó. Với hương vị hấp dẫn và chất lượng dinh dưỡng vượt trội, sản phẩm là phần thưởng tuyệt vời cho chó sau mỗi lần huấn luyện hoặc chơi đùa.\n\nBổ sung canxi và vitamin, giúp hỗ trợ sức khỏe răng miệng và hệ xương khớp cho chó.\n\nDễ dàng chia thành nhiều phần nhỏ, thích hợp để huấn luyện chó hoặc dùng làm bữa ăn nhẹ.\n\nHương vị thơm ngon, kích thích khẩu vị của chó, giúp chúng thưởng thức bữa ăn đầy hứng khởi.\n\nDễ dàng bảo quản, giữ bánh thưởng luôn tươi ngon và khô ráo.\n\nPedigree Bánh Thưởng 500g là món ăn vặt bổ dưỡng cho chó, giúp huấn luyện và tạo thói quen tốt cho thú cưng, đồng thời bổ sung năng lượng cho chúng trong suốt cả ngày.', 150000, 65, 'pedigree_treat.jpg', '2025-09-22 10:36:40', '2025-11-22 14:12:55', 'smartheart-banh-quy-cho-cho-400g', 'Bánh thưởng cho chó bổ sung canxi, giúp răng khỏe và hỗ trợ huấn luyện.'),
(15, 15, 7, 'SmartHeart Bánh Quy Cho Chó 400g', 'SmartHeart Bánh Quy Cho Chó 400g là bánh quy thơm ngon và giòn tan, thích hợp làm món ăn vặt bổ sung năng lượng cho chó. Với công thức dinh dưỡng đặc biệt, bánh quy này không chỉ ngon miệng mà còn giúp chăm sóc răng miệng cho chó, làm sạch răng và giữ hơi thở thơm tho.\n\nGiàu dinh dưỡng, cung cấp các vitamin và khoáng chất cần thiết cho chó.\n\nHỗ trợ sức khỏe răng miệng, với cấu trúc giòn giúp làm sạch răng và ngừa mảng bám.\n\nHương vị hấp dẫn, khiến chó yêu thích và dễ dàng ăn.\n\nThích hợp cho chó ở mọi độ tuổi, từ chó con đến chó trưởng thành.\n\nSmartHeart Bánh Quy Cho Chó 400g là món ăn vặt lý tưởng cho chó, giúp chúng vui vẻ và khỏe mạnh mỗi ngày, đồng thời là phần thưởng tuyệt vời trong các buổi huấn luyện.', 130000, 65, 'sh_biscuit.jpg', '2025-09-22 10:36:40', '2025-11-22 14:12:55', 'sos-sua-tam-cho-cho-nhay-cam', 'Bánh quy cho chó giòn ngon, thích hợp làm phần thưởng huấn luyện hàng ngày.'),
(16, 17, 5, 'SOS Sữa Tắm Cho Chó Nhạy Cảm', 'SOS Sữa Tắm Cho Chó Nhạy Cảm là sản phẩm chăm sóc lông và da chuyên biệt cho chó có da nhạy cảm. Với công thức dịu nhẹ, sản phẩm giúp làm sạch da mà không gây kích ứng, đồng thời dưỡng ẩm cho lông mềm mượt và khỏe mạnh.\n\nCông thức dịu nhẹ, không gây kích ứng cho da nhạy cảm của chó.\n\nGiúp dưỡng ẩm cho lông, giúp bộ lông của chó trở nên mềm mại và bóng bẩy.\n\nKhử mùi hiệu quả, giúp giữ cho chó luôn thơm tho sau khi tắm.\n\nDễ dàng sử dụng, phù hợp cho chó có da khô hoặc dễ bị dị ứng.\n\nSOS Sữa Tắm Cho Chó Nhạy Cảm là lựa chọn tuyệt vời để bảo vệ làn da và bộ lông của chó, mang đến sự thoải mái và an toàn khi sử dụng.', 250000, 13, 'sos_dog.jpg', '2025-09-22 10:36:40', '2025-11-22 14:12:55', 'dung-dich-ve-sinh-tai-cho', 'Sữa tắm cho chó nhạy cảm, dịu nhẹ, giảm kích ứng da và làm mềm lông.'),
(17, 18, 5, 'Dung Dịch Vệ Sinh Tai Chó', 'Dung Dịch Vệ Sinh Tai Chó là sản phẩm chăm sóc tai chó, giúp làm sạch và giảm mùi khó chịu trong tai thú cưng. Với thành phần an toàn và dịu nhẹ, sản phẩm này giúp ngăn ngừa viêm nhiễm tai và giữ cho tai chó luôn khô ráo và sạch sẽ.\n\nLàm sạch và khử mùi, giúp giữ tai chó luôn sạch sẽ và thơm tho.\n\nNgăn ngừa viêm nhiễm tai, hỗ trợ vệ sinh tai và giảm nguy cơ vi khuẩn phát triển.\n\nDễ sử dụng, giúp việc vệ sinh tai chó trở nên nhanh chóng và hiệu quả.\n\nThành phần dịu nhẹ, an toàn cho chó khi sử dụng.\n\nDung Dịch Vệ Sinh Tai Chó là sản phẩm cần thiết để bảo vệ đôi tai của chó khỏi các vấn đề vệ sinh, mang lại sự thoải mái và khỏe mạnh cho chúng.', 80000, 35, 'dog_ear_cleaner.jpg', '2025-09-22 10:36:40', '2025-11-22 14:12:55', 'day-dat-cho-nylon-cao-cap', 'Dung dịch vệ sinh tai cho chó giúp làm sạch nhẹ nhàng và giảm mùi khó chịu.'),
(18, 21, 7, 'Dây Dắt Chó Nylon Cao Cấp', 'Dây Dắt Chó Nylon Cao Cấp là sản phẩm được thiết kế chắc chắn và bền bỉ, phù hợp cho mọi loại chó, giúp bạn dễ dàng dắt chó đi dạo hoặc kiểm soát chúng trong các tình huống cần thiết. Dây dắt được làm từ chất liệu nylon chất lượng cao, vừa mềm mại vừa bền bỉ, mang đến sự thoải mái cho chó và chủ.\n\nChất liệu nylon bền bỉ, chịu được lực kéo mạnh mà không bị đứt gãy.\n\nThiết kế thoải mái, dễ dàng điều chỉnh độ dài để phù hợp với mọi kích cỡ chó.\n\nKhóa chắc chắn, giúp kiểm soát chó tốt hơn khi ra ngoài.\n\nDễ sử dụng và bảo quản, với khả năng gấp gọn khi không sử dụng.\n\nDây Dắt Chó Nylon Cao Cấp là lựa chọn lý tưởng để đi dạo cùng chó, giúp bạn dễ dàng kiểm soát chúng trong mọi tình huống.', 90000, 28, 'dog_leash.jpg', '2025-09-22 10:36:40', '2025-11-22 14:12:55', 'day-dat-ben-chat-cho-cho', 'Dây dắt nylon bền chắc, thoải mái cho thú cưng khi đi dạo.'),
(19, 20, 7, 'Áo Thời Trang Cho Chó Nhỏ', 'Áo Thời Trang Cho Chó Nhỏ là sự lựa chọn hoàn hảo cho những chú chó nhỏ yêu thích sự thoải mái và phong cách. Được làm từ chất liệu cotton mềm mại, chiếc áo này không chỉ giúp giữ ấm cho thú cưng trong những ngày lạnh mà còn làm tăng vẻ ngoài dễ thương, sành điệu của chúng.\n\nChất liệu cotton thoáng mát, mềm mại và nhẹ nhàng trên da, phù hợp cho các giống chó nhỏ và chó con.\n\nThiết kế dễ thương, với nhiều màu sắc và họa tiết bắt mắt, giúp chú chó trông thật phong cách.\n\nDễ dàng mặc vào và tháo ra, không gây khó chịu cho chó khi di chuyển.\n\nGiữ ấm cơ thể, đặc biệt là vào mùa đông, giúp chó cảm thấy thoải mái khi ra ngoài.\n\nÁo Thời Trang Cho Chó Nhỏ là món đồ không thể thiếu cho thú cưng của bạn, giúp chúng luôn xinh xắn và ấm áp trong mọi hoàn cảnh.', 120000, 25, 'dog_clothes.jpg', '2025-09-22 10:36:40', '2025-11-22 14:13:17', 'ao-thoi-trang-cho-cho-nho', 'Áo thời trang cho chó nhỏ, chất liệu cotton mềm, ôm vừa vặn và dễ thương.'),
(24, 15, 1, 'Pedigree Bánh Thưởng 500g', 'Pedigree Bánh Thưởng 500g là món bánh thưởng bổ dưỡng cho chó, giúp thú cưng của bạn luôn khỏe mạnh và năng động. Được chế biến từ nguyên liệu tự nhiên, sản phẩm cung cấp các vitamin và khoáng chất cần thiết để duy trì sức khỏe và tăng cường sức đề kháng cho chó.\n\nBổ sung canxi và vitamin, giúp phát triển hệ xương và duy trì sức khỏe răng miệng cho chó.\n\nThành phần dinh dưỡng cân đối, giúp duy trì mức năng lượng ổn định cho chó suốt cả ngày.\n\nHương vị hấp dẫn, kích thích khẩu vị của chó, là phần thưởng tuyệt vời trong quá trình huấn luyện.\n\nDễ sử dụng, có thể chia nhỏ thành từng miếng, thích hợp cho chó nhỏ hoặc chó lớn.\n\nPedigree Bánh Thưởng 500g là lựa chọn tuyệt vời để chăm sóc sức khỏe cho thú cưng, đồng thời làm phần thưởng trong những buổi huấn luyện hoặc chơi đùa.', 1, 11, '1758793978808-mona-magnussen-a7bdqjeG6M4-unsplash.jpg', '2025-09-24 13:52:18', '2025-11-22 14:13:17', 'pedigree-banh-thuong-500g', 'Bánh thưởng cho mèo/chó vị hấp dẫn, hỗ trợ bổ sung năng lượng nhanh.'),
(25, 1, 1, 'Hạt Natural Core thức ăn cho mèo con 400g (gói)', 'Hạt Natural Core Thức Ăn Cho Mèo Con 400g là thức ăn hạt dành cho mèo con dưới 1 tuổi, với công thức dinh dưỡng đặc biệt giúp hỗ trợ sự phát triển toàn diện của mèo con. Sản phẩm được sản xuất bởi thương hiệu Natural Core của Hàn Quốc, nổi tiếng với các sản phẩm chất lượng cao dành cho thú cưng.\n\nNguồn đạm động vật chất lượng cao, giúp phát triển cơ bắp và hệ miễn dịch cho mèo con.\n\nHàm lượng dinh dưỡng hoàn hảo, bao gồm các vitamin và khoáng chất cần thiết cho sự phát triển toàn diện.\n\nHương vị hấp dẫn, được chế biến từ thịt gà, cá hồi và các thành phần tự nhiên, giúp kích thích khẩu vị của mèo.\n\nDễ tiêu hóa, phù hợp cho hệ tiêu hóa còn non nớt của mèo con, giúp chúng dễ dàng hấp thụ và phát triển.\n\nHạt Natural Core Thức Ăn Cho Mèo Con 400g là lựa chọn lý tưởng để chăm sóc sức khỏe cho mèo con, giúp chúng phát triển mạnh mẽ và khỏe mạnh trong những năm tháng đầu đời.', 1, 0, '1758788870740-meo_pate.jpg', '2025-09-25 08:27:50', '2025-11-22 14:13:17', 'hat-natural-core-thuc-an-cho-meo-con-400g-goi', 'Hạt dinh dưỡng cho mèo con 400g, công thức hỗ trợ tiêu hóa và phát triển.'),
(39, 2, 10, 'Pate Gà Cá King’s Pet Túi 70gr Thức Ăn Cho Chó Mèo', 'Pate Gà Cá King’s Pet Túi 70gr là sản phẩm pate cho chó và mèo, được thiết kế đặc biệt với thành phần dinh dưỡng từ gà và cá, mang đến hương vị tươi ngon và giàu dinh dưỡng cho thú cưng của bạn. Đây là sản phẩm lý tưởng để thay đổi khẩu vị hoặc bổ sung thêm bữa ăn cho thú cưng trong ngày.\n\nHương vị thơm ngon như súp thưởng, thích hợp cho chó mèo kén ăn, giúp tăng cường sự ngon miệng và sức khỏe cho thú cưng.\n\nThành phần thịt gà và cá biển, cung cấp protein chất lượng cao, giúp xây dựng cơ bắp và hỗ trợ sự phát triển của chó mèo.\n\nCông thức dinh dưỡng hoàn hảo, hỗ trợ sự phát triển khỏe mạnh và duy trì sức khỏe của thú cưng.\n\nTiện lợi và dễ bảo quản, bao bì túi nhôm 1 đáy giúp bảo quản pate tươi ngon, dễ dàng sử dụng trong mỗi bữa ăn.\n\nPate Gà Cá King’s Pet Túi 70gr là món ăn bổ sung tuyệt vời cho chó mèo, mang đến bữa ăn ngon miệng và dinh dưỡng đầy đủ, hỗ trợ sức khỏe tổng thể cho thú cưng của bạn.', 15000, 109, '1761896550102-so-giun-cho-cho-05-768x768.jpg', '2025-10-31 07:42:30', '2025-11-22 14:13:17', 'pate-ga-ca-kings-pet-tui-70gr-thuc-an-cho-cho-meo', 'Pate gà cá dạng túi 70g cho chó mèo, mềm mịn, dễ ăn và giàu dinh dưỡng.');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'ADMIN'),
(2, 'CUSTOMER');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `subcategories`
--

CREATE TABLE `subcategories` (
  `id` bigint(20) NOT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `pet_type_id` bigint(20) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `subcategories`
--

INSERT INTO `subcategories` (`id`, `category_id`, `pet_type_id`, `name`, `slug`) VALUES
(1, 1, 1, 'Hạt cho mèo', 'thuc-an-hat-cho-meo'),
(2, 1, 1, 'Pate cho mèo', 'pate-cho-meo'),
(3, 1, 1, 'Súp thưởng', 'sup-thuong-cho-meo'),
(4, 2, 1, 'Cát vệ sinh cho mèo', 'cat-ve-sinh-cho-meo'),
(5, 2, 1, 'Nhà vệ sinh cho mèo', 'nha-ve-sinh-cho-meo'),
(6, 2, 1, 'Sữa tắm mèo', 'sua-tam-cho-meo'),
(7, 3, 1, 'Cào móng, nhà và đệm ngủ', 'nha-cho-meo'),
(8, 3, 1, 'Đồ chơi cho mèo', 'do-choi-cho-meo'),
(9, 3, 1, 'Quần áo cho mèo', 'quan-ao-cho-meo'),
(10, 3, 1, 'Vòng cổ cho mèo', 'vong-co-cho-meo'),
(11, 3, 1, 'Lồng vận chuyển cho mèo', 'long-van-chuyen-cho-meo'),
(12, 3, 1, 'Bát ăn cho mèo', 'bat-an-cho-meo'),
(13, 1, 2, 'Hạt cho chó', 'thuc-an-hat-cho-cho'),
(14, 1, 2, 'Pate cho chó', 'pate-cho-cho'),
(15, 1, 2, 'Bánh thưởng', 'banh-thuong-cho-cho'),
(16, 2, 2, 'Khay vệ sinh cho chó', 'khay-ve-sinh-cho-cho'),
(17, 2, 2, 'Sữa tắm chó', 'sua-tam-cho-cho'),
(18, 2, 2, 'Chăm sóc tai/mắt/miệng', 'cham-soc-tai-mat-mieng'),
(19, 3, 2, 'Đồ chơi cho chó', 'do-choi-cho-cho'),
(20, 3, 2, 'Quần áo cho chó', 'quan-ao-cho-cho'),
(21, 3, 2, 'Đây dắt cho chó', 'day-dat-cho-cho');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `full_name` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `role_id` bigint(20) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `avatar_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `full_name`, `phone`, `address`, `role_id`, `created_at`, `updated_at`, `avatar_url`) VALUES
(1, 'admin', '$2y$10$C5aTcQFSZP3awXh6MyFfYObnixUv2KfGCWdFXoKWMNYPGP8BrtT6a', 'admin@petshop.com', 'Admin', '0123456789', 'HCM', 1, '2025-09-22 10:36:40', '2025-10-19 03:59:11', '1758807556179-mona-magnussen-a7bdqjeG6M4-unsplash.jpg'),
(2, 'meo123', '$2y$10$C5aTcQFSZP3awXh6MyFfYObnixUv2KfGCWdFXoKWMNYPGP8BrtT6a', 'meo@gmail.com', 'Nguyen Van Meo', '0909123456', 'Hà Nội', 2, '2025-09-22 10:36:40', '2025-09-25 13:48:25', '1758808105331-be3b6afa82037b4fbd957df3cd1fbc71.jpg'),
(3, 'cho456', '123456', 'cho@gmail.com', 'Tran Van Cho', '0909234567', 'HCM', 2, '2025-09-22 10:36:40', '2025-09-22 10:36:40', NULL),
(4, 'petlover', '123456', 'petlover@gmail.com', 'Pham Thi Thu', '0909345678', 'Đà Nẵng', 2, '2025-09-22 10:36:40', '2025-09-22 10:36:40', NULL),
(5, 'ngocanh', '123456', 'ngocanh@gmail.com', 'Ngoc Anh', '0909456789', 'Cần Thơ', 2, '2025-09-22 10:36:40', '2025-10-22 02:39:21', '1761100761625-mona-magnussen-a7bdqjeG6M4-unsplash.jpg'),
(12, 'aaa', '$2a$10$USNWyu/SQn7CSoDDW55dy.6f93ROYvks0ShdKeeGwrywsauFMjE9K', 'a@gmail.com', 'a', '123', 'a', 2, '2025-09-25 08:48:50', NULL, '1758790130342-mona-magnussen-a7bdqjeG6M4-unsplash.jpg'),
(14, 'a', '$2a$10$8gKLlyPstqS/v8GGvMqdGufr16zodCs36d7zDjR21eP0TZDDvI7H2', 'aa@gmail.com', 'nguyen van a', '0123456789', '123 A', 2, '2025-09-26 13:48:46', '2025-10-30 07:20:02', '1760509469012-t_i_xu_ng.jpg'),
(16, 'aa', '$2a$10$lSNfh62jk7Nb/nzOTvmvr.9QUueYTwEJWMY6gtvQS1yuyp9.uuEU6', 'aadasd@gmail.com', 'a', '1', 'a', 2, '2025-09-26 15:00:34', NULL, '1758898834082-be3b6afa82037b4fbd957df3cd1fbc71.jpg'),
(17, 'qwe', '$2a$10$DQLzin3WzmY0lbCDZl34COP.Z0edpadw4eNgeqMSP3aeJSXz2GyhC', 'qweqw@gmail.com', 'nguyen q', '01231231231', '123 qwe', 2, '2025-10-05 07:35:25', NULL, '1759649725057-mona-magnussen-a7bdqjeG6M4-unsplash.jpg'),
(21, 'ab', '$2a$10$fDpOXX3eOVaIDelB3flc8eV9GuU4EDyr8jLgKCWTkzLK8RoOCtQd.', 'ab@gmail.com', 'ab', NULL, NULL, 2, '2025-10-14 03:28:19', NULL, NULL),
(22, 'abaa', '$2a$10$Nv2DmSPRRX5SsDrqB31pt.sW6kDcKoHaJ8YkA9XPZ.IEjJ8w7L6iS', 'abaa@gmail.com', 'aba', NULL, NULL, 2, '2025-10-15 01:23:41', NULL, NULL),
(23, 'aasdas', '$2a$10$1rJHMciqVwnYBybDJYgbAeQGr2oKIel0cUKyO0UhW/LaOaC53VH1G', 'abasb@gmail.com', 'ababas', NULL, NULL, 2, '2025-10-15 01:28:09', NULL, NULL),
(24, 'aádasdad', '$2a$10$R8dk1BGbuXVKbSve9rzn4e5WZf9VxZX8lydMUwW9vZQ9NbXy1gKXq', 'aádasdasd@gmail.com', 'aádasdasd', NULL, NULL, 2, '2025-10-15 01:55:47', NULL, NULL),
(25, 'aádasdadâ', '$2a$10$iMUEwETBQpDciVNK8PTeLud2/RBBThgdW.RojxByLRw.qgegCyHoy', '', 'aádasdasd', NULL, NULL, 2, '2025-10-15 01:57:05', NULL, NULL),
(26, 'aádasdadâaa', '$2a$10$OHz5NOWDNudaEE.ym327DOVyUFFkBAwrMNksrExFBsonm85d30t/G', 'aasdasdasdas@gmail.com', 'aádasdasd', NULL, NULL, 2, '2025-10-15 01:59:22', NULL, NULL),
(27, 'aádasdadâaa1', '$2a$10$jmhAcfWmmHxVrzbSMl/MY.G6jmyKHyl7oGhBqp4gaXaBYapq8pJ2G', 'aasdasda1sdas@gmail.com', 'aádasdasd', NULL, NULL, 2, '2025-10-15 01:59:43', NULL, NULL),
(28, 'aaaa', '$2a$10$Si9CIcd6d5dkH58IJr41fOmt3mlRild2qfRmm5zDBaRt/Npm0X2cm', 'aaa@gmail.com', 'a', NULL, NULL, 2, '2025-10-15 02:03:40', NULL, NULL),
(29, 'meo', '$2a$10$/NzZFyGswuiz3G8Dyrl32uJQdRrstO73X30yXvFVAhx/5Sc8/kQaG', 'meoa@gmail.com', 'Nguyễn meo meo', NULL, NULL, 2, '2025-10-15 02:04:25', NULL, NULL),
(30, 'abababa', '$2a$10$QX6IdhiH8coXT7rng8c9IuhvVP/ShK6R/jT9oHyj37/DO60yNjg0G', 'asdasdasdas@gmail.com', 'aasdasdasd', NULL, NULL, 2, '2025-10-15 02:24:09', NULL, '7f8fd49d-8848-4bef-8ee7-ee2c62c91473-default.jpg'),
(33, 'aqwe', '$2a$10$QX6IdhiH8coXT7rng8c9IuhvVP/ShK6R/jT9oHyj37/DO60yNjg0G', 'aqwe@gmail.com', 'aqwe', NULL, NULL, 2, '2025-10-15 07:34:25', '2025-10-15 14:36:45', '7f8fd49d-8848-4bef-8ee7-ee2c62c91473-default.jpg'),
(34, 'aqweq', '$2a$10$BF9kq8kawYzTVIzoixcs9eUplvuebIjvoqkqIkCb28N1cKVzbbhgu', 'aqweq@gmail.com', 'qwewq', '0912345678', 'a', 2, '2025-10-15 07:41:26', '2025-11-20 08:53:11', '1763628791895-be3b6afa82037b4fbd957df3cd1fbc71.jpg'),
(35, 'ádasdasdasd', '$2a$10$/.m2tJ2bqc9OIp5P.ADmGu21pA77DFNYDunmJs0u8JpmKZwzDyE1C', 'aasdasdasd@gmail.com', 'aaa', '0912345678', 'a', 2, '2025-10-15 09:28:00', '2025-10-15 09:28:00', '1760520480299-mona-magnussen-a7bdqjeG6M4-unsplash.jpg'),
(36, 'uec', '$2a$10$KRMA8Tl6ydfBVQaNf016XOpE.6dZ6o.2BRINkOofeD/ZP0eT9NWDS', 'uec76839@toaik.com', 'nguyên a', NULL, NULL, 2, '2025-10-17 03:50:09', '2025-10-17 03:50:09', '7f8fd49d-8848-4bef-8ee7-ee2c62c91473-default.jpg'),
(37, 'gamehay149', '$2a$10$nBVyukQMk2/rMhTH5.AOvOjbmD/2gUzxfWec8WkHEtPcQu.9EvSvC', 'gamehay149@gmail.com', 'gamehay', NULL, NULL, 2, '2025-10-17 03:56:40', '2025-10-17 03:56:40', '7f8fd49d-8848-4bef-8ee7-ee2c62c91473-default.jpg'),
(40, 'assssa', '$2a$10$vagpuiRarckbITcWmNJCY.uAOtOHZyhT5QwU2AOgwt3IVaF3xYcCa', 'assssa@gmail.com', 'meomeoa', '0912345678', 'a', 2, '2025-10-29 09:31:00', '2025-11-20 08:52:46', '7f8fd49d-8848-4bef-8ee7-ee2c62c91473-default.jpg'),
(41, 'meomeo', '$2a$10$F8rqXkvs8qakHq0398YakelrSQVHYlaRt01gG3Ow1j/nHHW9HxSl2', 'meomeoas@gmail.com', 'nguyenvan', NULL, NULL, 2, '2025-11-21 01:25:50', '2025-11-21 01:25:50', '7f8fd49d-8848-4bef-8ee7-ee2c62c91473-default.jpg');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `vouchers`
--

CREATE TABLE `vouchers` (
  `id` bigint(20) NOT NULL,
  `active` bit(1) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `discount_amount` double DEFAULT NULL,
  `discount_percent` double DEFAULT NULL,
  `end_date` datetime(6) DEFAULT NULL,
  `max_usage` int(11) NOT NULL,
  `min_order` double NOT NULL,
  `start_date` datetime(6) DEFAULT NULL,
  `used_count` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `cart_detail`
--
ALTER TABLE `cart_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_id` (`cart_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKi09n75txtudw1kawj5o7i8xag` (`user_id`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `password_reset_token`
--
ALTER TABLE `password_reset_token`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UKg0guo4k8krgpwuagos61oc06j` (`token`),
  ADD KEY `FK83nsrttkwkb6ym0anu051mtxn` (`user_id`);

--
-- Chỉ mục cho bảng `pet_types`
--
ALTER TABLE `pet_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `subcategory_id` (`subcategory_id`),
  ADD KEY `brand_id` (`brand_id`);

--
-- Chỉ mục cho bảng `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `subcategories`
--
ALTER TABLE `subcategories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `pet_type_id` (`pet_type_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`);

--
-- Chỉ mục cho bảng `vouchers`
--
ALTER TABLE `vouchers`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT cho bảng `carts`
--
ALTER TABLE `carts`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `cart_detail`
--
ALTER TABLE `cart_detail`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `news`
--
ALTER TABLE `news`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `password_reset_token`
--
ALTER TABLE `password_reset_token`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT cho bảng `pet_types`
--
ALTER TABLE `pet_types`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT cho bảng `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `subcategories`
--
ALTER TABLE `subcategories`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123123125;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT cho bảng `vouchers`
--
ALTER TABLE `vouchers`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `cart_detail`
--
ALTER TABLE `cart_detail`
  ADD CONSTRAINT `cart_detail_ibfk_1` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`),
  ADD CONSTRAINT `cart_detail_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Các ràng buộc cho bảng `news`
--
ALTER TABLE `news`
  ADD CONSTRAINT `FKi09n75txtudw1kawj5o7i8xag` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  ADD CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_detail_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Các ràng buộc cho bảng `password_reset_token`
--
ALTER TABLE `password_reset_token`
  ADD CONSTRAINT `FK83nsrttkwkb6ym0anu051mtxn` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Các ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`subcategory_id`) REFERENCES `subcategories` (`id`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`);

--
-- Các ràng buộc cho bảng `subcategories`
--
ALTER TABLE `subcategories`
  ADD CONSTRAINT `subcategories_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `subcategories_ibfk_2` FOREIGN KEY (`pet_type_id`) REFERENCES `pet_types` (`id`);

--
-- Các ràng buộc cho bảng `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
