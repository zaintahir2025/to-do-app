import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myapp/main.dart';

void main() {
  group('ToDoApp Tests', () {
    testWidgets('Add a task to the to-do list', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ToDoHomePage()));

      expect(find.text('No tasks yet!'), findsOneWidget);
      expect(find.text('Test Task'), findsNothing);

      await tester.enterText(find.byType(TextField), 'Test Task');
      await tester.pump();

      await tester.tap(find.text('Add'));
      await tester.pump();

      expect(find.text('Test Task'), findsOneWidget);
      expect(find.text('No tasks yet!'), findsNothing);
    });

    testWidgets('Toggle task completion status', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ToDoHomePage()));

      await tester.enterText(find.byType(TextField), 'Task to be completed');
      await tester.tap(find.text('Add'));
      await tester.pump();

      // Tap the checkbox
      final checkboxFinder = find.byType(Checkbox).first;
      await tester.tap(checkboxFinder);
      await tester.pump();

      // Verify strikethrough
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.data == 'Task to be completed' &&
              widget.style?.decoration == TextDecoration.lineThrough,
        ),
        findsOneWidget,
      );
    });

    testWidgets('Clear all tasks from the to-do list', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ToDoHomePage()));

      await tester.enterText(find.byType(TextField), 'Test Task');
      await tester.tap(find.text('Add'));
      await tester.pump();

      expect(find.text('Test Task'), findsOneWidget);
      expect(find.text('No tasks yet!'), findsNothing);

      await tester.tap(find.text('Clear All'));
      await tester.pump();

      expect(find.text('No tasks yet!'), findsOneWidget);
      expect(find.text('Test Task'), findsNothing);
    });

    testWidgets('Navigate to completed tasks page and verify tasks', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: ToDoHomePage()));

      await tester.enterText(find.byType(TextField), 'Completed Task');
      await tester.tap(find.text('Add'));
      await tester.pump();

      // Tap the checkbox
      await tester.tap(find.byType(Checkbox).first);
      await tester.pump();

      // Tap the check_circle icon in AppBar
      await tester.tap(find.byIcon(Icons.check_circle));
      await tester.pumpAndSettle();

      expect(find.text('Completed Tasks'), findsOneWidget);
      expect(find.text('Completed Task'), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.data == 'Completed Task' &&
              widget.style?.decoration == TextDecoration.lineThrough,
        ),
        findsOneWidget,
      );
      expect(find.text('No completed tasks!'), findsNothing);
    });
  });
}
