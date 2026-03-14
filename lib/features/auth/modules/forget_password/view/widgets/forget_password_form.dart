import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/features/auth/modules/forget_password/controller/cubit/forget_password_cubit.dart';
import 'package:yt_ecommerce_admin_panel/core/routes/app_routes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/sizes.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/constants/text_strings.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/popups/loaders.dart';
import 'package:yt_ecommerce_admin_panel/core/utils/validators/validation.dart';

class TForgetPasswordForm extends StatelessWidget {
  const TForgetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPasswordCubit>();

    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == ForgetPasswordStatus.success) {
          Navigator.pushNamed(context, AppRoutes.resetPassword,
              arguments: cubit.emailController.text.trim());
        } else if (state.status == ForgetPasswordStatus.error) {
          AppLoaders.errorSnackBar(
            title: 'Oh Snap!',
            message: state.error,
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
                const SizedBox(height: TSizes.spaceBtwSections),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.status == ForgetPasswordStatus.loading
                        ? null
                        : () => cubit.sendPasswordResetEmail(),
                    child: state.status == ForgetPasswordStatus.loading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : const Text(TTexts.submit),
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
