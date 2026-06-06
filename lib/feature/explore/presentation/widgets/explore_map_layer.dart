// ==============================================================================
// lib/feature/explore/presentation/widgets/explore_map_layer.dart
// Google Maps with one pin per nearby event, styled like a Google place marker:
// a white rounded pill with a category-coloured icon circle, the distance label,
// and a small pointer tip at the bottom that sits on the exact location. The
// pill is painted to a bitmap. Recentres the camera when [center] changes.
// ==============================================================================

import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:latlong2/latlong.dart';

import 'package:tap_app/core/router/app_router.dart';
import 'package:tap_app/feature/home/domain/entities/event_entity.dart';

Color _categoryColor(final String category) {
  switch (category.toLowerCase()) {
    case 'art':
      return const Color(0xFFFF8551);
    case 'music':
      return const Color(0xFF1AC5B0);
    case 'tech':
      return const Color(0xFF7B61FF);
    case 'sports':
      return const Color(0xFFE54B6E);
    case 'food':
      return const Color(0xFF5BB55F);
    default:
      return const Color(0xFF7B61FF);
  }
}

IconData _categoryIcon(final String category) {
  switch (category.toLowerCase()) {
    case 'art':
      return Icons.palette;
    case 'music':
      return Icons.music_note;
    case 'tech':
      return Icons.computer;
    case 'sports':
      return Icons.sports_basketball;
    case 'food':
      return Icons.restaurant;
    default:
      return Icons.local_activity;
  }
}

String _distanceLabel(final double? metres) {
  if (metres == null) return '';
  if (metres < 1000) return '${metres.round()} m';
  return '${(metres / 1000).round()} km';
}

class ExploreMapLayer extends StatefulWidget {
  const ExploreMapLayer({
    required this.center,
    required this.events,
    super.key,
  });

  final LatLng center;
  final List<Event> events;

  @override
  State<ExploreMapLayer> createState() => _ExploreMapLayerState();
}

class _ExploreMapLayerState extends State<ExploreMapLayer> {
  gmaps.GoogleMapController? _controller;
  Set<gmaps.Marker> _markers = <gmaps.Marker>{};

  // Cache the painted pill (bitmap + tip anchor) so each unique pill is only
  // painted once.
  final Map<String, (gmaps.BitmapDescriptor, Offset)> _iconCache =
      <String, (gmaps.BitmapDescriptor, Offset)>{};

  double _dpr = 3;

  gmaps.LatLng get _center =>
      gmaps.LatLng(widget.center.latitude, widget.center.longitude);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _dpr = MediaQuery.of(context).devicePixelRatio;
    _rebuildMarkers();
  }

  @override
  void didUpdateWidget(final ExploreMapLayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.center != widget.center) {
      _controller?.animateCamera(gmaps.CameraUpdate.newLatLng(_center));
    }
    if (oldWidget.events != widget.events) {
      _rebuildMarkers();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _rebuildMarkers() async {
    final Iterable<Event> located = widget.events.where(
      (final Event e) => e.hasLocation,
    );
    final Set<gmaps.Marker> markers = <gmaps.Marker>{};

    for (final Event e in located) {
      final String label = _distanceLabel(e.distanceM);
      final String key = '${e.category}|$label';
      final (gmaps.BitmapDescriptor, Offset) pin = _iconCache[key] ??=
          await _buildPillBitmap(
            color: _categoryColor(e.category),
            icon: _categoryIcon(e.category),
            label: label,
            dpr: _dpr,
          );

      markers.add(
        gmaps.Marker(
          markerId: gmaps.MarkerId(e.id),
          position: gmaps.LatLng(e.latitude!, e.longitude!),
          icon: pin.$1,
          anchor: pin.$2,
          onTap: () => context.router.push(EventDetailRoute(eventId: e.id)),
        ),
      );
    }

    if (mounted) setState(() => _markers = markers);
  }

  @override
  Widget build(final BuildContext context) {
    return gmaps.GoogleMap(
      initialCameraPosition: gmaps.CameraPosition(target: _center, zoom: 14.5),
      markers: _markers,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      onMapCreated: (final gmaps.GoogleMapController c) => _controller = c,
    );
  }
}

