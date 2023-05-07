import 'package:flutter/material.dart';

import 'data/data.dart';
import 'dto/reaction.dart';
import 'dto/user.dart';

class FilteredList extends StatefulWidget {
  const FilteredList({super.key});

  @override
  State<FilteredList> createState() => _FilteredListState();
}

class _FilteredListState extends State<FilteredList> {
  bool onlyShowPeopleWithBio = false;
  bool _hasBioFilter = false;
  Reaction? _selectedReaction;

  String takeInitials(String data) {
    RegExp initialsRegex = RegExp(r"(?<=^|\s)[a-zA-Z]");
    return initialsRegex
        .allMatches(data)
        .map((match) => match.group(0)!.toUpperCase())
        .join('');
  }

  List<User> get _filteredUsers {
    List<User> filteredUsers = users;
    if (_selectedReaction != null) {
      filteredUsers = filteredUsers
          .where((user) => user.reaction == _selectedReaction)
          .toList();
    }
    if (_hasBioFilter) {
      filteredUsers =
          filteredUsers.where((user) => user.bio.isNotEmpty).toList();
    }
    return filteredUsers;
  }

  String _searchQuery = '';

  Expanded _buildUserList(Reaction reaction) {
    return Expanded(
      child: ListView.builder(
        itemCount: _filteredUsers.length,
        itemBuilder: (context, index) {
          final user = _filteredUsers[index];
          if (user.reaction == reaction) {
            return ListTile(
              leading: CircleAvatar(
                child: Text(takeInitials(user.name)),
              ),
              title: Text(user.name),
              subtitle: user.bio != null ? Text(user.bio!) : Text(""),
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: _hasBioFilter,
                  onChanged: (value) {
                    setState(() {
                      _hasBioFilter = value!;
                    });
                  },
                ),
                SizedBox(width: 8),
                Text('Only show people with bio'),
              ],
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Reacted with "),
                  Icon(Icons.thumb_up),
                  Text(":"),
                ],
              ),
            ),
            _buildUserList(Reaction.thumbsUp),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Reacted with "),
                  Icon(Icons.thumb_down),
                  Text(":"),
                ],
              ),
            ),
            _buildUserList(Reaction.thumbsDown),
          ],
        ),
      ),
    );
  }
}