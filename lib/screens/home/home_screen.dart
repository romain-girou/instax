import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instax/blocs/sign_in_bloc/sign_in_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			backgroundColor: Theme.of(context).colorScheme.background,
			floatingActionButton: FloatingActionButton(
				onPressed: () {},
				child: const Icon(
					CupertinoIcons.add
				),
			),
			appBar: AppBar(
				centerTitle: false,
				elevation: 0,
				backgroundColor: Theme.of(context).colorScheme.background,
				title: Row(
					children: [
						Container(
							width: 50,
							height: 50,
							decoration: const BoxDecoration(
								color: Colors.blue,
								shape: BoxShape.circle
							),
						),
						const SizedBox(width: 10),
						const Text(
							"Welcome Rom"
						)
					],
				),
				actions: [
					IconButton(
						onPressed: () {
							context.read<SignInBloc>().add(const SignOutRequired());
						}, 
						icon: Icon(
							CupertinoIcons.square_arrow_right,
							color: Theme.of(context).colorScheme.onSecondary,
						)
					)
				],
			),
			body: ListView.builder(
				itemCount: 8,
				itemBuilder: (context, int i) {
					return Padding(
						padding: const EdgeInsets.all(8.0),
						child: Container(
							width: double.infinity,
							// height: 400,
							// color: Colors.blue,
							child: Padding(
								padding: const EdgeInsets.all(8.0),
								child: Column(
									children: [
										Row(
											children: [
												Container(
													width: 50,
													height: 50,
													decoration: const BoxDecoration(
														color: Colors.red,
														shape: BoxShape.circle
													),
												),
												const SizedBox(width: 10,),
												const Column(
													crossAxisAlignment: CrossAxisAlignment.start,
													children: [
														Text(
															"Rom",
															style: TextStyle(
																fontWeight: FontWeight.bold,
																fontSize: 18
															),
														),
														SizedBox(height: 5),
														Text(
															"2023-04-12"
														)
													],
												)
											],
										),
										const SizedBox(height: 10),
										Container(
											// color: Colors.amber,
											child: const Text(
												"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam ac quam feugiat, efficitur ligula et, tincidunt metus. Donec vel dictum quam. In quis orci non metus aliquam fermentum a a lorem. Vivamus vestibulum ante risus, quis mattis nibh vulputate in. Ut tincidunt felis vitae cursus lobortis. Pellentesque convallis mauris vel."
											),
										)
									],
								),
							),
						),
					);
				}
			),
		);
  }
}