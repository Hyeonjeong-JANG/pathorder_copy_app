import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pathorder_app/_core/constants/http.dart';
import 'package:pathorder_app/ui/home/home_page_view_model.dart';
import 'package:pathorder_app/ui/home/store_detail/store_detail_page.dart';

class NearMeStoreBody extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HomePageModel? model = ref.watch(homePageProvider);

    if (model == null) {
      return Center(child: CircularProgressIndicator());
    } else {
      return GridView.count(
        primary: false,
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        children: List.generate(
          model.stores.length,
          (index) => _buildNearMeStoreMenuItem(
            model.stores[index],
            context,
          ),
        ),
      );
    }
  }

  _buildNearMeStoreMenuItem(final store, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => StoreDetailPage(store.id)));
      },
      child: Container(
        padding: const EdgeInsets.all(0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  // 테두리의 모든 모서리를 10 픽셀의 원형으로 만듭니다.
                  child: Image.network(
                    '${baseUrl}/upload/${store.imgFilename}',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.placemark_fill,
                        color: Colors.grey[400],
                      ),
                      Text(
                        store.distance.toString(),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(width: 5),
                      Icon(
                        CupertinoIcons.heart_fill,
                        color: Colors.red,
                        size: 21,
                      ),
                      SizedBox(width: 5),
                      Text(
                        store.likeCount.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(width: 10),
                      Icon(
                        CupertinoIcons.chat_bubble_text,
                        size: 20,
                      ),
                      SizedBox(width: 5),
                      Text(
                        // TODO: commentCount 백엔드에서 받아야함
                        '155',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
