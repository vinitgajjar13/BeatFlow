import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) => Divider(height: 1, color: Theme.of(context).dividerColor.withValues(alpha: 0.1)),
        itemBuilder: (context, index) {
          return _buildNotificationItem(context, index);
        },
      ),
    );
  }

  Widget _buildNotificationItem(BuildContext context, int index) {
    final titles = [
      'New Album Alert!',
      'Playlist Update',
      'Artist Milestones',
      'Recommended for you',
      'Live Event Near You',
      'Weekly Discovery',
      'Account Security',
      'Subscription Renewed',
      'Friend Activity',
      'Trending Now'
    ];

    final subtitles = [
       'Arctic Monkeys just released a new single "The Car".',
       'Your "Midnight Vibes" playlist has been updated with 5 new tracks.',
       'The Weeknd reached 100 million monthly listeners!',
       'Based on your listening history, we think you\'ll like "The Midnight".',
       'Glass Animals is performing in your city next month!',
       'Your new Weekly Discovery is ready. 30 fresh tracks just for you.',
       'A new login was detected on a Windows device.',
       'Your Premium subscription has been successfully renewed. Enjoy ad-free music!',
       'Your friend John started listening to your shared playlist.',
       'Synthwave is trending in your area. Check out the top 50 tracks.'
    ];

    final times = [
      '2m ago', '15m ago', '1h ago', '3h ago', '5h ago', '12h ago', '1d ago', '2d ago', '3d ago', '1w ago'
    ];

    final icons = [
      Icons.album_rounded, Icons.playlist_add_check_rounded, Icons.star_rounded, Icons.music_note_rounded, Icons.event_rounded, 
      Icons.explore_rounded, Icons.security_rounded, Icons.payment_rounded, Icons.people_rounded, Icons.trending_up_rounded
    ];

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).cardColor,
        child: Icon(icons[index % icons.length], color: AppTheme.primaryColor, size: 20),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(titles[index % titles.length], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
          Text(times[index % times.length], style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10)),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          subtitles[index % subtitles.length],
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      onTap: () {},
    );
  }
}

