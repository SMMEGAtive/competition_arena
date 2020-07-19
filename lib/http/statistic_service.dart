import 'package:competition_arena/http/api_service.dart';
import 'package:competition_arena/models/statistic_data.dart';
import 'package:http/http.dart';

class StatisticService {
  ApiServices api = ApiServices();
  Client client = Client();

  Future<List<StatisticData>> getStat() async {
    final response = await client.get('${api.base_url}/statistic',
        headers: await api.getNormalHeaders());

    List<StatisticData> data = statisticDataFromJson(response.body);
    print(data[0].username);

    return data;
  }
}
