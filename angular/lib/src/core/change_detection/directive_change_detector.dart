import '../metadata/lifecycle_hooks.dart';
import 'change_detection_util.dart';

/// Base class for directive change detectors that are generated by compiler.
///
/// A directive change detector only extends this class if it requires lifecycle
/// calls. Goal is to share code for ngOnChanges implementation and other
/// lifecycle methods.
class DirectiveChangeDetector {
  dynamic directive;
  Map<String, SimpleChange> changes;

  /// Buffers a new change to be delivered at the end of parent change
  /// detection cycle.
  void addChange(String key, dynamic previousValue, dynamic currentValue) {
    changes ??= {};
    changes[key] = new SimpleChange(previousValue, currentValue);
  }

  /// Delivers ngOnChanges to directive and clears map.
  void ngOnChanges() {
    OnChanges target = directive;
    if (changes != null) {
      target.ngOnChanges(changes);
      changes = null;
    }
  }
}
