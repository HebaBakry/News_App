import 'package:flutter/material.dart';
import 'package:news_app/core/services/preference_manager.dart';
import 'package:news_app/features/auth/sign_in_screen.dart';
import 'package:news_app/features/home/models/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  ///  : Task - Create Model For This List
  final List<OnboardingModel> onboardingData = [
    OnboardingModel(
      image: 'assets/images/onboarding1.png',
      title: 'Update for new features',
      description:
          "You deserve the best experience possible. That's why we've added new features and services to our app. Update now and see for yourself.",
    ),
    OnboardingModel(
      image: 'assets/images/onboarding2.png',
      title: 'Update for new features',
      description:
          "You deserve the best experience possible. That's why we've added new features and services to our app. Update now and see for yourself.",
    ),
    OnboardingModel(
      image: 'assets/images/onboarding3.png',
      title: 'Update for new features',
      description:
          "You deserve the best experience possible. That's why we've added new features and services to our app. Update now and see for yourself.",
    ),
  ];

  void _onNext() {
    if (_currentPage < onboardingData.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  Future<void> _finishOnboarding() async {
    /// TODO : Task - Use Preference Manager And don't use hard coded values like [onboarding_complete]
    await PreferencesManager().setBool('onboarding_complete', true);
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SignInScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// TODO : Task - Use from theme data
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      appBar: AppBar(
        /// TODO : Task - Add This values on theme data
        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
        elevation: 0,
        actions: [
          if (_currentPage < onboardingData.length - 1)
            TextButton(
              onPressed: _finishOnboarding,
              child: const Text(
                'Skip',
                style: TextStyle(color: Color(0xFFD32F2F), fontSize: 18),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: onboardingData.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                final data = onboardingData[index];
                return Column(
                  children: [
                    const SizedBox(height: 16),

                    /// TODO : Task - Use This From Model
                    Image.asset(data.image, height: 320, fit: BoxFit.contain),
                    const SizedBox(height: 32),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        /// TODO : Task - Use This From Model
                        data.title,
                        textAlign: TextAlign.center,

                        /// TODO : Task - Add This To Theme Data
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),

                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        /// TODO : Task - Use This From Model
                        data.description,
                        textAlign: TextAlign.center,

                        /// TODO : Task - Add This To Theme Data
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 24),
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? const Color(0xFFC53030)
                      : Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                /// TODO : Task - Add This To Theme Data
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC53030),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: _onNext,
                child: Text(
                  _currentPage == onboardingData.length - 1
                      ? 'Get Started'
                      : 'Next',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