/// Paints a Google-style place marker — a white rounded pill with a category
/// icon circle, the distance label, and a pointer tip at the bottom — to a PNG.
/// Returns the bitmap and the anchor that places the tip on the location. [dpr]
/// keeps it crisp and is passed back as the image pixel ratio so the marker
/// renders at the intended on-screen size.
Future<(gmaps.BitmapDescriptor, Offset)> _buildPillBitmap({
  required final Color color,
  required final IconData icon,
  required final String label,
  required final double dpr,
}) async {
  // Fixed pill size (logical px). dpr keeps it crisp at this size.
  const double pillWidth = 74;
  const double pillHeight = 38;
  const double radius = 11;
  const double circle = 24;
  const double padLeft = 5;
  const double gap = 6;
  const double margin = 5; // room around the pill for the shadow
  const double pointerW = 14; // width of the bottom tip
  const double pointerH = 7; // height of the bottom tip

  final double width = pillWidth + margin * 2;
  final double height = pillHeight + pointerH + margin * 2;

  final ui.PictureRecorder recorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(recorder)..scale(dpr);

  // Pill + pointer tip as one shape, so the shadow and fill are unified.
  final double tipX = margin + pillWidth / 2;
  final double baseY = margin + pillHeight;
  final double tipY = baseY + pointerH;
  final ui.Path pillPath = ui.Path()
    ..addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(margin, margin, pillWidth, pillHeight),
        const Radius.circular(radius),
      ),
    );
  final ui.Path pointerPath = ui.Path()
    ..moveTo(tipX - pointerW / 2, baseY - 1)
    ..lineTo(tipX + pointerW / 2, baseY - 1)
    ..lineTo(tipX, tipY)
    ..close();
  final ui.Path shape = ui.Path.combine(
    PathOperation.union,
    pillPath,
    pointerPath,
  );

  canvas.drawShadow(shape, const Color(0x33000000), 2, false);
  canvas.drawPath(shape, Paint()..color = Colors.white);

  // Category circle (vertically centred in the pill body).
  final double cx = margin + padLeft + circle / 2;
  final double cy = margin + pillHeight / 2;
  canvas.drawCircle(Offset(cx, cy), circle / 2, Paint()..color = color);

  // Category icon glyph, centred in the circle.
  final TextPainter iconPainter = TextPainter(textDirection: TextDirection.ltr)
    ..text = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        fontSize: 15,
        fontFamily: icon.fontFamily,
        package: icon.fontPackage,
        color: Colors.white,
      ),
    )
    ..layout();
  iconPainter.paint(
    canvas,
    Offset(cx - iconPainter.width / 2, cy - iconPainter.height / 2),
  );

  // Distance label, to the right of the circle.
  if (label.isNotEmpty) {
    final TextPainter textPainter =
        TextPainter(textDirection: TextDirection.ltr)
          ..text = TextSpan(
            text: label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0F172A),
            ),
          )
          ..layout();
    textPainter.paint(
      canvas,
      Offset(margin + padLeft + circle + gap, cy - textPainter.height / 2),
    );
  }

  final ui.Image image = await recorder.endRecording().toImage(
    (width * dpr).ceil(),
    (height * dpr).ceil(),
  );
  final ByteData? bytes = await image.toByteData(
    format: ui.ImageByteFormat.png,
  );

  // Anchor at the pointer tip so the marker sits on the exact location.
  final Offset anchor = Offset(tipX / width, tipY / height);
  return (
    gmaps.BitmapDescriptor.bytes(
      bytes!.buffer.asUint8List(),
      imagePixelRatio: dpr,
    ),
    anchor,
  );
}
