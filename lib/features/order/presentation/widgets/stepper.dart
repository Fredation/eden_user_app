import 'package:eden_user_app/core/data_utils/colors.dart';
import 'package:eden_user_app/core/size_config/extensions.dart';
import 'package:eden_user_app/features/order/presentation/widgets/dashed_line.dart';
import 'package:flutter/material.dart';

const double _kStepSize = 12;

/// A material step used in [EdenStepper]. The step can have a title and subtitle,
/// an icon within its circle, some content and a state that governs its
/// styling.
@immutable
class Step {
  /// Creates a step for a [EdenStepper].
  ///
  /// The [title], [content], and [state] arguments must not be null.
  const Step({
    required this.title,
    required this.subtitle,
    required this.time,
    this.state = StepState.indexed,
    this.isActive = false,
  });

  final String title;

  final String subtitle;

  final String time;

  /// The state of the step which determines the styling of its components
  /// and whether steps are interactive.
  final StepState state;

  /// Whether or not the step is active. The flag only influences styling.
  final bool isActive;
}

class EdenStepper extends StatefulWidget {
  const EdenStepper({
    Key? key,
    required this.steps,
    required this.defaultSteps,
  }) : super(key: key);

  final List<Step> steps;
  final List<Step> defaultSteps;

  @override
  State<EdenStepper> createState() => _EdenStepperState();
}

class _EdenStepperState extends State<EdenStepper>
    with TickerProviderStateMixin {
  // final Map<int, StepState> _oldStates = <int, StepState>{};

  Widget _buildLine(index, {double height = 14}) {
    return CustomPaint(
      size: Size(1, height),
      painter: DashedLineVerticalPainter(
        color: checkStep(widget.defaultSteps[index])
            ? EdenColors.primaryGreen
            : EdenColors.lightTextColor,
      ),
    );
  }

  Widget _buildCircle(int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4, top: 4),
      width: _kStepSize,
      height: _kStepSize,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: kThemeAnimationDuration,
        padding: const EdgeInsets.only(
          bottom: 6,
        ),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: checkStep(widget.defaultSteps[index])
                  ? EdenColors.primaryGreen
                  : EdenColors.lightTextColor,
            )),
        child: Icon(
          Icons.check_circle,
          color: checkStep(widget.defaultSteps[index])
              ? EdenColors.primaryGreen
              : EdenColors.lightTextColor,
          size: 10,
        ),
      ),
    );
  }

  bool checkStep(Step step) {
    final result = widget.steps
        .firstWhere((element) => element.title == step.title, orElse: () {
      return const Step(title: "", subtitle: "", time: "");
    });

    return result.title == step.title;
  }

  Widget _buildHeaderText(
    int index,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedDefaultTextStyle(
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: checkStep(widget.defaultSteps[index])
                      ? EdenColors.primaryGreen
                      : EdenColors.lightTextColor),
              duration: kThemeAnimationDuration,
              curve: Curves.fastOutSlowIn,
              child: Text(
                widget.defaultSteps[index].title,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 15.text,
                    color: checkStep(widget.defaultSteps[index])
                        ? EdenColors.primaryGreen
                        : EdenColors.lightTextColor),
              ),
            ),
            5.sV,
            Container(
              margin: const EdgeInsets.only(top: 2),
              child: AnimatedDefaultTextStyle(
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: checkStep(widget.defaultSteps[index])
                        ? EdenColors.textColor
                        : EdenColors.lightTextColor),
                duration: kThemeAnimationDuration,
                curve: Curves.fastOutSlowIn,
                child: Text(
                  widget.defaultSteps[index].subtitle,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: checkStep(widget.defaultSteps[index])
                          ? EdenColors.textColor
                          : EdenColors.lightTextColor),
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        Text(
          checkStep(widget.defaultSteps[index])
              ? widget.steps[index].time
              : "",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10),
        ),
      ],
    );
  }

  bool _isLast(int index) {
    return widget.defaultSteps.length - 1 == index;
  }

  Widget _buildVerticalHeader(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              _buildLine(index),
              _buildCircle(index),
              _buildLine(index, height: _isLast(index) ? 7 : 50),
            ],
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsetsDirectional.only(
                start: 12,
              ),
              child: _buildHeaderText(index),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _buildVerticalHeader(index),
        separatorBuilder: (context, index) => 10.sV,
        itemCount: widget.defaultSteps.length);
  }
}
