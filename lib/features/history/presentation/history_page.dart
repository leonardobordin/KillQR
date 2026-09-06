import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/app_providers.dart';
import '../../../core/database/app_database.dart';
import '../../../core/models/scan_models.dart';
import '../../../l10n/app_localizations.dart';
import '../../scanner/presentation/scanner_page.dart';
import '../../transfer/data/transfer_service.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  final _searchController = TextEditingController();
  String _search = '';
  String? _type;
  String? _source;
  String? _format;
  String? _tag;
  bool _favoritesOnly = false;
  bool _selectionMode = false;
  final Set<int> _selectedIds = <int>{};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final database = ref.watch(databaseProvider).requireValue;
    final selecting = _selectionMode;
    return Scaffold(
      appBar: AppBar(
        title: selecting
            ? Text('${_selectedIds.length} ${l10n.selectedItems}')
            : Text(l10n.history),
        leading: selecting
            ? IconButton(
                tooltip: l10n.cancel,
                onPressed: _clearSelection,
                icon: const Icon(Icons.close),
              )
            : null,
        actions: selecting
            ? [
                PopupMenuButton<String>(
                  enabled: _selectedIds.isNotEmpty,
                  onSelected: (value) => _selectionAction(value, database),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'export',
                      child: Text(l10n.exportSelected),
                    ),
                    PopupMenuItem(
                      value: 'share',
                      child: Text(l10n.shareSelected),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text(l10n.deleteSelected),
                    ),
                  ],
                ),
              ]
            : [
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'select') {
                      setState(() => _selectionMode = true);
                    } else {
                      _transferAction(value, database);
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'select',
                      child: Text(l10n.selectItems),
                    ),
                    PopupMenuItem(
                      value: 'export_json',
                      child: Text(l10n.exportJson),
                    ),
                    PopupMenuItem(
                      value: 'export_csv',
                      child: Text(l10n.exportCsv),
                    ),
                    PopupMenuItem(
                      value: 'import',
                      child: Text(l10n.importData),
                    ),
                  ],
                ),
                IconButton(
                  tooltip: l10n.clearHistory,
                  onPressed: () => _clearHistory(database),
                  icon: const Icon(Icons.delete_sweep_outlined),
                ),
              ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _search = value),
              decoration: InputDecoration(
                hintText: l10n.searchHistory,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _search.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _search = '');
                        },
                        icon: const Icon(Icons.clear),
                      ),
              ),
            ),
          ),
          _Filters(
            type: _type,
            source: _source,
            format: _format,
            tag: _tag,
            favoritesOnly: _favoritesOnly,
            database: database,
            onTypeChanged: (value) => setState(() => _type = value),
            onSourceChanged: (value) => setState(() => _source = value),
            onFormatChanged: (value) => setState(() => _format = value),
            onTagChanged: (value) => setState(() => _tag = value),
            onFavoritesChanged: (value) =>
                setState(() => _favoritesOnly = value),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: StreamBuilder<List<ScanRecord>>(
              stream: database.watchScans(
                search: _search,
                contentType: _type,
                formatKey: _format,
                source: _source,
                tagName: _tag,
                favoriteOnly: _favoritesOnly,
                limit: 100,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return _refreshableHistory(
                    database,
                    ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: 240,
                          child: Center(child: Text(snapshot.error.toString())),
                        ),
                      ],
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return _refreshableHistory(
                    database,
                    ListView(
                      physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: 240,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  );
                }
                final records = snapshot.data ?? const <ScanRecord>[];
                if (records.isEmpty) {
                  return _refreshableHistory(
                    database,
                    LayoutBuilder(
                      builder: (context, constraints) => ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: constraints.maxHeight,
                            ),
                            child: _EmptyHistory(l10n: l10n),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return _refreshableHistory(
                  database,
                  ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    itemCount: records.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final record = records[index];
                      return _HistoryTile(
                        record: record,
                        selected: _selectedIds.contains(record.id),
                        selectionMode: selecting,
                        onTap: () => selecting
                            ? _toggleSelection(record.id)
                            : _openRecord(record),
                        onLongPress: () => _toggleSelection(record.id),
                        onDelete: () => _deleteRecord(database, record),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _refreshableHistory(AppDatabase database, Widget child) {
    return RefreshIndicator(
      onRefresh: () => _refreshHistory(database),
      child: child,
    );
  }

  Future<void> _refreshHistory(AppDatabase database) async {
    await database.queryScans(
      search: _search,
      contentType: _type,
      formatKey: _format,
      source: _source,
      tagName: _tag,
      favoriteOnly: _favoritesOnly,
      limit: 100,
    );
    if (mounted) setState(() {});
  }

  void _toggleSelection(int id) {
    setState(() {
      _selectionMode = true;
      if (!_selectedIds.add(id)) _selectedIds.remove(id);
    });
  }

  void _clearSelection() {
    setState(() {
      _selectionMode = false;
      _selectedIds.clear();
    });
  }

  Future<void> _openRecord(ScanRecord record) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => ScanResultPage(
          existingId: record.id,
          result: BarcodeScanResult(
            rawValue: record.rawValue,
            format: formatFromKey(record.formatKey),
            source: scanSourceFromKey(record.source),
            capturedAt: DateTime.fromMillisecondsSinceEpoch(
              record.createdAtMs,
              isUtc: true,
            ),
          ),
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  Future<void> _deleteRecord(AppDatabase database, ScanRecord record) async {
    await database.deleteScan(record.id);
    if (mounted) setState(() => _selectedIds.remove(record.id));
  }

  Future<void> _clearHistory(AppDatabase database) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.clearHistory),
        content: Text(l10n.clearHistoryConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.delete),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await database.deleteAllScans();
      if (mounted) _clearSelection();
    }
  }

  Future<void> _selectionAction(String value, AppDatabase database) async {
    final l10n = AppLocalizations.of(context)!;
    final ids = _selectedIds.toList(growable: false);
    if (value == 'delete') {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.deleteSelected),
          content: Text('${ids.length} ${l10n.selectedItems}?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(l10n.delete),
            ),
          ],
        ),
      );
      if (confirmed != true) return;
      await database.transaction(() async {
        for (final id in ids) {
          await database.deleteScan(id);
        }
      });
      if (mounted) _clearSelection();
      return;
    }
    const service = TransferService();
    if (value == 'export') {
      await service.exportToFile(database, csv: false, ids: ids);
    } else if (value == 'share') {
      await service.shareExport(database, csv: false, ids: ids);
    }
  }

  Future<void> _transferAction(String value, AppDatabase database) async {
    const service = TransferService();
    final l10n = AppLocalizations.of(context)!;
    if (value == 'export_json' || value == 'export_csv') {
      final result = await service.exportToFile(
        database,
        csv: value == 'export_csv',
      );
      if (result.path != null && mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l10n.transferComplete)));
      }
      return;
    }
    final preview = await service.openImport();
    if (preview == null || !mounted) return;
    if (preview.records.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.invalidContent)));
      return;
    }
    final policy = await showDialog<DuplicatePolicy>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.importData),
        content: Text(
          '${preview.records.length} ${l10n.selectedItems}${preview.errors.isEmpty ? '' : ' · ${preview.errors.length} errors'}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, DuplicatePolicy.skip),
            child: Text(l10n.save),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.pop(context, DuplicatePolicy.importAsNew),
            child: Text(l10n.importData),
          ),
        ],
      ),
    );
    if (policy == null) return;
    await service.importRecords(database, preview.records, policy: policy);
    if (mounted) {
      setState(() {});
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.transferComplete)));
    }
  }
}

