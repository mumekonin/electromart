import '../../domain/entities/product.dart';

/// Extra electronics products bundled with ElectroMart.
///
/// Why this file exists:
/// - Fake Store API only returns **6** electronics products
/// - Most are hard drives / SSDs / monitors — not a full store
/// - Chips like Laptops, TVs, Phones, AirPods would stay empty
///
/// How it works:
/// - We still load real Fake Store electronics from the API
/// - Then we append these local products in the repository
/// - Local ids start at **1001** so they never clash with Fake Store ids (1–20)
///
/// Product details: [ProductRepositoryImpl.getProductById] checks this
/// catalog first, then calls the API for Fake Store ids.
class LocalElectronicsCatalog {
  LocalElectronicsCatalog._();

  /// All extra electronics shown next to Fake Store products.
  static const List<Product> products = [
    // --- Laptops ---
    Product(
      id: 1001,
      title: 'UltraBook Pro 14" Laptop – Intel Core i7, 16GB RAM, 512GB SSD',
      price: 1299.99,
      description:
          'Slim ultrabook for work and study. Bright 14-inch display, '
          'fast SSD storage, all-day battery, and a quiet backlit keyboard. '
          'Perfect for coding, browsing, and streaming.',
      category: 'electronics',
      image:
          'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=600&q=80',
      rating: ProductRating(rate: 4.6, count: 312),
    ),
    Product(
      id: 1002,
      title: 'Gaming Notebook X15 – RTX Graphics, 144Hz Display',
      price: 1599.00,
      description:
          'High-performance gaming laptop with a 144Hz screen, dedicated '
          'RTX graphics, and advanced cooling. Play AAA titles and edit '
          'video without slowing down.',
      category: 'electronics',
      image:
          'https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=600&q=80',
      rating: ProductRating(rate: 4.7, count: 189),
    ),
    Product(
      id: 1003,
      title: 'Chromebook Go 15.6" – Lightweight Everyday Laptop',
      price: 349.99,
      description:
          'Affordable Chromebook for school and browsing. Lightweight '
          'chassis, long battery life, and instant wake. Ideal for '
          'docs, Zoom, and streaming.',
      category: 'electronics',
      image:
          'https://images.unsplash.com/photo-1525547719571-a2d4ac8945e2?w=600&q=80',
      rating: ProductRating(rate: 4.2, count: 540),
    ),

    // --- TVs ---
    Product(
      id: 1004,
      title: '55" 4K Smart TV – HDR, Streaming Apps Built In',
      price: 499.99,
      description:
          'Immersive 55-inch 4K smart television with HDR support. '
          'Watch Netflix, YouTube, and live TV apps. Slim bezel design '
          'fits any living room.',
      category: 'electronics',
      image:
          'https://images.unsplash.com/photo-1593359671755-3bbb2b0d4c0f?w=600&q=80',
      rating: ProductRating(rate: 4.4, count: 870),
    ),
    Product(
      id: 1005,
      title: '65" OLED TV – Cinema Contrast & Dolby Atmos',
      price: 1299.00,
      description:
          'Premium OLED television with perfect blacks and vibrant color. '
          'Dolby Atmos speakers and a game mode with low input lag for '
          'consoles.',
      category: 'electronics',
      image:
          'https://images.unsplash.com/photo-1461151304267-38535e780c79?w=600&q=80',
      rating: ProductRating(rate: 4.8, count: 421),
    ),

    // --- AirPods / Audio ---
    Product(
      id: 1006,
      title: 'Wireless AirPods Pro – Active Noise Cancelling Earbuds',
      price: 199.99,
      description:
          'True wireless earbuds with active noise cancelling, '
          'transparency mode, and a compact charging case. Clear calls '
          'and rich bass for music on the go.',
      category: 'electronics',
      image:
          'https://images.unsplash.com/photo-1606220588913-b3aacb4d2f46?w=600&q=80',
      rating: ProductRating(rate: 4.5, count: 2104),
    ),
    Product(
      id: 1007,
      title: 'Studio Over-Ear Headphones – Wired & Bluetooth Headset',
      price: 149.50,
      description:
          'Comfortable over-ear headphones with deep bass and clear mids. '
          'Use Bluetooth wirelessly or plug in with the included cable. '
          'Great for commuting and home office calls.',
      category: 'electronics',
      image:
          'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=600&q=80',
      rating: ProductRating(rate: 4.3, count: 968),
    ),
    Product(
      id: 1008,
      title: 'Sport Wireless Earbuds – Sweat Resistant Earphones',
      price: 79.99,
      description:
          'Secure-fit wireless earbuds for workouts. IPX5 sweat resistance, '
          'secure ear hooks, and up to 24 hours with the charging case.',
      category: 'electronics',
      image:
          'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=600&q=80',
      rating: ProductRating(rate: 4.1, count: 633),
    ),

    // --- Smartwatches ---
    Product(
      id: 1009,
      title: 'Fitness Smartwatch Series 8 – Heart Rate & GPS',
      price: 279.00,
      description:
          'Track steps, heart rate, sleep, and workouts with built-in GPS. '
          'Bright always-on display, water resistant design, and week-long '
          'battery on power-saving mode.',
      category: 'electronics',
      image:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=600&q=80',
      rating: ProductRating(rate: 4.4, count: 1450),
    ),
    Product(
      id: 1010,
      title: 'Apple Watch Style Smart Watch – Notifications & Health',
      price: 349.99,
      description:
          'Premium smart watch with crisp display, call/message alerts, '
          'blood oxygen insights, and dozens of watch faces. Compatible '
          'with popular fitness apps.',
      category: 'electronics',
      image:
          'https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=600&q=80',
      rating: ProductRating(rate: 4.6, count: 890),
    ),

    // --- Phones ---
    Product(
      id: 1011,
      title: 'NovaPhone 15 Pro – 256GB Smartphone, Dual Camera',
      price: 999.00,
      description:
          'Flagship Android smartphone with a bright OLED screen, '
          'triple-lens camera, 5G, and all-day battery. Smooth performance '
          'for gaming, photos, and productivity.',
      category: 'electronics',
      image:
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=600&q=80',
      rating: ProductRating(rate: 4.7, count: 3200),
    ),
    Product(
      id: 1012,
      title: 'iPhone Air Clone Lite – 128GB Unlocked Mobile Phone',
      price: 749.00,
      description:
          'Sleek unlocked smartphone with a sharp display, Face unlock, '
          'and a capable dual camera. Great everyday phone for calls, '
          'social apps, and mobile banking.',
      category: 'electronics',
      image:
          'https://images.unsplash.com/photo-1592899677977-9c10ca588bbd?w=600&q=80',
      rating: ProductRating(rate: 4.5, count: 1780),
    ),
    Product(
      id: 1013,
      title: 'Budget Android Phone SE – 64GB, Long Battery Life',
      price: 199.99,
      description:
          'Reliable starter smartphone with a large screen, expandable '
          'storage slot, and a battery that lasts two days for light use. '
          'Ideal first phone or backup device.',
      category: 'electronics',
      image:
          'https://images.unsplash.com/photo-1598327105666-5b89351aff97?w=600&q=80',
      rating: ProductRating(rate: 4.0, count: 990),
    ),

    // --- Monitors (extra beyond Fake Store) ---
    Product(
      id: 1014,
      title: '27" 4K IPS Monitor – USB-C Hub for Laptop Docking',
      price: 429.00,
      description:
          'Crystal-clear 4K IPS display with USB-C charging for your '
          'laptop. Thin bezels, accurate colors for design work, and '
          'built-in speakers.',
      category: 'electronics',
      image:
          'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=600&q=80',
      rating: ProductRating(rate: 4.6, count: 512),
    ),

    // --- Storage (extra) ---
    Product(
      id: 1015,
      title: '2TB NVMe SSD – Ultra-Fast Internal PC Storage',
      price: 159.99,
      description:
          'Blazing-fast NVMe solid state drive for desktops and laptops. '
          'Boot Windows in seconds and load large game libraries quickly. '
          'Includes mounting screws and cloning software link.',
      category: 'electronics',
      image:
          'https://images.unsplash.com/photo-1597872200969-2b65d56bd16b?w=600&q=80',
      rating: ProductRating(rate: 4.7, count: 740),
    ),

    // --- Gaming ---
    Product(
      id: 1016,
      title: 'PlayStation 5 Console Bundle – DualSense Controller',
      price: 499.99,
      description:
          'Next-gen gaming console with ultra-fast SSD loading, immersive '
          '3D audio, and the DualSense wireless controller. Play exclusive '
          'titles and stream 4K entertainment.',
      category: 'electronics',
      image:
          'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=600&q=80',
      rating: ProductRating(rate: 4.9, count: 5400),
    ),
    Product(
      id: 1017,
      title: 'Xbox Series Wireless Controller – Carbon Black',
      price: 59.99,
      description:
          'Official-style wireless gaming controller with textured grips, '
          'Bluetooth, and a share button. Works with console and Windows PC.',
      category: 'electronics',
      image:
          'https://images.unsplash.com/photo-1612287230202-1ff1d85d1bdf?w=600&q=80',
      rating: ProductRating(rate: 4.5, count: 2100),
    ),
    Product(
      id: 1018,
      title: 'Nintendo Style Handheld Console – Portable Gaming',
      price: 299.00,
      description:
          'Portable gaming console for play at home or on the go. Vibrant '
          'touch screen, multiplayer support, and a huge library of fun '
          'indie and family games.',
      category: 'electronics',
      image:
          'https://images.unsplash.com/photo-1578303512597-81e6cc155b3e?w=600&q=80',
      rating: ProductRating(rate: 4.6, count: 1600),
    ),

    // --- Accessories that still feel like electronics ---
    Product(
      id: 1019,
      title: 'Mechanical RGB Keyboard – Hot-Swap Gaming Keys',
      price: 119.00,
      description:
          'Tactile mechanical keyboard with per-key RGB lighting and '
          'hot-swap switches. Durable aluminum frame for desktop gaming '
          'setups.',
      category: 'electronics',
      image:
          'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=600&q=80',
      rating: ProductRating(rate: 4.4, count: 880),
    ),
    Product(
      id: 1020,
      title: 'Wireless Gaming Mouse – Lightweight & Programmable',
      price: 69.99,
      description:
          'Ergonomic wireless mouse with a high-precision sensor, '
          'programmable buttons, and long battery life. Great for gaming '
          'and everyday office use.',
      category: 'electronics',
      image:
          'https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=600&q=80',
      rating: ProductRating(rate: 4.3, count: 1205),
    ),
  ];

  /// Finds a local product by id, or null if it is an API-only product.
  static Product? findById(int id) {
    for (final product in products) {
      if (product.id == id) {
        return product;
      }
    }
    return null;
  }
}
