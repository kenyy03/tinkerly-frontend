import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_frontend/src/features/home/components/ad_space.dart';
import 'package:mobile_frontend/src/features/home/components/popular_packs.dart';
import 'package:mobile_frontend/src/features/home/cubit/home_cubit.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo-tinkerly-rounded.png',
                    height: 32,
                  ),
                  SizedBox(width: AppDefaults.margin - 10),
                  Text(
                    'TINKERLY',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: AdSpace(
                key: Key('1'),
                title: 'Colabora \r\ncon \r\notros',
                imageUrl: 'https://images.pexels.com/photos/3184416/pexels-photo-3184416.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              ),
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return SliverToBoxAdapter(
                  child: PopularPacks(usersData: state.usersHome),
                );
              },
            ),
            // SizedBox(height: AppDefaults.margin),
            SliverToBoxAdapter(
              child: AdSpace(
                key: Key('2'),
                title: 'No pierdas\r\n ninguna \r\noportunidad',
                imageUrl: 'https://images.pexels.com/photos/2381463/pexels-photo-2381463.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
