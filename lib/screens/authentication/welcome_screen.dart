import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/screens/authentication/sign_in_screen.dart';
import 'package:instax/screens/authentication/sign_up_screen.dart';

import '../../blocs/authentication_bloc/authentication_bloc.dart';
import '../../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../../blocs/sign_up_bloc/sign_up_bloc.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
	late TabController tabController;

	@override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			backgroundColor: Theme.of(context).colorScheme.background,
			appBar: AppBar(
				elevation: 0,
				backgroundColor: Colors.transparent,
			),
			body: SingleChildScrollView(
				child: SizedBox(
					height: MediaQuery.of(context).size.height,
					child: Padding(
						padding: const EdgeInsets.symmetric(horizontal: 20),
						child: Column(
							children: [
								const Text(
									'Welcome Back !',
									style: TextStyle(
										fontSize: 24,
										fontWeight: FontWeight.bold
									),
								),
								const SizedBox(height: kToolbarHeight),
								TabBar(
									controller: tabController,
									unselectedLabelColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
									labelColor: Theme.of(context).colorScheme.onBackground,
									tabs: const [
										Padding(
											padding: EdgeInsets.all(12.0),
											child: Text(
												'Sign In',
												style: TextStyle(
													fontSize: 18,
												),
											),
										),
										Padding(
											padding: EdgeInsets.all(12.0),
											child: Text(
												'Sign Up',
												style: TextStyle(
													fontSize: 18,
												),
											),
										),
									]
								),
								Expanded(
									child: TabBarView(
										controller: tabController,
										children: [
											BlocProvider<SignInBloc>(
												create: (context) => SignInBloc(
													userRepository: context.read<AuthenticationBloc>().userRepository
												),
												child: const SignInScreen(),
											),
											BlocProvider<SignUpBloc>(
												create: (context) => SignUpBloc(
													userRepository: context.read<AuthenticationBloc>().userRepository
												),
												child: const SignUpScreen(),
											),
										]
									),
								)
							],
						),
					),
				),
			),
		);
  }
}