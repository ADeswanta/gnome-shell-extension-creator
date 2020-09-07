# Changelog

### 1.0
- 21 Aug 2020 - Initial Release
- 2 Sep 2020 - Fixed any changes on create-extension.sh:
1. UUID Extension is all lowercase (Line 10 - 11)
2. Keep description extension is available, if description user input is blank. (Line 112 - 114)
3. Any fixses on extension.js creation, such as wrong "function" text (Line 133, 137, 141)
4. Improved open extension choice (Line 169 - 176)

### 1.0.1
- 7 Sep 2020 - create-extension.sh improvements:
1. Multiple folder while creating extension: (Line 93)
      Name: Power Menu
      UUID: Power Menu@extensions (should be power_menu@extensions)
2. Improved error: "too many arguments" (Line 24, 112)
3. Wrong wrote UUID in "uuid_notfound" function (Line 38)
4. Unused user input prompt (Line 15)
5. UUID is not converted to lowercase after "name_notfound" function (Line 9-12 to 25-28)
6. Unused blank on last line (Line 181)
