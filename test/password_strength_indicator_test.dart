import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trip_tales/src/constants/color.dart';
import 'package:trip_tales/src/utils/password_strength_indicator.dart';

void main() {
  testWidgets('PasswordStrengthIndicator - All strength indicators',
      (WidgetTester tester) async {
    // Build the widget with all strength indicators set to true
    await tester.pumpWidget(
      MaterialApp(
        home: PasswordStrengthIndicator(
          isTablet: false, //to be modified
          hasUppercase: true,
          hasLowercase: true,
          hasDigits: true,
          hasSpecialCharacters: true,
        ),
      ),
    );

    // Find all strength indicator widgets and check their colors
    final strengthIndicator1 = find.byKey(const Key('strength_indicator_1'));
    final strengthIndicator2 = find.byKey(const Key('strength_indicator_2'));
    final strengthIndicator3 = find.byKey(const Key('strength_indicator_3'));
    final strengthIndicator4 = find.byKey(const Key('strength_indicator_4'));

    expect(strengthIndicator1, findsOneWidget);
    expect(strengthIndicator2, findsOneWidget);
    expect(strengthIndicator3, findsOneWidget);
    expect(strengthIndicator4, findsOneWidget);

    final strengthIndicator1Widget =
        tester.widget<Container>(strengthIndicator1);
    final strengthIndicator2Widget =
        tester.widget<Container>(strengthIndicator2);
    final strengthIndicator3Widget =
        tester.widget<Container>(strengthIndicator3);
    final strengthIndicator4Widget =
        tester.widget<Container>(strengthIndicator4);

    // All indicators should have green color
    expect((strengthIndicator1Widget.decoration as BoxDecoration).color,
        Colors.greenAccent);
    expect((strengthIndicator2Widget.decoration as BoxDecoration).color,
        Colors.greenAccent);
    expect((strengthIndicator3Widget.decoration as BoxDecoration).color,
        Colors.greenAccent);
    expect((strengthIndicator4Widget.decoration as BoxDecoration).color,
        Colors.greenAccent);
  });
  testWidgets('PasswordStrengthIndicator - Low strength indicators',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PasswordStrengthIndicator(
          isTablet: false, //to be modified
          hasUppercase: false,
          hasLowercase: false,
          hasDigits: false,
          hasSpecialCharacters: true,
        ),
      ),
    );

    final strengthIndicator1 = find.byKey(const Key('strength_indicator_1'));
    final strengthIndicator2 = find.byKey(const Key('strength_indicator_2'));
    final strengthIndicator3 = find.byKey(const Key('strength_indicator_3'));
    final strengthIndicator4 = find.byKey(const Key('strength_indicator_4'));

    expect(strengthIndicator1, findsOneWidget);
    expect(strengthIndicator2, findsOneWidget);
    expect(strengthIndicator3, findsOneWidget);
    expect(strengthIndicator4, findsOneWidget);

    final strengthIndicator1Widget =
        tester.widget<Container>(strengthIndicator1);
    final strengthIndicator2Widget =
        tester.widget<Container>(strengthIndicator2);
    final strengthIndicator3Widget =
        tester.widget<Container>(strengthIndicator3);
    final strengthIndicator4Widget =
        tester.widget<Container>(strengthIndicator4);

    expect((strengthIndicator1Widget.decoration as BoxDecoration).color,
        Colors.redAccent);
    expect((strengthIndicator2Widget.decoration as BoxDecoration).color,
        AppColors.text3);
    expect((strengthIndicator3Widget.decoration as BoxDecoration).color,
        AppColors.text3);
    expect((strengthIndicator4Widget.decoration as BoxDecoration).color,
        AppColors.text3);
  });

  testWidgets('PasswordStrengthIndicator - No strength indicators',
      (WidgetTester tester) async {
    // Build the widget with all strength indicators set to false
    await tester.pumpWidget(
      MaterialApp(
        home: PasswordStrengthIndicator(
          isTablet: false, //to be modified
          hasUppercase: false,
          hasLowercase: false,
          hasDigits: false,
          hasSpecialCharacters: false,
        ),
      ),
    );

    // Find all strength indicator widgets and check their colors
    final strengthIndicator1 = find.byKey(const Key('strength_indicator_1'));
    final strengthIndicator2 = find.byKey(const Key('strength_indicator_2'));
    final strengthIndicator3 = find.byKey(const Key('strength_indicator_3'));
    final strengthIndicator4 = find.byKey(const Key('strength_indicator_4'));

    expect(strengthIndicator1, findsOneWidget);
    expect(strengthIndicator2, findsOneWidget);
    expect(strengthIndicator3, findsOneWidget);
    expect(strengthIndicator4, findsOneWidget);

    final strengthIndicator1Widget =
        tester.widget<Container>(strengthIndicator1);
    final strengthIndicator2Widget =
        tester.widget<Container>(strengthIndicator2);
    final strengthIndicator3Widget =
        tester.widget<Container>(strengthIndicator3);
    final strengthIndicator4Widget =
        tester.widget<Container>(strengthIndicator4);

    // All indicators should have the default color
    expect((strengthIndicator1Widget.decoration as BoxDecoration).color,
        AppColors.text3);
    expect((strengthIndicator2Widget.decoration as BoxDecoration).color,
        AppColors.text3);
    expect((strengthIndicator3Widget.decoration as BoxDecoration).color,
        AppColors.text3);
    expect((strengthIndicator4Widget.decoration as BoxDecoration).color,
        AppColors.text3);
  });

  testWidgets('PasswordStrengthIndicator - Mixed strength indicators',
      (WidgetTester tester) async {
    // Build the widget with a mix of true and false strength indicators
    await tester.pumpWidget(
      MaterialApp(
        home: PasswordStrengthIndicator(
          isTablet: false, //to be modified
          hasUppercase: true,
          hasLowercase: false,
          hasDigits: true,
          hasSpecialCharacters: false,
        ),
      ),
    );

    // Find all strength indicator widgets and check their colors
    final strengthIndicator1 = find.byKey(const Key('strength_indicator_1'));
    final strengthIndicator2 = find.byKey(const Key('strength_indicator_2'));
    final strengthIndicator3 = find.byKey(const Key('strength_indicator_3'));
    final strengthIndicator4 = find.byKey(const Key('strength_indicator_4'));

    expect(strengthIndicator1, findsOneWidget);
    expect(strengthIndicator2, findsOneWidget);
    expect(strengthIndicator3, findsOneWidget);
    expect(strengthIndicator4, findsOneWidget);

    final strengthIndicator1Widget =
        tester.widget<Container>(strengthIndicator1);
    final strengthIndicator2Widget =
        tester.widget<Container>(strengthIndicator2);
    final strengthIndicator3Widget =
        tester.widget<Container>(strengthIndicator3);
    final strengthIndicator4Widget =
        tester.widget<Container>(strengthIndicator4);

    // The first and third indicators should have green color
    // The second and fourth indicators should have the default color
    expect((strengthIndicator1Widget.decoration as BoxDecoration).color,
        AppColors.main3);
    expect((strengthIndicator2Widget.decoration as BoxDecoration).color,
        AppColors.main3);
    expect((strengthIndicator3Widget.decoration as BoxDecoration).color,
        AppColors.text3);
    expect((strengthIndicator4Widget.decoration as BoxDecoration).color,
        AppColors.text3);
  });

  testWidgets('PasswordStrengthIndicator - Full strength indicators',
      (WidgetTester tester) async {
    // Build the widget with all strength indicators set to true
    await tester.pumpWidget(
      MaterialApp(
        home: PasswordStrengthIndicator(
          isTablet: false, //to be modified
          hasUppercase: true,
          hasLowercase: true,
          hasDigits: true,
          hasSpecialCharacters: true,
        ),
      ),
    );

    // Find all strength indicator widgets and check their colors
    final strengthIndicator1 = find.byKey(const Key('strength_indicator_1'));
    final strengthIndicator2 = find.byKey(const Key('strength_indicator_2'));
    final strengthIndicator3 = find.byKey(const Key('strength_indicator_3'));
    final strengthIndicator4 = find.byKey(const Key('strength_indicator_4'));

    expect(strengthIndicator1, findsOneWidget);
    expect(strengthIndicator2, findsOneWidget);
    expect(strengthIndicator3, findsOneWidget);
    expect(strengthIndicator4, findsOneWidget);

    final strengthIndicator1Widget =
        tester.widget<Container>(strengthIndicator1);
    final strengthIndicator2Widget =
        tester.widget<Container>(strengthIndicator2);
    final strengthIndicator3Widget =
        tester.widget<Container>(strengthIndicator3);
    final strengthIndicator4Widget =
        tester.widget<Container>(strengthIndicator4);

    // All indicators should have the green color
    expect((strengthIndicator1Widget.decoration as BoxDecoration).color,
        Colors.greenAccent);
    expect((strengthIndicator2Widget.decoration as BoxDecoration).color,
        Colors.greenAccent);
    expect((strengthIndicator3Widget.decoration as BoxDecoration).color,
        Colors.greenAccent);
    expect((strengthIndicator4Widget.decoration as BoxDecoration).color,
        Colors.greenAccent);
  });

  testWidgets('PasswordStrengthIndicator - Some strength indicators',
      (WidgetTester tester) async {
    // Build the widget with some strength indicators set to true
    await tester.pumpWidget(
      MaterialApp(
        home: PasswordStrengthIndicator(
          isTablet: false, //to be modified
          hasUppercase: true,
          hasLowercase: false,
          hasDigits: true,
          hasSpecialCharacters: false,
        ),
      ),
    );

    // Find all strength indicator widgets and check their colors
    final strengthIndicator1 = find.byKey(const Key('strength_indicator_1'));
    final strengthIndicator2 = find.byKey(const Key('strength_indicator_2'));
    final strengthIndicator3 = find.byKey(const Key('strength_indicator_3'));
    final strengthIndicator4 = find.byKey(const Key('strength_indicator_4'));

    expect(strengthIndicator1, findsOneWidget);
    expect(strengthIndicator2, findsOneWidget);
    expect(strengthIndicator3, findsOneWidget);
    expect(strengthIndicator4, findsOneWidget);

    final strengthIndicator1Widget =
        tester.widget<Container>(strengthIndicator1);
    final strengthIndicator2Widget =
        tester.widget<Container>(strengthIndicator2);
    final strengthIndicator3Widget =
        tester.widget<Container>(strengthIndicator3);
    final strengthIndicator4Widget =
        tester.widget<Container>(strengthIndicator4);

    // The first and third indicators should have green color
    // The second and fourth indicators should have the default color
    expect((strengthIndicator1Widget.decoration as BoxDecoration).color,
        AppColors.main3);
    expect((strengthIndicator2Widget.decoration as BoxDecoration).color,
        AppColors.main3);
    expect((strengthIndicator3Widget.decoration as BoxDecoration).color,
        AppColors.text3);
    expect((strengthIndicator4Widget.decoration as BoxDecoration).color,
        AppColors.text3);
  });
  testWidgets('PasswordStrengthIndicator - No strength indicators',
      (WidgetTester tester) async {
    // Build the widget with all strength indicators set to false
    await tester.pumpWidget(
      MaterialApp(
        home: PasswordStrengthIndicator(
          isTablet: false, //to be modified
          hasUppercase: false,
          hasLowercase: false,
          hasDigits: false,
          hasSpecialCharacters: false,
        ),
      ),
    );

    // Find all strength indicator widgets
    final strengthIndicator1 = find.byKey(const Key('strength_indicator_1'));
    final strengthIndicator2 = find.byKey(const Key('strength_indicator_2'));
    final strengthIndicator3 = find.byKey(const Key('strength_indicator_3'));
    final strengthIndicator4 = find.byKey(const Key('strength_indicator_4'));

    expect(strengthIndicator1, findsOneWidget);
    expect(strengthIndicator2, findsOneWidget);
    expect(strengthIndicator3, findsOneWidget);
    expect(strengthIndicator4, findsOneWidget);

    final strengthIndicator1Widget =
        tester.widget<Container>(strengthIndicator1);
    final strengthIndicator2Widget =
        tester.widget<Container>(strengthIndicator2);
    final strengthIndicator3Widget =
        tester.widget<Container>(strengthIndicator3);
    final strengthIndicator4Widget =
        tester.widget<Container>(strengthIndicator4);

    // All indicators should have the default color
    expect((strengthIndicator1Widget.decoration as BoxDecoration).color,
        AppColors.text3);
    expect((strengthIndicator2Widget.decoration as BoxDecoration).color,
        AppColors.text3);
    expect((strengthIndicator3Widget.decoration as BoxDecoration).color,
        AppColors.text3);
    expect((strengthIndicator4Widget.decoration as BoxDecoration).color,
        AppColors.text3);
  });

  testWidgets('PasswordStrengthIndicator - Random strength indicators',
      (WidgetTester tester) async {
    // Build the widget with a random mix of strength indicators
    await tester.pumpWidget(
      MaterialApp(
        home: PasswordStrengthIndicator(
          isTablet: false, //to be modified
          hasUppercase: true,
          hasLowercase: false,
          hasDigits: true,
          hasSpecialCharacters: true,
        ),
      ),
    );

    // Find all strength indicator widgets
    final strengthIndicator1 = find.byKey(const Key('strength_indicator_1'));
    final strengthIndicator2 = find.byKey(const Key('strength_indicator_2'));
    final strengthIndicator3 = find.byKey(const Key('strength_indicator_3'));
    final strengthIndicator4 = find.byKey(const Key('strength_indicator_4'));

    expect(strengthIndicator1, findsOneWidget);
    expect(strengthIndicator2, findsOneWidget);
    expect(strengthIndicator3, findsOneWidget);
    expect(strengthIndicator4, findsOneWidget);

    final strengthIndicator1Widget =
        tester.widget<Container>(strengthIndicator1);
    final strengthIndicator2Widget =
        tester.widget<Container>(strengthIndicator2);
    final strengthIndicator3Widget =
        tester.widget<Container>(strengthIndicator3);
    final strengthIndicator4Widget =
        tester.widget<Container>(strengthIndicator4);

    // The first, third, and fourth indicators should have green color
    // The second indicator should have the default color
    expect((strengthIndicator1Widget.decoration as BoxDecoration).color,
        Colors.greenAccent);
    expect((strengthIndicator2Widget.decoration as BoxDecoration).color,
        Colors.greenAccent);
    expect((strengthIndicator3Widget.decoration as BoxDecoration).color,
        Colors.greenAccent);
    expect((strengthIndicator4Widget.decoration as BoxDecoration).color,
        AppColors.text3);
  });

  testWidgets('PasswordStrengthIndicator - All indicators on',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PasswordStrengthIndicator(
          isTablet: false, //to be modified
          hasUppercase: true,
          hasLowercase: true,
          hasDigits: true,
          hasSpecialCharacters: true,
        ),
      ),
    );

    final strengthIndicator1 = find.byKey(Key('strength_indicator_1'));
    final strengthIndicator2 = find.byKey(Key('strength_indicator_2'));
    final strengthIndicator3 = find.byKey(Key('strength_indicator_3'));
    final strengthIndicator4 = find.byKey(Key('strength_indicator_4'));

    expect(strengthIndicator1, findsOneWidget);
    expect(strengthIndicator2, findsOneWidget);
    expect(strengthIndicator3, findsOneWidget);
    expect(strengthIndicator4, findsOneWidget);

    final strengthIndicator1Widget =
        tester.widget<Container>(strengthIndicator1);
    final strengthIndicator2Widget =
        tester.widget<Container>(strengthIndicator2);
    final strengthIndicator3Widget =
        tester.widget<Container>(strengthIndicator3);
    final strengthIndicator4Widget =
        tester.widget<Container>(strengthIndicator4);

    expect((strengthIndicator1Widget.decoration as BoxDecoration).color,
        Colors.greenAccent);
    expect((strengthIndicator2Widget.decoration as BoxDecoration).color,
        Colors.greenAccent);
    expect((strengthIndicator3Widget.decoration as BoxDecoration).color,
        Colors.greenAccent);
    expect((strengthIndicator4Widget.decoration as BoxDecoration).color,
        Colors.greenAccent);
  });

  testWidgets('PasswordStrengthIndicator - No indicators on',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: PasswordStrengthIndicator(
          isTablet: false, //to be modified
          hasUppercase: false,
          hasLowercase: false,
          hasDigits: false,
          hasSpecialCharacters: false,
        ),
      ),
    );

    final strengthIndicator1 = find.byKey(const Key('strength_indicator_1'));
    final strengthIndicator2 = find.byKey(const Key('strength_indicator_2'));
    final strengthIndicator3 = find.byKey(const Key('strength_indicator_3'));
    final strengthIndicator4 = find.byKey(const Key('strength_indicator_4'));

    expect(strengthIndicator1, findsOneWidget);
    expect(strengthIndicator2, findsOneWidget);
    expect(strengthIndicator3, findsOneWidget);
    expect(strengthIndicator4, findsOneWidget);

    final strengthIndicator1Widget =
        tester.widget<Container>(strengthIndicator1);
    final strengthIndicator2Widget =
        tester.widget<Container>(strengthIndicator2);
    final strengthIndicator3Widget =
        tester.widget<Container>(strengthIndicator3);
    final strengthIndicator4Widget =
        tester.widget<Container>(strengthIndicator4);

    expect((strengthIndicator1Widget.decoration as BoxDecoration).color,
        AppColors.text3);
    expect((strengthIndicator2Widget.decoration as BoxDecoration).color,
        AppColors.text3);
    expect((strengthIndicator3Widget.decoration as BoxDecoration).color,
        AppColors.text3);
    expect((strengthIndicator4Widget.decoration as BoxDecoration).color,
        AppColors.text3);
  });
}
