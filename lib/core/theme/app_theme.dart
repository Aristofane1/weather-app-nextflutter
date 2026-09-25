import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Thème sobre et clair : fond gris très léger, cartes blanches arrondies,
/// un seul accent bleu. Le thème sombre suit la même structure.
abstract final class AppTheme {
  static final light = _build(Brightness.light);
  static final dark = _build(Brightness.dark);

  static const seed = Color(0xFF2F80ED);
  static const radius = 16.0;
  static const fieldRadius = 12.0;

  /// Barres système transparentes (edge-to-edge) ; icônes sombres sur fond clair,
  /// claires sur fond sombre.
  static SystemUiOverlayStyle overlayStyle(Brightness brightness) {
    final isLight = brightness == Brightness.light;
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
      systemNavigationBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
      // iOS : luminosité du fond de la barre (inverse des icônes).
      statusBarBrightness: brightness,
    );
  }

  static ThemeData _build(Brightness brightness) {
    final isLight = brightness == Brightness.light;
    // `fidelity` garde un bleu franc proche du seed (tonalSpot le désature).
    final base = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
      dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    );
    // Fond d'écran gris clair, cartes blanches (en sombre : surfaces tonales du schéma).
    // Conteneurs primaires adoucis (logo, avatar) : `fidelity` les rend trop saturés.
    final scheme = isLight
        ? base.copyWith(
            surface: Colors.white,
            surfaceContainerLowest: const Color(0xFFF5F7FA),
            primaryContainer: const Color(0xFFE3EDFC),
            onPrimaryContainer: const Color(0xFF003A78),
          )
        : base.copyWith(
            primaryContainer: const Color(0xFF1E3A5F),
            onPrimaryContainer: const Color(0xFFD6E3FF),
          );
    final background = isLight ? scheme.surfaceContainerLowest : scheme.surface;
    final cardColor = isLight ? scheme.surface : scheme.surfaceContainer;
    final border = scheme.outlineVariant.withValues(alpha: isLight ? 0.6 : 0.4);
    final fieldShape = OutlineInputBorder(
      borderRadius: BorderRadius.circular(fieldRadius),
      borderSide: BorderSide.none,
    );
    final buttonShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(fieldRadius));
    const buttonSize = Size(64, 48);
    final textTheme = ThemeData(brightness: brightness).textTheme;

    return ThemeData(
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      textTheme: textTheme.copyWith(
        titleLarge: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        titleMedium: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: false,
        systemOverlayStyle: overlayStyle(brightness),
        titleTextStyle: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700, color: scheme.onSurface),
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: border),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isLight ? const Color(0xFFF0F2F5) : scheme.surfaceContainerHighest,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: fieldShape,
        enabledBorder: fieldShape,
        focusedBorder: fieldShape.copyWith(borderSide: BorderSide(color: scheme.primary, width: 2)),
        errorBorder: fieldShape.copyWith(borderSide: BorderSide(color: scheme.error)),
        focusedErrorBorder: fieldShape.copyWith(borderSide: BorderSide(color: scheme.error, width: 2)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(minimumSize: buttonSize, shape: buttonShape),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(minimumSize: buttonSize, shape: buttonShape),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 2,
        highlightElevation: 4,
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: SegmentedButton.styleFrom(minimumSize: buttonSize),
      ),
      dividerTheme: DividerThemeData(color: border, space: 1, thickness: 1),
      listTileTheme: const ListTileThemeData(contentPadding: EdgeInsets.symmetric(horizontal: 16)),
    );
  }
}
