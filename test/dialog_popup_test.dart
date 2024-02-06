import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/models/tale_model.dart';
import 'package:trip_tales/src/widgets/dialog_popup.dart';

void main() {
  group('TaleModel Tests', () {
    test('Create TaleModel instance with long name', () {
      final tale = TaleModel(
        name: 'A very long tale name that exceeds the normal limit for a tale',
        imagePath: 'images/long_name.jpg',
        canvas: 'Long Name Canvas',
      );

      expect(tale.name,
          'A very long tale name that exceeds the normal limit for a tale');
    });

    test('ToJson Method with empty name', () {
      final tale = TaleModel(
        name: '',
        imagePath: 'images/empty_name.jpg',
        canvas: 'Empty Name Canvas',
      );

      final json = tale.toJson();

      expect(json['id'], null);
      expect(json['name'], '');
      expect(json['imagePath'], 'images/empty_name.jpg');
      expect(json['canvas'], 'Empty Name Canvas');
      expect(json['liked'], false);
      expect(json['cardsFK'], null);
    });

    test('Equality Test with default and non-default values', () {
      final tale1 = TaleModel(
        name: 'Default Tale',
        imagePath: 'images/default.jpg',
        canvas: 'Default Canvas',
      );

      final tale2 = TaleModel(
        id: '1',
        name: 'Sample Tale',
        imagePath: 'images/sample.jpg',
        canvas: 'Sample Canvas',
        liked: true,
        cardsFK: ['1', '2'],
      );

      expect(tale1, isNot(equals(tale2)));
    });

    group('DialogPopup Tests', () {
      testWidgets('Show dialog with default duration and custom text style',
          (WidgetTester tester) async {
        final dialog = DialogPopup(
          text: 'Custom Text Style',
          duration: 2,
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () => dialog.show(context),
                  child: Text('Show Dialog'),
                );
              },
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pump();

        expect(find.text('Custom Text Style'), findsOneWidget);

        final textWidget = tester.widget<Text>(
          find.descendant(
            of: find.byType(Dialog),
            matching: find.byType(Text),
          ),
        );

        expect(textWidget.style!.color, equals(AppColors.main2));
        expect(textWidget.style!.fontSize, equals(20.0));
        expect(textWidget.style!.fontWeight, equals(FontWeight.bold));

        await tester.pump(Duration(seconds: 2));
        expect(find.text('Custom Text Style'), findsNothing);
      });

      testWidgets('Show dialog and dismiss it immediately',
          (WidgetTester tester) async {
        final dialog = DialogPopup(text: 'Immediate Dismiss');

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                  onPressed: () => dialog.show(context),
                  child: Text('Show Dialog'),
                );
              },
            ),
          ),
        );

        await tester.tap(find.text('Show Dialog'));
        await tester.pump();
        await tester.pumpAndSettle(const Duration(seconds: 2));

        expect(find.text('Immediate Dismiss'), findsNothing);

        await tester
            .pump(Duration(milliseconds: 1)); // Wait for a very short time
        expect(find.text('Immediate Dismiss'), findsNothing);
      });

      // Add more tests for different scenarios based on your requirements
    });
  });
}
