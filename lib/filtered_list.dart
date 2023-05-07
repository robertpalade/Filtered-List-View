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

  List<User> get filteredUsers {
    List<User> filteredUsers = users;
    if (_hasBioFilter) {
      filteredUsers = filteredUsers.where((user) => user.bio != null).toList();
    }
    if (_searchQuery.isNotEmpty) {
      filteredUsers = filteredUsers.where((user) {
        final nameLower = user.name.toLowerCase();
        final searchLower = _searchQuery.toLowerCase();
        return nameLower.contains(searchLower);
      }).toList();
    }
    return filteredUsers;
  }

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                prefixIcon: Icon(Icons.search),
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
            buildUserList(Reaction.thumbsUp),
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
            buildUserList(Reaction.thumbsDown),
          ],
        ),
      ),
    );
  }

  Widget buildUserList(Reaction reaction) {
    return Column(
        children: filteredUsers.map(
      (user) {
        if (user.reaction == reaction) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('https://api.multiavatar.com/${user.name.replaceAll(' ', '%20')}.png'),
            ),
            title: Text(user.name),
            subtitle: user.bio != null ? Text(user.bio!) : null,
          );
        } else {
          return SizedBox.shrink();
        }
      },
    ).toList());
  }

  String takeInitials(String data) {
    RegExp initialsRegex = RegExp(r"(?<=^|\s)[a-zA-Z]");
    return initialsRegex
        .allMatches(data)
        .map((match) => match.group(0)!.toUpperCase())
        .join('');
  }
}
