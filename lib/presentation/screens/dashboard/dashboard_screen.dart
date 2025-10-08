import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../providers/posts_provider.dart';
import '../../widgets/app_navigation_bar.dart';

/// Dashboard screen showing posts distribution chart
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch posts if not already loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<PostsProvider>();
      if (provider.posts.isEmpty && !provider.isLoading) {
        provider.fetchPosts();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          const AppNavigationBar(currentRoute: '/'),
          Expanded(
            child: Consumer<PostsProvider>(
              builder: (context, provider, child) {
                if (provider.isLoading) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(strokeWidth: 3),
                        const SizedBox(height: 24),
                        Text(
                          'Loading posts data...',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (provider.error != null) {
                  return Center(
                    child: Card(
                      margin: const EdgeInsets.all(24),
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.cloud_off_outlined,
                              size: 64,
                              color: Colors.red[300],
                            ),
                            const SizedBox(height: 24),
                            const Text(
                              'Connection Error',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Unable to load posts data',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton.icon(
                              onPressed: () => provider.fetchPosts(),
                              icon: const Icon(Icons.refresh),
                              label: const Text('Try Again'),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }

                if (provider.posts.isEmpty) {
                  return const Center(
                    child: Text(
                      'No posts available',
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }

                final userPostCounts = provider.getPostsCountByUser();
                final screenWidth = MediaQuery.of(context).size.width;
                final isMobile = screenWidth < 600;
                final isTablet = screenWidth >= 600 && screenWidth < 1024;

                return SingleChildScrollView(
                  padding: EdgeInsets.all(isMobile ? 16 : 24),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header Section
                          isMobile
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        Icons.analytics_outlined,
                                        size: 28,
                                        color: Colors.blue[700],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      'Analytics Dashboard',
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Overview of posts distribution',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Icon(
                                        Icons.analytics_outlined,
                                        size: 32,
                                        color: Colors.blue[700],
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Analytics Dashboard',
                                            style: TextStyle(
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Overview of posts distribution across users',
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                          const SizedBox(height: 32),

                          // Stats Cards - Responsive layout
                          isMobile
                              ? Column(
                                  children: [
                                    _buildStatCard(
                                      context,
                                      'Total Posts',
                                      provider.posts.length.toString(),
                                      Icons.article_outlined,
                                      Colors.blue,
                                    ),
                                    const SizedBox(height: 12),
                                    _buildStatCard(
                                      context,
                                      'Total Users',
                                      userPostCounts.length.toString(),
                                      Icons.people_outline,
                                      Colors.green,
                                    ),
                                    const SizedBox(height: 12),
                                    _buildStatCard(
                                      context,
                                      'Avg per User',
                                      (provider.posts.length /
                                              userPostCounts.length)
                                          .toStringAsFixed(1),
                                      Icons.trending_up,
                                      Colors.orange,
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      child: _buildStatCard(
                                        context,
                                        'Total Posts',
                                        provider.posts.length.toString(),
                                        Icons.article_outlined,
                                        Colors.blue,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: _buildStatCard(
                                        context,
                                        'Total Users',
                                        userPostCounts.length.toString(),
                                        Icons.people_outline,
                                        Colors.green,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: _buildStatCard(
                                        context,
                                        'Avg per User',
                                        (provider.posts.length /
                                                userPostCounts.length)
                                            .toStringAsFixed(1),
                                        Icons.trending_up,
                                        Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                          const SizedBox(height: 32),

                          // Chart Card
                          Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(isMobile ? 16 : 24),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Posts Distribution by User',
                                    style: TextStyle(
                                      fontSize: isMobile ? 18 : 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Number of posts created by each user',
                                    style: TextStyle(
                                      fontSize: isMobile ? 13 : 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  SizedBox(height: isMobile ? 24 : 32),
                                  SizedBox(
                                    height: isMobile
                                        ? 300
                                        : (isTablet ? 350 : 400),
                                    child: BarChart(
                                      BarChartData(
                                        alignment:
                                            BarChartAlignment.spaceAround,
                                        maxY:
                                            (userPostCounts.values.reduce(
                                                      (a, b) => a > b ? a : b,
                                                    ) +
                                                    2)
                                                .toDouble(),
                                        barTouchData: BarTouchData(
                                          enabled: true,
                                          touchTooltipData: BarTouchTooltipData(
                                            getTooltipItem:
                                                (
                                                  group,
                                                  groupIndex,
                                                  rod,
                                                  rodIndex,
                                                ) {
                                                  final userId = group.x + 1;
                                                  return BarTooltipItem(
                                                    'User $userId\n${rod.toY.toInt()} posts',
                                                    const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  );
                                                },
                                          ),
                                        ),
                                        titlesData: FlTitlesData(
                                          show: true,
                                          bottomTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              getTitlesWidget: (value, meta) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        top: 8,
                                                      ),
                                                  child: Text(
                                                    isMobile
                                                        ? '${value.toInt() + 1}'
                                                        : 'User ${value.toInt() + 1}',
                                                    style: TextStyle(
                                                      fontSize: isMobile
                                                          ? 10
                                                          : 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            axisNameWidget: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 16,
                                              ),
                                              child: Text(
                                                'User ID',
                                                style: TextStyle(
                                                  fontSize: isMobile ? 12 : 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          leftTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              reservedSize: isMobile ? 30 : 40,
                                              getTitlesWidget: (value, meta) {
                                                return Text(
                                                  value.toInt().toString(),
                                                  style: TextStyle(
                                                    fontSize: isMobile
                                                        ? 10
                                                        : 12,
                                                  ),
                                                );
                                              },
                                            ),
                                            axisNameWidget: Padding(
                                              padding: EdgeInsets.only(
                                                right: isMobile ? 8 : 16,
                                              ),
                                              child: Text(
                                                isMobile
                                                    ? 'Posts'
                                                    : 'Number of Posts',
                                                style: TextStyle(
                                                  fontSize: isMobile ? 11 : 14,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          topTitles: const AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: false,
                                            ),
                                          ),
                                          rightTitles: const AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: false,
                                            ),
                                          ),
                                        ),
                                        gridData: FlGridData(
                                          show: true,
                                          drawVerticalLine: false,
                                          horizontalInterval: 1,
                                        ),
                                        borderData: FlBorderData(
                                          show: true,
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey[300]!,
                                            ),
                                            left: BorderSide(
                                              color: Colors.grey[300]!,
                                            ),
                                          ),
                                        ),
                                        barGroups: userPostCounts.entries.map((
                                          entry,
                                        ) {
                                          return BarChartGroupData(
                                            x: entry.key - 1,
                                            barRods: [
                                              BarChartRodData(
                                                toY: entry.value.toDouble(),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.blue.shade400,
                                                    Colors.blue.shade700,
                                                  ],
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                ),
                                                width: isMobile
                                                    ? 16
                                                    : (isTablet ? 22 : 28),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                      topLeft: Radius.circular(
                                                        8,
                                                      ),
                                                      topRight: Radius.circular(
                                                        8,
                                                      ),
                                                    ),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
