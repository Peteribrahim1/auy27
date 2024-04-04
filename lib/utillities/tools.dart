import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

class Tools {
  var _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  var banks = [
    {"sortCode": "090133", "name": " AL-Barakah Microfinance Bank"},
    {"sortCode": "090270", "name": "AB MICROFINANCE BANK"},
    {"sortCode": "090260", "name": "ABOVE ONLY MICROFINANCE BANK"},
    {"sortCode": "090197", "name": "ABU MICROFINANCE BANK"},
    {"sortCode": "100052", "name": "ACCESS YELLO &amp; BETA"},
    {"sortCode": "090268", "name": "ADEYEMI COLLEGE STAFF MICROFINANCE BANK"},
    {"sortCode": "090292", "name": "AFEKHAFE MICROFINANCE BANK"},
    {"sortCode": "100028", "name": "AG Mortgage Bank"},
    {"sortCode": "090259", "name": "ALEKUN MICROFINANCE BANK"},
    {"sortCode": "090297", "name": "ALERT MICROFINANCE BANK"},
    {"sortCode": "090169", "name": "ALPHA KAPITAL MICROFINANCE BANK"},
    {"sortCode": "090116", "name": "AMML MFB"},
    {"sortCode": "090282", "name": "ARISE MICROFINANCE BANK"},
    {"sortCode": "090001", "name": "ASOSavings & Loans"},
    {"sortCode": "090287", "name": "ASSETMATRIX MICROFINANCE BANK"},
    {"sortCode": "090172", "name": "ASTRAPOLARIS MICROFINANCE BANK"},
    {"sortCode": "090264", "name": "AUCHI MICROFINANCE BANK"},
    {"sortCode": "070010", "name": "Abbey Mortgage Bank"},
    {"sortCode": "000014", "name": "Access Bank"},
    {"sortCode": "000005", "name": "Access Bank (Diamond)"},
    {"sortCode": "100013", "name": "AccessMobile"},
    {"sortCode": "090134", "name": "Accion Microfinance Bank"},
    {"sortCode": "090160", "name": "Addosser Microfinance Bank"},
    {"sortCode": "090131", "name": "Allworkers Microfinance Bank"},
    {"sortCode": "090143", "name": "Apeks Microfinance Bank"},
    {"sortCode": "090188", "name": "BAINES CREDIT MICROFINANCE BANK"},
    {"sortCode": "090326", "name": "BALOGUN GAMBARI MICROFINANCE BANK"},
    {"sortCode": "090127", "name": "BC Kash Microfinance Bank"},
    {"sortCode": "090176", "name": "BOSAK MICROFINANCE BANK"},
    {"sortCode": "090308", "name": "BRIGHTWAY MICROFINANCE BANK"},
    {"sortCode": "090117", "name": "Boctrust Microfinance Bank"},
    {"sortCode": "090148", "name": "Bowen Microfinance Bank"},
    {"sortCode": "070015", "name": "Brent Mortgage Bank"},
    {"sortCode": "090154", "name": "CEMCS MICROFINANCE BANK"},
    {"sortCode": "090144", "name": "CIT Microfinance Bank"},
    {"sortCode": "100005", "name": "Cellulant"},
    {"sortCode": "090141", "name": "Chikum Microfinance Bank"},
    {"sortCode": "000009", "name": "Citi Bank"},
    {"sortCode": "090130", "name": "Consumer Microfinance Bank"},
    {"sortCode": "100032", "name": "Contec Global Infotech Limited (NowNow)"},
    {"sortCode": "060001", "name": "Coronation Merchant Bank"},
    {"sortCode": "070006", "name": "Covenant MFB"},
    {"sortCode": "090159", "name": "Credit Afrique Microfinance Bank"},
    {"sortCode": "090167", "name": "DAYLIGHT MICROFINANCE BANK"},
    {"sortCode": "090273", "name": "EMERALD MICROFINANCE BANK"},
    {"sortCode": "090166", "name": "ESO-E MICROFINANCE BANK"},
    {"sortCode": "100021", "name": "Eartholeum"},
    {"sortCode": "100030", "name": "EcoMobile"},
    {"sortCode": "000010", "name": "Ecobank Bank"},
    {"sortCode": "100008", "name": "Ecobank Xpress Account"},
    {"sortCode": "090097", "name": "Ekondo MFB"},
    {"sortCode": "090114", "name": "Empire trust MFB"},
    {"sortCode": "000019", "name": "Enterprise Bank"},
    {"sortCode": "090179", "name": "FAST MICROFINANCE BANK"},
    {"sortCode": "060002", "name": "FBN Merchant Bank"},
    {"sortCode": "090107", "name": "FBN Mortgages Limited"},
    {"sortCode": "100014", "name": "FBNMobile"},
    {"sortCode": "100031", "name": "FCMB Mobile"},
    {"sortCode": "090290", "name": "FCT MICROFINANCE BANK"},
    {"sortCode": "100001", "name": "FET"},
    {"sortCode": "090153", "name": "FFS Microfinance Bank"},
    {"sortCode": "090285", "name": "FIRST OPTION MICROFINANCE BANK"},
    {"sortCode": "400001", "name": "FSDH Merchant Bank"},
    {"sortCode": "000007", "name": "Fidelity Bank"},
    {"sortCode": "100019", "name": "Fidelity Mobile"},
    {"sortCode": "090126", "name": "Fidfund Microfinance Bank"},
    {"sortCode": "090111", "name": "FinaTrust Microfinance Bank"},
    {"sortCode": "000016", "name": "First Bank of Nigeria"},
    {"sortCode": "000003", "name": "First City Monument Bank"},
    {"sortCode": "070014", "name": "First Generation Mortgage Bank"},
    {"name": "Flutterwave Technology Solutions Limited"},
    {"sortCode": "070002", "name": "Fortis Microfinance Bank"},
    {"sortCode": "100016", "name": "FortisMobile"},
    {"sortCode": "090145", "name": "Fullrange Microfinance Bank"},
    {"sortCode": "090158", "name": "Futo Microfinance Bank"},
    {"sortCode": "000027", "name": "GLOBUS BANK"},
    {"sortCode": "090278", "name": "GLORY MICROFINANCE BANK"},
    {"sortCode": "090178", "name": "GREENBANK MICROFINANCE BANK"},
    {"sortCode": "090195", "name": "GROOMING MICROFINANCE BANK"},
    {"sortCode": "000013", "name": "GTBank Plc"},
    {"sortCode": "100009", "name": "GTMobile"},
    {"sortCode": "070009", "name": "Gateway Mortgage Bank"},
    {"sortCode": "090122", "name": "Gowans Microfinance Bank"},
    {"sortCode": "070017", "name": "HAGGAI MORTGAGE BANK LIMITED"},
    {"sortCode": "090175", "name": "HIGHSTREET MICROFINANCE BANK"},
    {"sortCode": "090147", "name": "Hackman Microfinance Bank"},
    {"sortCode": "090121", "name": "Hasal Microfinance Bank"},
    {"sortCode": "100017", "name": "Hedonmark"},
    {"sortCode": "000020", "name": "Heritage"},
    {"sortCode": "090118", "name": "IBILE Microfinance Bank"},
    {"sortCode": "090324", "name": "IKENNE MICROFINANCE  BANK"},
    {"sortCode": "090275", "name": "IKIRE MICROFINANCE BANK"},
    {"sortCode": "090258", "name": "IMO STATE MICROFINANCE BANK"},
    {"sortCode": "090149", "name": "IRL Microfinance Bank"},
    {"sortCode": "100024", "name": "Imperial Homes Mortgage Bank"},
    {"sortCode": "090157", "name": "Infinity Microfinance Bank"},
    {"sortCode": "070016", "name": "Infinity Trust Mortgage Bank"},
    {"sortCode": "100029", "name": "Innovectives Kesh"},
    {"sortCode": "100027", "name": "Intellifin"},
    {"sortCode": "000006", "name": "JAIZ Bank"},
    {"sortCode": "090003", "name": "JubileeLife Microfinance  Bank"},
    {"sortCode": "100015", "name": "Kegow"},
    {"sortCode": "000002", "name": "Keystone Bank"},
    {"sortCode": "090177", "name": "LAPO MICROFINANCE BANK"},
    {"sortCode": "090271", "name": "LAVENDER MICROFINANCE BANK"},
    {"sortCode": "070012", "name": "Lagos Building Investment Company"},
    {"sortCode": "090171", "name": "MAINSTREET MICROFINANCE BANK"},
    {"sortCode": "070019", "name": "MAYFRESH MORTGAGE BANK"},
    {"sortCode": "090280", "name": "MEGAPRAISE MICROFINANCE BANK"},
    {"sortCode": "090113", "name": "MICROVIS MICROFINANCE BANK"},
    {"sortCode": "090281", "name": "MINT-FINEX MICROFINANCE BANK"},
    {"sortCode": "090136", "name": "Microcred Microfinance Bank"},
    {"sortCode": "100011", "name": "Mkudi"},
    {"sortCode": "090129", "name": "Money Trust Microfinance Bank"},
    {"sortCode": "100020", "name": "MoneyBox"},
    {"sortCode": "090151", "name": "Mutual Trust Microfinance Bank"},
    {"sortCode": "090205", "name": "NEW DAWN MICROFINANCE BANK"},
    {"sortCode": "090263", "name": "NIGERIAN NAVY MICROFINANCE BANK"},
    {"sortCode": "999999", "name": "NIP Virtual Bank"},
    {"sortCode": "090194", "name": "NIRSAL NATIONAL MICROFINANCE BANK"},
    {"sortCode": "090283", "name": "NNEW WOMEN MICROFINANCE BANK"},
    {"sortCode": "060003", "name": "NOVA MERCHANT BANK"},
    {"sortCode": "070001", "name": "NPF MicroFinance Bank"},
    {"sortCode": "090128", "name": "Ndiorah Microfinance Bank"},
    {"sortCode": "090108", "name": "New Prudential Bank"},
    {"sortCode": "090272", "name": "OLABISI ONABANJO UNIVERSITY MICROFINANCE"},
    {"sortCode": "090295", "name": "OMIYE MICROFINANCE BANK"},
    {"sortCode": "090119", "name": "Ohafia Microfinance Bank"},
    {"sortCode": "090161", "name": "Okpoga Microfinance Bank"},
    {"sortCode": "070007", "name": "Omoluabi savings and loans"},
    {"sortCode": "100026", "name": "One Finance"},
    {"sortCode": "100033", "name": "PALMPAY"},
    {"sortCode": "090317", "name": "PATRICKGOLD MICROFINANCE BANK"},
    {"sortCode": "090196", "name": "PENNYWISE MICROFINANCE BANK"},
    {"sortCode": "090289", "name": "PILLAR MICROFINANCE BANK"},
    {"sortCode": "090296", "name": "POLYUNWANA MICROFINANCE BANK"},
    {"sortCode": "090274", "name": "PRESTIGE MICROFINANCE BANK"},
    {"sortCode": "090303", "name": "PURPLEMONEY MICROFINANCE BANK"},
    {"sortCode": "100002", "name": "Paga"},
    {"sortCode": "070008", "name": "Page Microfinance Bank"},
    {"sortCode": "100003", "name": "Parkway-ReadyCash"},
    {"sortCode": "090004", "name": "Parralex Microfinance bank"},
    {"sortCode": "110001", "name": "PayAttitude Online"},
    {"sortCode": "100004", "name": "Paycom"},
    {"sortCode": "090137", "name": "PecanTrust Microfinance Bank"},
    {"sortCode": "090135", "name": "Personal Trust Microfinance Bank"},
    {"sortCode": "070013", "name": "Platinum Mortgage Bank"},
    {"sortCode": "000023", "name": "Providus Bank "},
    {"sortCode": "090261", "name": "QUICKFUND MICROFINANCE BANK"},
    {"sortCode": "090198", "name": "RENMONEY MICROFINANCE BANK"},
    {"sortCode": "090322", "name": "REPHIDIM MICROFINANCE BANK"},
    {"sortCode": "000024", "name": "Rand Merchant Bank"},
    {"sortCode": "070011", "name": "Refuge Mortgage Bank"},
    {"sortCode": "090125", "name": "Regent Microfinance Bank"},
    {"sortCode": "090132", "name": "Richway Microfinance Bank"},
    {"sortCode": "090138", "name": "Royal Exchange Microfinance Bank"},
    {"sortCode": "090286", "name": "SAFE HAVEN MICROFINANCE BANK"},
    {"sortCode": "090325", "name": "SPARKLE"},
    {"sortCode": "090262", "name": "STELLAS MICROFINANCE BANK"},
    {"sortCode": "090305", "name": "SULSPAP MICROFINANCE BANK"},
    {"sortCode": "090006", "name": "SafeTrust "},
    {"sortCode": "090140", "name": "Sagamu Microfinance Bank"},
    {"sortCode": "090112", "name": "Seed Capital Microfinance Bank"},
    {"sortCode": "000008", "name": "Skye Bank"},
    {"sortCode": "000012", "name": "StanbicIBTC Bank"},
    {"sortCode": "100007", "name": "StanbicMobileMoney"},
    {"sortCode": "000021", "name": "StandardChartered"},
    {"sortCode": "000001", "name": "Sterling Bank"},
    {"sortCode": "100022", "name": "Sterling Mobile"},
    {"sortCode": "000022", "name": "Suntrust Bank"},
    {"sortCode": "000026", "name": "TAJ BANK"},
    {"sortCode": "090115", "name": "TCF MFB"},
    {"sortCode": "000025", "name": "TITAN TRUST BANK"},
    {"sortCode": "090327", "name": "TRUST MICROFINANCE BANK"},
    {"sortCode": "090276", "name": "TRUSTFUND MICROFINANCE BANK"},
    {"sortCode": "100023", "name": "TagPay"},
    {"sortCode": "100010", "name": "TeasyMobile"},
    {"sortCode": "090146", "name": "Trident Microfinance Bank"},
    {"name": "Trustbond Mortgage Bank"},
    {
      "sortCode": "090251",
      "name": "UNIVERSITY OF NIGERIA, NSUKKA MICROFINANCE BANK"
    },
    {"sortCode": "000018", "name": "Union Bank"},
    {"sortCode": "000004", "name": "United Bank for Africa"},
    {"sortCode": "000011", "name": "Unity Bank"},
    {"sortCode": "090110", "name": "VFD MFB"},
    {"sortCode": "100012", "name": "VTNetworks"},
    {"sortCode": "090123", "name": "Verite Microfinance Bank"},
    {"sortCode": "090150", "name": "Virtue Microfinance Bank"},
    {"sortCode": "090139", "name": "Visa Microfinance Bank"},
    {"sortCode": "000017", "name": "Wema Bank"},
    {"sortCode": "090120", "name": "Wetland Microfinance Bank"},
    {"sortCode": "090124", "name": "Xslnce Microfinance Bank"},
    {"sortCode": "090142", "name": "Yes Microfinance Bank"},
    {"sortCode": "000015", "name": "Zenith Bank Plc"},
    {"sortCode": "100018", "name": "ZenithMobile"},
    {"sortCode": "100025", "name": "Zinternet Nigera Limited"},
    {"sortCode": "090156", "name": "e-Barcs Microfinance Bank"},
    {"sortCode": "100006", "name": "eTranzact"}
  ];

  // static List<Color> multiColors = [
  //   Colors.red,
  //   Colors.amber,
  //   Colors.green,
  //   Colors.blue
  // ];

  String getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
        ),
      );

  String getFirstWord(String inputString) {
    List<String> wordList = inputString.split(" ");
    if (wordList.isNotEmpty) {
      return wordList[0];
    } else {
      return ' ';
    }
  }

  static launchURL(String url, {bool exitApp = false}) async {
    if (await canLaunch(url)) {
      if (exitApp) {
        SystemNavigator.pop(animated: true);
      }
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  showAbout(BuildContext context) {
    return showAboutDialog(
      context: context,
      applicationIcon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          "assets/logos/junkyard.png",
          height: 40,
        ),
      ),
      applicationVersion: "1.0.0",
      applicationLegalese: "PETsPoint Recycling",
    );
  }
}
