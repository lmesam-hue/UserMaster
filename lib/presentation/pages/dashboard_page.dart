import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/app_colors.dart';
import '../blocs/auth/auth_cubit.dart';
import '../blocs/auth/auth_state.dart';
import '../widgets/recent_item_card.dart';
import 'profile_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [_HomeTab(), ProfilePage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        onTap: (index) => setState(() => _index = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  static const List<_RecentItem> _items = [
    _RecentItem(Icons.notifications_active, 'Nueva notificación',
        'Tienes una notificación sin leer', AppColors.primary),
    _RecentItem(Icons.task_alt, 'Tarea pendiente',
        'Completa el taller de Flutter', AppColors.success),
    _RecentItem(Icons.mail_outline, 'Mensaje recibido',
        'Tu instructor respondió tu consulta', AppColors.secondary),
    _RecentItem(Icons.alarm, 'Recordatorio',
        'Entrega del proyecto: hoy 11:59 p.m.', Colors.orange),
    _RecentItem(Icons.system_update, 'Actualización disponible',
        'Nueva versión de UserMaster', Colors.blue),
    _RecentItem(Icons.bar_chart, 'Informe semanal',
        'Revisa tu resumen de actividad', Colors.teal),
  ];

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthCubit>().state;
    final name = state is AuthAuthenticated ? state.user.name : 'Usuario';

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Hola, $name',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Estos son tus elementos recientes',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 20),
          ..._items.map(
            (item) => RecentItemCard(
              icon: item.icon,
              title: item.title,
              subtitle: item.subtitle,
              color: item.color,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _RecentItem(this.icon, this.title, this.subtitle, this.color);
}