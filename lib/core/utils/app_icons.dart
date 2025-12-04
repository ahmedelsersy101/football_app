import 'package:flutter/material.dart';

/// Centralized icon system for the weekly dashboard app
class AppIcons {
  // Private constructor to prevent instantiation
  AppIcons._();

  // Icon sizes
  static const double size8 = 8;
  static const double size12 = 12;
  static const double size16 = 16;
  static const double size20 = 20;
  static const double size24 = 24;
  static const double size28 = 28;
  static const double size32 = 32;
  static const double size40 = 40;
  static const double size48 = 48;

  // Priority Icons - distinct shapes for better readability
  static const IconData priorityLow = Icons.keyboard_arrow_down;
  static const IconData priorityMedium = Icons.remove;
  static const IconData priorityHigh = Icons.priority_high;
  static const IconData priorityUrgent = Icons.warning;

  // Navigation Icons
  static const IconData dashboard = Icons.dashboard;
  static const IconData home = Icons.home;
  static const IconData settings = Icons.settings;
  static const IconData more = Icons.more_horiz;

  // Task Icons
  static const IconData task = Icons.task_alt;
  static const IconData addTask = Icons.add;
  static const IconData deleteTask = Icons.delete;
  static const IconData editTask = Icons.edit;
  static const IconData completeTask = Icons.check_circle;
  static const IconData incompleteTask = Icons.radio_button_unchecked;

  // Calendar Icons
  static const IconData calendar = Icons.calendar_today;
  static const IconData date = Icons.date_range;
  static const IconData time = Icons.access_time;
  static const IconData reminder = Icons.notifications;

  // Category Icons
  static const IconData work = Icons.work;
  static const IconData study = Icons.school;
  static const IconData health = Icons.favorite;
  static const IconData personal = Icons.person;
  static const IconData finance = Icons.attach_money;
  static const IconData homeCategory = Icons.home;
  static const IconData other = Icons.category;

  // Action Icons
  static const IconData save = Icons.save;
  static const IconData cancel = Icons.cancel;
  static const IconData clear = Icons.clear;
  static const IconData expand = Icons.expand_more;
  static const IconData collapse = Icons.expand_less;

  // Theme Icons
  static const IconData lightMode = Icons.light_mode;
  static const IconData darkMode = Icons.dark_mode;
  static const IconData autoMode = Icons.brightness_auto;
}