class _Filters extends StatelessWidget {
  const _Filters({
    required this.type,
    required this.source,
    required this.format,
    required this.tag,
    required this.favoritesOnly,
    required this.database,
    required this.onTypeChanged,
    required this.onSourceChanged,
    required this.onFormatChanged,
    required this.onTagChanged,
    required this.onFavoritesChanged,
  });

  final String? type;
  final String? source;
  final String? format;
  final String? tag;
  final bool favoritesOnly;
  final AppDatabase database;
  final ValueChanged<String?> onTypeChanged;
  final ValueChanged<String?> onSourceChanged;
  final ValueChanged<String?> onFormatChanged;
  final ValueChanged<String?> onTagChanged;
  final ValueChanged<bool> onFavoritesChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          FilterChip(
            label: Text(l10n.favoritesOnly),
            selected: favoritesOnly,
            onSelected: onFavoritesChanged,
          ),
          const SizedBox(width: 8),
          _FilterDropdown<String?>(
            value: type,
            hint: l10n.allTypes,
            entries: [
              for (final item in ContentType.values)
                DropdownMenuItem<String?>(
                  value: item.name,
                  child: Text(_contentTypeName(context, item)),
                ),
            ],
            onChanged: onTypeChanged,
          ),
          const SizedBox(width: 8),
          _FilterDropdown<String?>(
            value: source,
            hint: l10n.allSources,
            entries: [
              for (final item in ScanSource.values)
                DropdownMenuItem<String?>(
                  value: item.name,
                  child: Text(_sourceName(context, item)),
                ),
            ],
            onChanged: onSourceChanged,
          ),
          const SizedBox(width: 8),
          _FilterDropdown<String?>(
            value: format,
            hint: l10n.allFormats,
            entries: [
              for (final item in const [
                'qr_code',
                'ean13',
                'ean8',
                'code128',
                'code39',
                'data_matrix',
                'pdf417',
              ])
                DropdownMenuItem<String?>(value: item, child: Text(item)),
            ],
            onChanged: onFormatChanged,
          ),
          const SizedBox(width: 8),
          FutureBuilder<List<Tag>>(
            future: database.getAllTags(),
            builder: (context, snapshot) {
              return _FilterDropdown<String?>(
                value: tag,
                hint: l10n.noTags,
                entries: [
                  for (final item in snapshot.data ?? const <Tag>[])
                    DropdownMenuItem<String?>(
                      value: item.name,
                      child: Text(item.name),
                    ),
                ],
                onChanged: onTagChanged,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _FilterDropdown<T> extends StatelessWidget {
  const _FilterDropdown({
    required this.value,
    required this.hint,
    required this.entries,
    required this.onChanged,
  });

  final T? value;
  final String hint;
  final List<DropdownMenuItem<T>> entries;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: value,
      hint: Text(hint),
      items: [
        DropdownMenuItem<T>(value: null, child: Text(hint)),
        ...entries,
      ],
      onChanged: onChanged,
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({
    required this.record,
    required this.selected,
    required this.selectionMode,
    required this.onTap,
    required this.onLongPress,
    required this.onDelete,
  });

  final ScanRecord record;
  final bool selected;
  final bool selectionMode;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(record.id),
      direction: selectionMode
          ? DismissDirection.none
          : DismissDirection.endToStart,
      confirmDismiss: (_) async {
        onDelete();
        return true;
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline),
      ),
      child: Card(
        color: selected
            ? Theme.of(context).colorScheme.secondaryContainer
            : null,
        child: ListTile(
          onTap: onTap,
          onLongPress: onLongPress,
          leading: selectionMode
              ? Checkbox(value: selected, onChanged: (_) => onTap())
              : CircleAvatar(
                  child: Icon(record.isFavorite ? Icons.star : Icons.qr_code_2),
                ),
          title: Text(
            record.rawValue,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            '${record.formatKey} · ${_contentTypeName(context, contentTypeFromKey(record.contentType))}',
          ),
          trailing: Text(
            _formatDate(record.createdAtMs),
            style: Theme.of(context).textTheme.labelSmall,
          ),
          isThreeLine: true,
        ),
      ),
    );
  }

  String _formatDate(int milliseconds) {
    final date = DateTime.fromMillisecondsSinceEpoch(
      milliseconds,
      isUtc: true,
    ).toLocal();
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}';
  }
}

