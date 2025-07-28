import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../models/cleaning_log_model.dart';
import '../../../providers/log_provider.dart';
import 'animated_overlay_container.dart';
import 'delete_confirmation_header.dart';
import 'record_preview_card.dart';
import 'delete_confirmation_input.dart';
import 'delete_action_buttons.dart';

class DeleteConfirmationOverlay extends StatefulWidget {
  final CleaningRecord record;
  final VoidCallback onCancel;

  const DeleteConfirmationOverlay({
    super.key,
    required this.record,
    required this.onCancel,
  });

  @override
  State<DeleteConfirmationOverlay> createState() => _DeleteConfirmationOverlayState();
}

class _DeleteConfirmationOverlayState extends State<DeleteConfirmationOverlay>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _animationController.forward();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  bool get _canDelete => _controller.text.toLowerCase() == 'delete';

  void _handleDelete() async {
    if (!_canDelete || _isDeleting) return;

    setState(() {
      _isDeleting = true;
    });

    // Add a small delay for better UX
    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      // Delete the record using the provider
      context.read<LogProvider>().removeLog(widget.record.cleaningId);

      // Close the overlay
      _closeOverlay();
    }
  }

  void _closeOverlay() async {
    await _animationController.reverse();
    if (mounted) {
      widget.onCancel();
    }
  }

  void _onInputChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return AnimatedOverlayContainer(
          scaleAnimation: _scaleAnimation,
          opacityAnimation: _opacityAnimation,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DeleteConfirmationHeader(),
              SizedBox(height: 20.h),
              RecordPreviewCard(record: widget.record),
              SizedBox(height: 20.h),
              DeleteConfirmationInput(
                controller: _controller,
                isDeleting: _isDeleting,
                onChanged: _onInputChanged,
              ),
              SizedBox(height: 24.h),
              DeleteActionButtons(
                canDelete: _canDelete,
                isDeleting: _isDeleting,
                onCancel: _closeOverlay,
                onDelete: _handleDelete,
              ),
            ],
          ),
        );
      },
    );
  }
}