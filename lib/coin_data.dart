import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'D40C31DD-6FD4-4B3A-B52D-7567455DE06E';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, double> cryptoValue = {};
    for (String i in cryptoList) {
      String requestURL = '$coinAPIURL/$i/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(requestURL);

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        var lastPrice = decodedData['rate'];
        cryptoValue.putIfAbsent(i, () => lastPrice);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoValue;
  }
}
