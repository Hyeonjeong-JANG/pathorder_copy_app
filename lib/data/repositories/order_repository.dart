import 'package:dio/dio.dart';
import 'package:pathorder_app/_core/constants/http.dart';
import 'package:pathorder_app/data/dtos/order_request.dart';
import 'package:pathorder_app/data/dtos/response_dto.dart';
import 'package:pathorder_app/ui/home/store_detail/menu/payment/data/payment_header_data.dart';
import 'package:pathorder_app/ui/home/store_detail/menu/payment/data/payment_list_data.dart';
import 'package:pathorder_app/ui/home/store_detail/menu/payment/payment_page_view_model.dart';
import 'package:pathorder_app/ui/order_history/detail/data/order_detail_data.dart';
import 'package:pathorder_app/ui/order_history/detail/data/order_detail_list_data.dart';
import 'package:pathorder_app/ui/order_history/detail/detail_page_view_model.dart';

class OrderRepository {
  Future<ResponseDTO> fetchDetailOrder(
      String accessToken, int userId, int orderId) async {
    Response response = await dio.get("/api/users/${userId}/orders/${orderId}",
        options: Options(headers: {"Authorization": "${accessToken}"}));
    ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
    if (responseDTO.status == 200) {
      List<dynamic> temp = responseDTO.response["orderMenuList"];
      List<OrderDetailList> orderDetailList =
          temp.map((e) => OrderDetailList.fromJson(e)).toList();
      OrderDetail orderDetail = OrderDetail.fromJson(responseDTO.response);

      DetailPageModel detailPageModel = DetailPageModel(
          orderDetail: orderDetail, orderDetailList: orderDetailList);
      responseDTO.response = detailPageModel;
    }

    return responseDTO;
  }

  Future<ResponseDTO> fetchSaveOrder(
      String accessToken, OrderReqDTO reqDTO, int userId) async {
    Response response = await dio.post("/api/users/${userId}/orders",
        options: Options(headers: {"Authorization": "${accessToken}"}),
        data: reqDTO.toJson());

    ResponseDTO responseDTO = ResponseDTO.fromJson(response.data);
    if (responseDTO.status == 200) {
      List<dynamic> temp = responseDTO.response["orderMenuList"];
      List<PaymentListData> paymentList =
          temp.map((e) => PaymentListData.fromJson(e)).toList();
      PaymentHeaderData paymentHeader =
          PaymentHeaderData.fromJson(responseDTO.response);

      PaymentModel paymentModel =
          PaymentModel(paymentHeader: paymentHeader, paymentList: paymentList);
      responseDTO.response = paymentModel;
    }

    return responseDTO;
  }
}
