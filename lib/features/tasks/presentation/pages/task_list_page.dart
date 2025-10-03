import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/task_list_vm.dart';

class TaskListPage extends ConsumerWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(taskListVMProvider);
    final vm = ref.read(taskListVMProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: RefreshIndicator(
        onRefresh: () => vm.load(refresh: true),
        child: ListView(
          children: [
            if (state.loading) const LinearProgressIndicator(),
            if (state.error != null)
              ListTile(title: Text('Error: ${state.error}')),
            ...state.items.map(
              (t) => CheckboxListTile(
                value: t.done,
                title: Text(t.title),
                onChanged: (_) => vm.toggle(t.id),
                secondary: t.updatedAt != null
                      ? Text(
                          '${t.updatedAt}',
                          style: const TextStyle(fontSize: 12),
                        )
                      : null,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final title = await showDialog<String>(
            context: context,
            builder: (ctx) {
              final c = TextEditingController();
              return AlertDialog(
                title: const Text('New Task'),
                content: TextField(controller: c),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('Cancel'),
                  ),
                  FilledButton(
                    onPressed: () => Navigator.pop(ctx, c.text),
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
          if (title != null && title.isNotEmpty) {
            vm.add(title);
          }
        },
        child: const Text("Add"),
      ),
    );
  }
}
