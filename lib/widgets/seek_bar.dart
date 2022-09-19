import 'dart:math';

import 'package:flutter/material.dart';

class SeekBarData {
  final Duration position;
  final Duration duration;

  SeekBarData({
    required this.position,
    required this.duration,
  });
}

class SeekBar extends StatefulWidget {
  final Duration position;
  final Duration duration;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangedEnd;

  const SeekBar({
    super.key,
    required this.position,
    required this.duration,
    this.onChanged,
    this.onChangedEnd,
  });

  @override
  State<SeekBar> createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;

  String _formatDuration(Duration? duration) {
    if (duration == null) {
      return '--:--';
    } else {
      String minutes = duration.inMinutes.toString().padLeft(2,'0');
      String seconds = duration.inSeconds.remainder(60).toString().padLeft(2,'0');
      return '$minutes:$seconds';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          _formatDuration(
           widget.position, /// Widget. Indicate Class [Here is SeekBar]
          ),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 4.0, // Height SeekBar
              thumbShape: const RoundSliderThumbShape(
                disabledThumbRadius: 4.0, // Fill Color OF Loading
                enabledThumbRadius: 4.0, // Circle Left Size
              ),
              overlayShape: const RoundSliderOverlayShape(
                overlayRadius: 10.0,/// Sides
              ),
              activeTrackColor: Colors.yellow.withOpacity(0.2),
              inactiveTrackColor: Colors.white, /// Color
              thumbColor: Colors.white, // Circle Left Size
              overlayColor: Colors.red, // When Hover
            ),
            child: Slider(
              min: 0.0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: min(
                _dragValue ?? widget.duration.inMilliseconds.toDouble(),
                widget.position.inMilliseconds.toDouble(),
              ),
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(Duration(milliseconds: value.round()),);
                }
              },
              onChangeEnd: (value) {
                if (widget.onChangedEnd != null) {
                  widget.onChangedEnd!(Duration(milliseconds: value.round()),);
                }
                _dragValue = null;
              },
            ),
          ),
        ),
        Text(
          _formatDuration(
            widget.duration,
          ),
        ),
      ],
    );
  }
}
