import 'dart:convert';
import 'package:bitcoin/currincy.dart';
import 'package:http/http.dart' as http;

class CoinService {
  // Dynamically create the URL with all currencies
  String _buildCurrencyUrl() {
    String currencies = currencyCodes.join(",");  // Join the list into a comma-separated string
    return 'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,binancecoin,cardano&vs_currencies=$currencies';
  }

  Future<double> getBitcoinPrice1(String crypto,String currency) async {
    try {
      final url=_buildCurrencyUrl();
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Check if the data contains the selected currency
        if (data != null && data[crypto] != null && data[crypto][currency.toLowerCase()] != null) {
          return (data[crypto][currency.toLowerCase()] as num).toDouble(); // Return as double
        } else {
          throw Exception("Failed to fetch Bitcoin price data for $currency.");
        }
      } else {
        throw Exception("Failed to fetch Bitcoin price");
      }
    } catch (e) {
      print("Error: $e");
      throw Exception("An error occurred while fetching the Bitcoin price");
    }
  }

  
}
