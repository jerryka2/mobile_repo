import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/term_bloc/term_event.dart';
import 'package:sprint4_fix/features/home/presentation/view_model/term_bloc/term_state.dart';

class TermsBloc extends Bloc<TermsEvent, TermsState> {
  TermsBloc() : super(TermsInitial()) {
    on<LoadTermsData>(_onLoadTermsData);
  }

  void _onLoadTermsData(LoadTermsData event, Emitter<TermsState> emit) {
    // Emit the TermsLoaded state with static terms and conditions without asterisks
    emit(TermsLoaded(
      terms: '''
1. Acceptance of Terms: By using Prescripto, you agree to these Terms and Conditions, our Privacy Policy, and any additional terms applicable to specific services.

2. Service Usage: Prescripto provides EV charging spot reservations. You are responsible for all activity under your account.

3. Account Security: You must keep your account credentials secure. Prescripto is not liable for unauthorized access due to negligence.

4. Payment Terms: Charges for reservations are outlined during booking. All payments are non-refundable unless otherwise stated.

5. Liability: Prescripto is not responsible for delays or issues with charging stations beyond our control.

6. Termination: We may terminate or suspend your account for violation of these terms.

7. Contact: For questions, contact support@prescripto.com.

Last updated: March 04, 2025.
      ''',
    ));
  }
}
