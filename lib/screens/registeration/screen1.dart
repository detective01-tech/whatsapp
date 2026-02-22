import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:whatsapp/screens/registeration/screen2.dart';
import 'package:whatsapp/widgets/ui_helpers.dart';

class MobileNumber extends StatefulWidget {
  const MobileNumber({super.key});

  @override
  State<MobileNumber> createState() => _MobileNumberState();
}

class _MobileNumberState extends State<MobileNumber> {
  PhoneNumber number = PhoneNumber(isoCode: 'PK');
  String selectedCountry = 'Pakistan';

  List<String> country = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "Andorra",
    "Angola",
    "Argentina",
    "Armenia",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahrain",
    "Bangladesh",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bhutan",
    "Bolivia",
    "Bosnia and Herzegovina",
    "Botswana",
    "Brazil",
    "Brunei",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cambodia",
    "Cameroon",
    "Canada",
    "Cape Verde",
    "Central African Republic",
    "Chad",
    "Chile",
    "China",
    "Colombia",
    "Comoros",
    "Congo",
    "Costa Rica",
    "Croatia",
    "Cuba",
    "Cyprus",
    "Czech Republic",
    "Denmark",
    "Djibouti",
    "Dominican Republic",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Eritrea",
    "Estonia",
    "Eswatini",
    "Ethiopia",
    "Fiji",
    "Finland",
    "France",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Greece",
    "Greenland",
    "Guatemala",
    "Guinea",
    "Guyana",
    "Haiti",
    "Honduras",
    "Hong Kong",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland",
    "Israel",
    "Italy",
    "Jamaica",
    "Japan",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kuwait",
    "Kyrgyzstan",
    "Laos",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Macau",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Mauritania",
    "Mauritius",
    "Mexico",
    "Moldova",
    "Monaco",
    "Mongolia",
    "Montenegro",
    "Morocco",
    "Mozambique",
    "Myanmar",
    "Namibia",
    "Nepal",
    "Netherlands",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "North Korea",
    "North Macedonia",
    "Norway",
    "Oman",
    "Pakistan",
    "Palestine",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal",
    "Qatar",
    "Romania",
    "Russia",
    "Rwanda",
    "San Marino",
    "Saudi Arabia",
    "Senegal",
    "Serbia",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Slovakia",
    "Slovenia",
    "Somalia",
    "South Africa",
    "South Korea",
    "Spain",
    "Sri Lanka",
    "Sudan",
    "Suriname",
    "Sweden",
    "Switzerland",
    "Syria",
    "Taiwan",
    "Tajikistan",
    "Tanzania",
    "Thailand",
    "Togo",
    "Trinidad and Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "United States",
    "Uruguay",
    "Uzbekistan",
    "Venezuela",
    "Vietnam",
    "Yemen",
    "Zambia",
    "Zimbabwe",
  ];

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: UiHelpers.customText(
          fontsWeight: FontWeight.w600,
          text: 'Enter your phone number',
          fonts: 18,
          color: const Color(0xFF00A884),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UiHelpers.customText(
              text: 'WhatsApp will need to verify your phone',
              fonts: 16,
              fontsWeight: FontWeight.w400,
            ),
            UiHelpers.customText(
              text: 'number. Carrier charges may apply.',
              fonts: 16,
              fontsWeight: FontWeight.w400,
            ),
            InkWell(
              onTap: () {},
              child: UiHelpers.customText(
                color: const Color(0xFF00A884),
                text: 'What’s my number?',
                fonts: 16,
                fontsWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 25),

            // ✅ Fixed Dropdown
            DropdownButtonFormField<String>(
              value: selectedCountry,
              hint: const Text("Select your country"),
              items: country.map((String countryName) {
                return DropdownMenuItem<String>(
                  value: countryName,
                  child: Text(countryName),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedCountry = value!;
                });
              },
              decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF00A884)),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ✅ WhatsApp-style phone input
            InternationalPhoneNumberInput(
              onInputChanged: (PhoneNumber num) {
                number = num;
              },
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.DROPDOWN,
                showFlags: true,
                leadingPadding: 10,
              ),
              initialValue: number,
              textFieldController: controller,
              formatInput: false,
              keyboardType: TextInputType.number,
              inputDecoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Phone number',
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: UiHelpers.customButton(
        callback: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => CodeNumber(number: number)),
          );
        },
        bgColor: const Color(0xFF00A884),
        buttonName: 'Next',
      ),
    );
  }
}
