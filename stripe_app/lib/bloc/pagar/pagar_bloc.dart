import 'package:bloc/bloc.dart';
import 'package:stripe_app/models/tarjeta_credito.dart';

part 'pagar_event.dart';
part 'pagar_state.dart';

class PagarBloc extends Bloc<PagarEvent, PagarState> {
  PagarBloc() : super(PagarState()) {
    on<OnSeleccionarTarjeta>(
      (event, emit) => emit(
        state.copyWith(
          tarjetaActiva: true,
          tarjeta: event.tarjeta,
        ),
      ),
    );

    on<OnDesactivarTarjeta>(
      (event, emit) => emit(
        state.copyWith(
          tarjetaActiva: false,
          tarjeta: null,
        ),
      ),
    );
  }
}
