# Liquid Glass UI

A comprehensive Flutter package that brings Apple's Liquid Glass design language to Flutter applications with extensive customization options.

## Features

- 🎨 **Beautiful Glass Morphism**: Authentic liquid glass effect with blur, refraction, and specular highlights
- ⚡ **Performance Optimized**: Efficient rendering with customizable quality settings
- 🎯 **Easy to Use**: Simple API with sensible defaults
- 🛠️ **Highly Customizable**: Extensive configuration options for every aspect
- 📱 **Platform Adaptive**: Automatically adapts to light/dark themes
- 🎭 **Interactive Effects**: Hover, press, and parallax animations
- 🧩 **Pre-built Components**: Ready-to-use buttons, containers, cards, and navigation bars

## Installation

Add `liquid_glass_ui` to your `pubspec.yaml`:

```yaml
dependencies:
  liquid_glass_ui: ^1.0.0
```

## Quick Start

### Simple Usage

```dart
import 'package:liquid_glass_ui/liquid_glass_ui.dart';

// Basic container
LiquidGlassContainer(
  child: Text('Hello Liquid Glass!'),
)

// Simple button
LiquidGlassButton(
  text: 'Click Me',
  onPressed: () {},
)
```

### Using Presets

```dart
// Dark mode preset
LiquidGlassContainer(
  config: LiquidGlassConfig.dark(),
  child: Text('Dark Glass'),
)

// Vibrant preset
LiquidGlassButton(
  text: 'Vibrant',
  config: LiquidGlassConfig.vibrant(),
  onPressed: () {},
)

// Frosted glass preset
LiquidGlassCard(
  config: LiquidGlassConfig.frosted(),
  child: Text('Frosted Card'),
)
```

## Advanced Customization

### Custom Configuration

```dart
LiquidGlassContainer(
  config: LiquidGlassConfig(
    // Basic appearance
    baseColor: Colors.purple,
    opacity: 0.15,
    blurAmount: 25,
    borderRadius: BorderRadius.circular(30),
    
    // Effects
    enableSpecularHighlight: true,
    refractionIntensity: 0.8,
    enableParallax: true,
    parallaxIntensity: 0.1,
    
    // Advanced effects
    enableChromaticAberration: true,
    distortionAmount: 0.05,
    frostIntensity: 0.3,
    
    // Animations
    animationDuration: Duration(milliseconds: 300),
    animationCurve: Curves.easeInOutCubic,
    
    // Styling
    gradient: LinearGradient(
      colors: [Colors.purple.withOpacity(0.1), Colors.blue.withOpacity(0.1)],
    ),
    shadows: [
      BoxShadow(
        color: Colors.purple.withOpacity(0.2),
        blurRadius: 20,
        offset: Offset(0, 10),
      ),
    ],
  ),
  child: YourContent(),
)
```

## Available Widgets

### LiquidGlassContainer
A versatile container with liquid glass effect.

```dart
LiquidGlassContainer(
  width: 200,
  height: 100,
  padding: EdgeInsets.all(20),
  config: LiquidGlassConfig.simple(),
  onTap: () {},
  child: Text('Container'),
)
```

### LiquidGlassButton
A button with various styles and states.

```dart
// Text button
LiquidGlassButton(
  text: 'Submit',
  onPressed: () {},
  isLoading: false,
  isDisabled: false,
)

// Icon button
LiquidGlassButton.icon(
  icon: Icons.favorite,
  onPressed: () {},
  size: LiquidGlassButtonSize.large,
)

// Button with icon and text
LiquidGlassButton(
  text: 'Save',
  icon: Icons.save,
  onPressed: () {},
)
```

### LiquidGlassCard
A card component with elevation effect.

```dart
LiquidGlassCard(
  elevation: 4.0,
  margin: EdgeInsets.all(10),
  child: ListTile(
    title: Text('Card Title'),
    subtitle: Text('Card subtitle'),
  ),
)
```

### LiquidGlassNavigationBar
A bottom navigation bar with glass effect.

```dart
LiquidGlassNavigationBar(
  selectedIndex: 0,
  onItemSelected: (index) {},
  items: [
    LiquidGlassNavigationItem(icon: Icons.home, label: 'Home'),
    LiquidGlassNavigationItem(icon: Icons.search, label: 'Search'),
    LiquidGlassNavigationItem(icon: Icons.person, label: 'Profile'),
  ],
)
```

## Configuration Options

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `baseColor` | Color? | null | Base color of the glass |
| `opacity` | double | 0.1 | Transparency level (0.0 - 1.0) |
| `blurAmount` | double | 10.0 | Background blur intensity |
| `borderRadius` | BorderRadius | 20 | Corner radius |
| `enableSpecularHighlight` | bool | true | Enable light reflections |
| `refractionIntensity` | double | 0.5 | Light bending effect |
| `adaptToContent` | bool | true | Adapt color to content |
| `enableParallax` | bool | true | Enable parallax on hover |
| `frostIntensity` | double | 0.0 | Frosted glass effect |
| `enableChromaticAberration` | bool | false | Color separation effect |

## Best Practices

1. **Performance**: For better performance on lower-end devices, reduce `blurAmount` and disable `enableCustomShader`.

2. **Accessibility**: Ensure sufficient contrast between content and background when using liquid glass effects.

3. **Theme Integration**: Use `config.adaptToContent` to automatically adapt to your app's theme.

## Example App

Check out the [example](example/) directory for a complete demo app showcasing all features.

## Contributing

Contributions are welcome! Please read our [contributing guidelines](CONTRIBUTING.md) before submitting pull requests.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.