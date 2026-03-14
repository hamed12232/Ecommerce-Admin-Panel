import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/modules/login/controller/cubit/login_cubit.dart';
import 'package:yt_ecommerce_admin_panel/routes/app_routes.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/utils/constants/text_strings.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/full_screen_loader.dart';
import 'package:yt_ecommerce_admin_panel/utils/popups/loaders.dart';
import 'package:yt_ecommerce_admin_panel/utils/validators/validation.dart';

class TLoginForm extends StatelessWidget {
  const TLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return BlocConsumer<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == LoginStatus.error) {
          TFullScreenLoader.stopLoading(context);
          AppLoaders.errorSnackBar(
            title: 'Oh Snap!',
            message: state.error,
            context: context,
          );
        } else if (state.status == LoginStatus.loading) {
          TFullScreenLoader.openLoadingDialog(
              'Loading', TImages.docerAnimation, context);
        } else if (state.status == LoginStatus.success) {
          TFullScreenLoader.stopLoading(context);
          AppLoaders.successSnackBar(
            title: 'Success!',
            message: 'Login successful',
            context: context,
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: cubit.formKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
            child: Column(
              children: [
                TextFormField(
                  controller: cubit.emailController,
                  validator: TValidator.validateEmail,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.direct_right),
                    labelText: TTexts.email,
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                TextFormField(
                  controller: cubit.passwordController,
                  validator: (value) => TValidator.validatePassword(value),
                  obscureText: !state.isPasswordVisible,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Iconsax.password_check),
                    labelText: TTexts.password,
                    suffixIcon: IconButton(
                      onPressed: () => cubit.togglePasswordVisibility(),
                      icon: Icon(
                        state.isPasswordVisible
                            ? Iconsax.eye
                            : Iconsax.eye_slash,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: state.isRememberMe,
                          onChanged: (value) => cubit.toggleRememberMe(),
                        ),
                        const Text(TTexts.rememberMe),
                      ],
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context)
                          .pushNamed(AppRoutes.forgetPassword),
                      child: const Text(TTexts.forgetPassword),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => cubit.login(),
                    child: const Text(TTexts.signIn),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
