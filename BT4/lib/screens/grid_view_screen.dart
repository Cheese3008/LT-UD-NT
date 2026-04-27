import 'package:flutter/material.dart';

class GridViewScreen extends StatefulWidget {
  const GridViewScreen({super.key});

  @override
  State<GridViewScreen> createState() => _GridViewScreenState();
}

class _GridViewScreenState extends State<GridViewScreen> {
  late final List<GalleryItem> _items;
  late final List<GlobalKey> _fixedGridKeys;

  int? _highlightedIndex;

  @override
  void initState() {
    super.initState();

    _items = List.generate(
      12,
      (index) => GalleryItem(
        title: 'Image ${index + 1}',
        imagePath: _imagePaths[index],
        color: _pastelColors[index % _pastelColors.length],
      ),
    );

    _fixedGridKeys = List.generate(
      12,
      (index) => GlobalKey(),
    );
  }

  void _scrollToFixedGridItem(int index) {
    final targetContext = _fixedGridKeys[index].currentContext;

    if (targetContext == null) {
      return;
    }

    setState(() {
      _highlightedIndex = index;
    });

    Scrollable.ensureVisible(
      targetContext,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      alignment: 0.25,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBFE),
      appBar: AppBar(
        title: const Text('GridView Exercise'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF8EAF6),
        foregroundColor: const Color(0xFF5C4B51),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _SectionHeader(title: 'Fixed Column Grid'),
            const SizedBox(height: 14),

            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1,
              children: List.generate(_items.length, (index) {
                return _GridImageCard(
                  key: _fixedGridKeys[index],
                  item: _items[index],
                  isHighlighted: _highlightedIndex == index,
                );
              }),
            ),

            const SizedBox(height: 30),

            const _SectionHeader(title: 'Responsive Grid'),
            const SizedBox(height: 14),

            GridView.extent(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              maxCrossAxisExtent: 150,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8,
              children: List.generate(_items.length, (index) {
                return _GridImageCard(
                  item: _items[index],
                  isHighlighted: false,
                  onTap: () => _scrollToFixedGridItem(index),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class _GridImageCard extends StatelessWidget {
  final GalleryItem item;
  final bool isHighlighted;
  final VoidCallback? onTap;

  const _GridImageCard({
    super.key,
    required this.item,
    required this.isHighlighted,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          color: item.color,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isHighlighted ? const Color(0xFFB86B8B) : Colors.white,
            width: isHighlighted ? 3 : 1.4,
          ),
          boxShadow: [
            BoxShadow(
              color: isHighlighted
                  ? const Color(0x335C4B51)
                  : const Color(0x14000000),
              blurRadius: isHighlighted ? 16 : 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    width: double.infinity,
                    color: Colors.white.withOpacity(0.55),
                    child: Image.asset(
                      item.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 34,
                            color: Color(0xFF8A7A81),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF5E5257),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 21,
        fontWeight: FontWeight.bold,
        color: Color(0xFF5C4B51),
      ),
    );
  }
}

class GalleryItem {
  final String title;
  final String imagePath;
  final Color color;

  const GalleryItem({
    required this.title,
    required this.imagePath,
    required this.color,
  });
}

const List<String> _imagePaths = [
  'assets/images/9.png',
  'assets/images/10.png',
  'assets/images/11.png',
  'assets/images/12.png',
  'assets/images/15.png',
  'assets/images/16.png',
  'assets/images/17.png',
  'assets/images/18.png',
  'assets/images/19.png',
  'assets/images/20.png',
  'assets/images/21.png',
  'assets/images/22.png',
];

const List<Color> _pastelColors = [
  Color(0xFFFFE5EC),
  Color(0xFFE8F0FE),
  Color(0xFFEAFBF0),
  Color(0xFFFFF1DB),
  Color(0xFFF3E8FF),
  Color(0xFFFFF7CC),
  Color(0xFFDFF7F2),
  Color(0xFFFFEBDC),
  Color(0xFFEDE7F6),
  Color(0xFFE3F2FD),
  Color(0xFFFCE4EC),
  Color(0xFFE8F5E9),
];