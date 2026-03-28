import 'package:flutter/material.dart';

void main() {
  runApp(const SpiceBoxPresentationApp());
}

class SpiceBoxPresentationApp extends StatelessWidget {
  const SpiceBoxPresentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DT Assessment: Spice Box',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.brown,
          primary: Colors.brown.shade700,
          secondary: Colors.amber.shade700,
          surface: const Color(0xFFFFF8F0), // Warm off-white
        ),
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PresentationScreen(),
      },
    );
  }
}

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<SlideData> _slides = [
    SlideData(
      title: 'Design Technology Assessment',
      subtitle: 'Project: The Ultimate Spice Box',
      content: [
        'Student Name: [Your Name]',
        'Candidate Number: [Your Number]',
        'Brief: To design and manufacture a sustainable, ergonomic, and aesthetically pleasing spice storage solution for culinary enthusiasts.',
        'Target Audience: Home cooks who use a variety of whole and ground spices regularly.',
      ],
      icon: Icons.inventory_2_outlined,
      isTitleSlide: true,
    ),
    SlideData(
      title: '1. Research & Analysis',
      subtitle: 'Investigating the Problem',
      content: [
        '• Existing Products: Analyzed traditional Indian Masala Dabbas, modern magnetic racks, and tiered wooden boxes.',
        '• User Needs: Spices lose flavor if exposed to light and air. Users need quick access while cooking.',
        '• Ergonomics: Must be easy to open with one hand, and compartments should fit standard measuring spoons.',
        '• Sustainability: High demand for eco-friendly materials over cheap plastics.',
      ],
      icon: Icons.search,
    ),
    SlideData(
      title: '2. Design Iterations',
      subtitle: 'From Sketch to CAD',
      content: [
        '• Idea 1 (Carousel): Rotating cylindrical design. Rejected due to complex moving parts and wasted space.',
        '• Idea 2 (Drawer System): Stacked drawers. Rejected as it makes viewing all spices simultaneously difficult.',
        '• Idea 3 (Chosen Design): Modular hexagonal wooden compartments with a transparent, airtight acrylic lid.',
        '• CAD Modeling: Modeled in Fusion 360 to test tolerances and generate orthographic working drawings.',
      ],
      icon: Icons.design_services_outlined,
    ),
    SlideData(
      title: '3. Manufacturing & Development',
      subtitle: 'Bringing the Design to Life',
      content: [
        '• Materials: Solid Oak (durable, beautiful grain) and 3mm Clear Cast Acrylic (shatter-resistant).',
        '• Joinery: Finger joints used for the outer casing to provide maximum surface area for gluing and a traditional aesthetic.',
        '• Processes: Laser cutting for the acrylic lid and internal dividers. Router used for the base rebate.',
        '• Finish: Applied three coats of food-safe mineral oil to protect the wood and enhance the grain.',
      ],
      icon: Icons.handyman_outlined,
    ),
    SlideData(
      title: '4. Final Evaluation',
      subtitle: 'Testing Against the Specification',
      content: [
        '• Successes: The box holds 7 distinct spices, is completely airtight, and the finger joints are flush and strong.',
        '• User Testing: Client praised the clear visibility of spices and the premium feel of the oak.',
        '• Areas for Improvement: The acrylic lid can be prone to scratching; future iterations could use tempered glass.',
        '• Conclusion: The project successfully meets the initial brief and provides a high-quality, sustainable product.',
      ],
      icon: Icons.fact_check_outlined,
    ),
  ];

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('DT Project Presentation'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        elevation: 0,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                'Slide ${_currentPage + 1} of ${_slides.length}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemCount: _slides.length,
              itemBuilder: (context, index) {
                return SlideWidget(slide: _slides[index]);
              },
            ),
          ),
          // Navigation Controls
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, -4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: _currentPage > 0 ? _previousPage : null,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Previous'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                ),
                // Progress Dots
                Row(
                  children: List.generate(
                    _slides.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.primary.withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _currentPage < _slides.length - 1 ? _nextPage : null,
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Next'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SlideData {
  final String title;
  final String subtitle;
  final List<String> content;
  final IconData icon;
  final bool isTitleSlide;

  SlideData({
    required this.title,
    required this.subtitle,
    required this.content,
    required this.icon,
    this.isTitleSlide = false,
  });
}

class SlideWidget extends StatelessWidget {
  final SlideData slide;

  const SlideWidget({super.key, required this.slide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Theme.of(context).colorScheme.surface,
              ],
            ),
          ),
          padding: const EdgeInsets.all(48.0),
          child: slide.isTitleSlide ? _buildTitleSlide(context) : _buildContentSlide(context),
        ),
      ),
    );
  }

  Widget _buildTitleSlide(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          slide.icon,
          size: 120,
          color: Theme.of(context).colorScheme.secondary,
        ),
        const SizedBox(height: 32),
        Text(
          slide.title,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          slide.subtitle,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey.shade700,
                fontStyle: FontStyle.italic,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 48),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: slide.content
                .map((text) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        text,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              height: 1.5,
                            ),
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildContentSlide(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                slide.icon,
                size: 48,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    slide.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    slide.subtitle,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0),
          child: Divider(thickness: 2),
        ),
        Expanded(
          child: ListView(
            children: slide.content
                .map((text) => Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (text.startsWith('•')) ...[
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0, right: 16.0),
                              child: Icon(
                                Icons.check_circle,
                                size: 20,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                text.substring(2), // Remove the bullet point
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      height: 1.6,
                                      color: Colors.black87,
                                    ),
                              ),
                            ),
                          ] else ...[
                            Expanded(
                              child: Text(
                                text,
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      height: 1.6,
                                      color: Colors.black87,
                                    ),
                              ),
                            ),
                          ]
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
