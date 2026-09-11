import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapLocationCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final LatLng location;
  final double zoom;
  final double height;
  final double borderRadius;
  final Color accentColor;
  final Color cardColor;
  final VoidCallback? onTap;
  final Widget? customIcon;
  final bool interactive;

  const MapLocationCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.location,
    this.zoom = 14.5,
    this.height = 220,
    this.borderRadius = 20,
    this.accentColor = const Color(0xFFFF6B35),
    this.cardColor = const Color(0xFF1C2130),
    this.onTap,
    this.customIcon,
    this.interactive = true,
  });

  @override
  State<MapLocationCard> createState() => _MapLocationCardState();
}

class _MapLocationCardState extends State<MapLocationCard> {
  GoogleMapController? _mapController;

  static const _darkMapStyle = '''
  [
    {"elementType": "geometry", "stylers": [{"color": "#1a1f2e"}]},
    {"elementType": "labels.text.fill", "stylers": [{"color": "#8896a5"}]},
    {"elementType": "labels.text.stroke", "stylers": [{"color": "#1a1f2e"}]},
    {"featureType": "road", "elementType": "geometry", "stylers": [{"color": "#2c3347"}]},
    {"featureType": "road", "elementType": "labels.text.fill", "stylers": [{"color": "#9ca5b3"}]},
    {"featureType": "road.highway", "elementType": "geometry", "stylers": [{"color": "#3a4460"}]},
    {"featureType": "water", "elementType": "geometry", "stylers": [{"color": "#0f1626"}]},
    {"featureType": "poi", "elementType": "geometry", "stylers": [{"color": "#1e2535"}]},
    {"featureType": "poi", "elementType": "labels.text.fill", "stylers": [{"color": "#6b7688"}]},
    {"featureType": "transit", "elementType": "geometry", "stylers": [{"color": "#2f3547"}]},
    {"featureType": "administrative", "elementType": "geometry", "stylers": [{"color": "#2a2f42"}]}
  ]
  ''';

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    controller.setMapStyle(_darkMapStyle);
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: SizedBox(
          height: widget.height,
          child: Stack(
            children: [
              // ── Map ──────────────────────────────────────
              GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: widget.location,
                  zoom: widget.zoom,
                ),
                markers: {
                  Marker(
                    markerId: MarkerId(widget.title),
                    position: widget.location,
                  ),
                },
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                compassEnabled: false,
                scrollGesturesEnabled: widget.interactive,
                zoomGesturesEnabled: widget.interactive,
                rotateGesturesEnabled: widget.interactive,
                tiltGesturesEnabled: widget.interactive,
                liteModeEnabled: !widget.interactive,
              ),

              // ── Bottom card ───────────────────────────────
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: widget.cardColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Icon container
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: widget.accentColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:
                            widget.customIcon ??
                            const Icon(
                              Icons.navigation_rounded,
                              color: Colors.white,
                              size: 22,
                            ),
                      ),
                      const SizedBox(width: 12),

                      // Title & subtitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.2,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.subtitle,
                              style: const TextStyle(
                                color: Color(0xFF8896A5),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      // Optional chevron if tappable
                      if (widget.onTap != null)
                        Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.white.withOpacity(0.4),
                          size: 20,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
