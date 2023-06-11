import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../feautures/app_lang/lang_cubit/lang_cubit.dart';
import '../../feautures/app_lang/lang_cubit/lang_states.dart';
import '../../feautures/quran/cubit/surahs_cubit.dart';
import '../colors/my_colors.dart';
import '../helpers/helper_methods.dart';
import '../router/app_router.dart';
import '../router/router_path.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppLanguageCubit()..getAppLanguage(),),
        BlocProvider(create: (context) => QuranCubit()..loadSurahList(),),

      ],
      child: BlocBuilder<AppLanguageCubit, AppLanguageState>(
        builder: (context, state) {
          if (state is! AppChangeLanguage) {
            return const SizedBox();
          }
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: ()=>closeKeyBoard(),
            child: MaterialApp(
              theme: ThemeData(
                primaryColor: MyColors.primaryColor,
                appBarTheme: const AppBarTheme(
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: MyColors.primaryColor,
                    )
                )
              ),
              debugShowCheckedModeBanner: false,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              title: 'مسلم',
              locale: Locale(state.locale),
              onGenerateRoute: AppRouter.onGenerateRoutes,
              initialRoute: RoutePaths.root,
            ),
          );
        },
      ),
    );
  }
}