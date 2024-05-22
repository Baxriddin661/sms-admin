import 'package:flutter/material.dart';

import '../../../model/template_create_model.dart';
import '../../../widget/app_text.dart';

/**
 * Created by Bekhruz Makhmudov on 06/05/24.
 * Project sms_etc_admin
 */
showAddTemplateDialog(
    BuildContext context, ValueChanged<TemplateCreateModel> onAdd) {
  showDialog(
      context: context,
      builder: (context) {
        String templateType = 'SERVICE';

        TextEditingController textCtrl = TextEditingController();
        var smsSegmentLength = '0';
        var smsMessageLength = '0';

        var smsIsUnicode = '0';
        var smsSegment = '0';
        // var smsMessageLength = '0';
        // var smsMessageLength = '0';
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                padding: EdgeInsets.all(15),
                height: 450,
                width: 450,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white),
                child: Column(
                  children: [
                    AppText(
                      'Create new template',
                      size: 20,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                    ),
                    Row(children: [
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          AppText(
                            'Choose template type',
                            color: Colors.grey,
                          ),
                          Container(
                            height: 49,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.indigo, width: 2.3),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: DropdownButton(
                              onTap: () {
                                setState(() {});
                              },
                              underline: SizedBox(),
                              value: templateType,
                              onChanged: (value) {
                                templateType = value!;
                                setState(() {});
                              },
                              items: [
                                DropdownMenuItem(
                                  value: 'ADS',
                                  child: AppText(
                                    'Ads',
                                    size: 18,
                                  ),
                                ),
                                DropdownMenuItem(
                                  value: 'SERVICE',
                                  child: AppText(
                                    'Service',
                                    size: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ]),
                    Container(
                      height: 160,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.indigo)),
                      child: TextField(
                        controller: textCtrl,
                        // maxLength: 160,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Text',
                        ),
                        maxLines: 8,
                        onChanged: (value) {
                          setState(() {
                            var smsResult = SMSLengthCalculator();
                            smsMessageLength = smsResult
                                .calculateSmsLength(value)
                                .messageLength
                                .toString();
                            smsSegmentLength = smsResult
                                .calculateSmsLength(value)
                                .maxSegmentLength
                                .toString();
                            smsSegment = smsResult
                                .calculateSmsLength(value)
                                .messageSegments
                                .toString();
                            smsIsUnicode = smsResult
                                .calculateSmsLength(value)
                                .isUnicode
                                .toString();
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppText('Sms segment: ${smsSegment}'),
                    AppText('Sms message length: $smsMessageLength'),
                    AppText('Sms segment: ${smsSegmentLength}'),
                    // AppText('Sms message length: $smsMessageLength'),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.indigo),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal: 60, vertical: 20))),
                      onPressed: () {
                        onAdd.call(
                            TemplateCreateModel(textCtrl.text, templateType));
                        Navigator.pop(context);
                        textCtrl.dispose();
                      },
                      child: AppText(
                        'Add',
                        size: 20,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      });
}

class SMSLengthCalculator {
  // Standard GSM-7 character set with some extensions (escape character is handled separately)
  final String _gsm7Charset =
      "@£\$¥èéùìòÇ\nØø\rÅåΔ_ΦΓΛΩΠΨΣΘΞÆæßÉ !\"#¤%&'()*+,-./0123456789:;<=>?¡ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÑÜ§¿abcdefghijklmnopqrstuvwxyzåäöñüà";

  // Extended GSM-7 characters that need an escape character
  final String _gsm7ExtendedChars = "|^€{}[]~";

  /// Calculates the length and other information about an SMS message.
  SMSLengthResult calculateSmsLength(String text) {
    bool isUnicode = false;

    // Check if any characters are outside the GSM-7 charset
    for (int i = 0; i < text.length; i++) {
      if (!_gsm7Charset.contains(text[i])) {
        isUnicode = true;
        break;
      }
    }

    int messageLength = text.length;
    int maxSegmentLength, messageSegments;

    if (isUnicode) {
      // Unicode encoding
      maxSegmentLength = 70;
    } else {
      // GSM-7 encoding (consider escape characters)
      maxSegmentLength = _calculateGSMMaxSegmentLength(text);
    }

    messageSegments = (messageLength / maxSegmentLength).ceil();

    return SMSLengthResult(
        isUnicode, messageLength, maxSegmentLength, messageSegments);
  }

  /// Calculates the maximum segment length for a GSM-7 encoded message,
  /// considering the use of escape characters.
  int _calculateGSMMaxSegmentLength(String text) {
    bool extendedCharsPresent = false;

    for (int i = 0; i < text.length; i++) {
      if (_gsm7ExtendedChars.contains(text[i])) {
        extendedCharsPresent = true;
        break;
      }
    }

    return extendedCharsPresent ? 153 : 160;
  }
}

/// Data class to store SMS calculation result
class SMSLengthResult {
  final bool isUnicode;
  final int messageLength;
  final int maxSegmentLength;
  final int messageSegments;

  SMSLengthResult(this.isUnicode, this.messageLength, this.maxSegmentLength,
      this.messageSegments);

  @override
  String toString() {
    return 'SMSLengthResult(isUnicode: $isUnicode, messageLength: $messageLength, maxSegmentLength: $maxSegmentLength, messageSegments: $messageSegments)';
  }
}
//
// void main() {
//   final calculator = SMSLengthCalculator();
//
//   String text1 = "Hello, world!";
//   String text2 = "Testing with some extended characters: |^€";
//   String text3 = "This is a message with Unicode characters: こんにちは";
//
//   var result1 = calculator.calculateSmsLength(text1);
//   var result2 = calculator.calculateSmsLength(text2);
//   var result3 = calculator.calculateSmsLength(text3);
//
//   print(result1);
//   print(result2);
//   print(result3);
// }
