import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/question_option.dart';
import '../providers/questions_provider.dart';

class QuestionCard extends ConsumerStatefulWidget {
  final Question question;
  final VoidCallback? onAnswered;

  const QuestionCard({
    super.key,
    required this.question,
    this.onAnswered,
  });

  @override
  ConsumerState<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends ConsumerState<QuestionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    
    _animationController.forward();
    
    // Load existing answer if any
    final existingAnswer = ref.read(userAnswersProvider.notifier)
        .getAnswerForQuestion(widget.question.id);
    if (existingAnswer?.textAnswer != null) {
      _textController.text = existingAnswer!.textAnswer!;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userAnswers = ref.watch(userAnswersProvider);
    final currentAnswer = userAnswers
        .where((answer) => answer.questionId == widget.question.id)
        .firstOrNull;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.question.text,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2D3748),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (widget.question.type == 'single')
                    _buildSingleChoiceOptions(currentAnswer)
                  else if (widget.question.type == 'open')
                    _buildOpenEndedInput(currentAnswer),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSingleChoiceOptions(dynamic currentAnswer) {
    return Column(
      children: widget.question.option.map((option) {
        final isSelected = currentAnswer?.selectedOptionId == option.id;
        
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _selectOption(option),
              borderRadius: BorderRadius.circular(12),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? const Color(0xFF7EB09B).withOpacity(0.1)
                      : const Color(0xFFF7FAFC),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected 
                        ? const Color(0xFF7EB09B)
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected 
                            ? const Color(0xFF7EB09B)
                            : Colors.transparent,
                        border: Border.all(
                          color: isSelected 
                              ? const Color(0xFF7EB09B)
                              : const Color(0xFFCBD5E0),
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 14,
                            )
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        option.text,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: isSelected 
                              ? const Color(0xFF7EB09B)
                              : const Color(0xFF4A5568),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildOpenEndedInput(dynamic currentAnswer) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
        ),
      ),
      child: TextField(
        controller: _textController,
        maxLines: 4,
        onChanged: (value) => _updateTextAnswer(value),
        decoration: const InputDecoration(
          hintText: 'Share your thoughts...',
          hintStyle: TextStyle(
            color: Color(0xFFA0AEC0),
            fontSize: 16,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF2D3748),
          height: 1.5,
        ),
      ),
    );
  }

  void _selectOption(QuestionOption option) {
    ref.read(userAnswersProvider.notifier).updateAnswer(
      widget.question.id,
      selectedOptionId: option.id,
    );
    widget.onAnswered?.call();
  }

  void _updateTextAnswer(String text) {
    if (text.trim().isNotEmpty) {
      ref.read(userAnswersProvider.notifier).updateAnswer(
        widget.question.id,
        textAnswer: text,
      );
      widget.onAnswered?.call();
    }
  }
}