class _EmptyHistory extends StatelessWidget {
  const _EmptyHistory({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.history_toggle_off, size: 56),
            const SizedBox(height: 16),
            Text(l10n.noHistory, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(l10n.noHistoryHint, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

String _contentTypeName(BuildContext context, ContentType type) {
  final l10n = AppLocalizations.of(context)!;
  switch (type) {
    case ContentType.text:
      return l10n.typeText;
    case ContentType.url:
      return l10n.typeUrl;
    case ContentType.phone:
      return l10n.typePhone;
    case ContentType.sms:
      return l10n.typeSms;
    case ContentType.email:
      return l10n.typeEmail;
    case ContentType.wifi:
      return l10n.typeWifi;
    case ContentType.contact:
      return l10n.typeContact;
    case ContentType.geo:
      return l10n.typeGeo;
    case ContentType.event:
      return l10n.typeEvent;
    case ContentType.product:
      return l10n.typeProduct;
    case ContentType.unknown:
      return l10n.typeUnknown;
  }
}

String _sourceName(BuildContext context, ScanSource source) {
  final l10n = AppLocalizations.of(context)!;
  switch (source) {
    case ScanSource.camera:
      return l10n.sourceCamera;
    case ScanSource.image:
      return l10n.sourceImage;
    case ScanSource.continuous:
      return l10n.sourceContinuous;
    case ScanSource.imported:
      return l10n.sourceImported;
    case ScanSource.generated:
      return l10n.sourceGenerated;
  }
}
