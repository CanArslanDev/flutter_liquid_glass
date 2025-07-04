import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/liquid_glass.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liquid Glass Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LiquidGlassDemo(),
    );
  }
}

class LiquidGlassDemo extends StatefulWidget {
  const LiquidGlassDemo({super.key});

  @override
  State<LiquidGlassDemo> createState() => _LiquidGlassDemoState();
}

class _LiquidGlassDemoState extends State<LiquidGlassDemo> {
  LiquidGlassConfig _currentConfig = LiquidGlassConfig.simple();
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Animated gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _isDarkMode
                    ? [
                        const Color(0xFF0F0F1E),
                        const Color(0xFF1A1A3E),
                        const Color(0xFF16213E),
                      ]
                    : [
                        const Color(0xFF667eea),
                        const Color(0xFF764ba2),
                        const Color(0xFFf093fb),
                      ],
              ),
            ),
          ),

          // Decorative circles for better glass effect visibility
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _isDarkMode
                        ? Colors.blue.withValues(alpha: 0.3)
                        : Colors.white.withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            left: -150,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    _isDarkMode
                        ? Colors.purple.withValues(alpha: 0.3)
                        : Colors.pink.withValues(alpha: 0.3),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Floating decorative elements
          ...List.generate(5, (index) {
            return Positioned(
              top: 100.0 + (index * 120),
              left: 30.0 + (index * 40),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      (_isDarkMode ? Colors.cyan : Colors.orange).withValues(
                        alpha: 0.3,
                      ),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            );
          }),

          // Main content
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  _isDarkMode
                      ? 'https://images.unsplash.com/photo-1557683316-973673baf926?w=1080' // Dark abstract gradient
                      : 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=1080', // Colorful abstract
                ),
                fit: BoxFit.cover,
                opacity: 0.3,
              ),
            ),
          ),

          // Content with glass effects
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Liquid Glass Demo',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: const Offset(0, 2),
                          blurRadius: 8,
                          color: Colors.black.withValues(alpha: 0.4),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),

                  // Simple usage example
                  _buildSection(
                    'Simple Usage',
                    LiquidGlassContainer(
                      config: LiquidGlassConfig.simple(),
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'This is a simple Liquid Glass container',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),

                  // Button examples
                  _buildSection(
                    'Button Variants',
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        LiquidGlassButton(
                          text: 'Default',
                          textStyle: const TextStyle(color: Colors.white),
                          onPressed: () {},
                        ),
                        LiquidGlassButton(
                          text: 'Vibrant',
                          textStyle: const TextStyle(color: Colors.white),
                          config: LiquidGlassConfig.vibrant(),
                          onPressed: () {},
                        ),
                        LiquidGlassButton(
                          text: 'Subtle',
                          textStyle: const TextStyle(color: Colors.white),
                          config: LiquidGlassConfig.subtle(),
                          onPressed: () {},
                        ),
                        LiquidGlassButton(
                          text: 'Frosted',
                          textStyle: const TextStyle(color: Colors.white),
                          config: LiquidGlassConfig.frosted(),
                          onPressed: () {},
                        ),
                        LiquidGlassButton.icon(
                          icon: Icons.favorite,
                          iconColor: Colors.white,
                          config: LiquidGlassConfig.vibrant(),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),

                  // Example with image background
                  _buildSection(
                    'Glass Over Image',
                    Stack(
                      children: [
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: NetworkImage(
                                'https://images.unsplash.com/photo-1579546929518-9e396f3cc809?w=1080',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 20,
                          right: 20,
                          child: LiquidGlassContainer(
                            config: LiquidGlassConfig.frosted(),
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Glassmorphism',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Beautiful glass effect over images',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildSection(
                    'Cards',
                    LiquidGlassCard(
                      config: _currentConfig,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue.withValues(
                                alpha: 0.2,
                              ),
                              child: const Icon(
                                Icons.person,
                                color: Colors.blue,
                              ),
                            ),
                            title: Text(
                              'John Doe',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              'Software Developer',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'This is a Liquid Glass card with beautiful glass morphism effect.',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Custom configuration example
                  _buildSection(
                    'Custom Configuration',
                    LiquidGlassContainer(
                      config: LiquidGlassConfig(
                        baseColor: Colors.purple,
                        opacity: 0.15,
                        blurAmount: 25,
                        borderRadius: BorderRadius.circular(30),
                        enableSpecularHighlight: true,
                        refractionIntensity: 0.8,
                        gradient: LinearGradient(
                          colors: [
                            Colors.purple.withValues(alpha: 0.1),
                            Colors.blue.withValues(alpha: 0.1),
                          ],
                        ),
                        shadows: [
                          BoxShadow(
                            color: Colors.purple.withValues(alpha: 0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            size: 48,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Fully Customized',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Navigation bar example
                  _buildSection(
                    'Navigation Bar',
                    LiquidGlassNavigationBar(
                      config: _currentConfig,
                      selectedIndex: 0,
                      onItemSelected: (index) {},
                      items: const [
                        LiquidGlassNavigationItem(
                          icon: Icons.home,
                          label: 'Home',
                        ),
                        LiquidGlassNavigationItem(
                          icon: Icons.search,
                          label: 'Search',
                        ),
                        LiquidGlassNavigationItem(
                          icon: Icons.favorite,
                          label: 'Favorites',
                        ),
                        LiquidGlassNavigationItem(
                          icon: Icons.person,
                          label: 'Profile',
                        ),
                      ],
                    ),
                  ),

                  // Configuration controls
                  const SizedBox(height: 40),
                  LiquidGlassContainer(
                    config: LiquidGlassConfig.frosted(),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Configuration Presets',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            _buildPresetButton(
                              'Simple',
                              LiquidGlassConfig.simple(),
                            ),
                            _buildPresetButton(
                              'Dark',
                              LiquidGlassConfig.dark(),
                            ),
                            _buildPresetButton(
                              'Vibrant',
                              LiquidGlassConfig.vibrant(),
                            ),
                            _buildPresetButton(
                              'Subtle',
                              LiquidGlassConfig.subtle(),
                            ),
                            _buildPresetButton(
                              'Frosted',
                              LiquidGlassConfig.frosted(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SwitchListTile(
                          title: Text(
                            'Dark Mode',
                            style: TextStyle(color: Colors.white),
                          ),
                          value: _isDarkMode,
                          onChanged: (value) {
                            setState(() {
                              _isDarkMode = value;
                            });
                          },
                          activeColor: Colors.white,
                          activeTrackColor: Colors.white24,
                          inactiveThumbColor: Colors.white60,
                          inactiveTrackColor: Colors.white24,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Floating action button with glass effect
      floatingActionButton: LiquidGlassContainer(
        config: LiquidGlassConfig.vibrant(),
        width: 60,
        height: 60,
        padding: const EdgeInsets.all(16),
        onTap: () {
          setState(() {
            _isDarkMode = !_isDarkMode;
          });
        },
        child: Icon(
          _isDarkMode ? Icons.light_mode : Icons.dark_mode,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: const Offset(0, 2),
                blurRadius: 4,
                color: Colors.black.withValues(alpha: 0.3),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        child,
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildPresetButton(String label, LiquidGlassConfig config) {
    return LiquidGlassButton(
      text: label,
      textStyle: const TextStyle(color: Colors.white),
      config: LiquidGlassConfig.subtle(),
      onPressed: () {
        setState(() {
          _currentConfig = config;
        });
      },
    );
  }
}
