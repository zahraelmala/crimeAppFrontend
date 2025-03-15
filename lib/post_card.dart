import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final int index;
  final VoidCallback onDelete;

  const PostCard({Key? key, required this.index, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar.png'),
                  onBackgroundImageError: (exception, stackTrace) {
                    debugPrint('Image load error: $exception');
                  },
                ),
                title: Text('Rodina Ahmed', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Sidi Gaber - Alexandria', style: TextStyle(color: Colors.red)),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red, size: 20),
                  onPressed: onDelete,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Lorem ipsum dolor sit amet consectetur. Amet purus tristique libero in fames fermentum a arcu at. Dolor scelerisque see more',
                  style: TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Image Placeholder',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.thumb_up, color: Colors.black, size: 20),
                          SizedBox(width: 5),
                          Text('Like', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.comment, color: Colors.black, size: 20),
                          SizedBox(width: 5),
                          Text('Comment', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
