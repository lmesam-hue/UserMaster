import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/core/utils/validators.dart';

void main() {
  group('Validators.email', () {
    test('rechaza vacío', () => expect(Validators.email(''), isNotNull));
    test('rechaza formato inválido',
        () => expect(Validators.email('correo'), isNotNull));
    test('acepta correo válido',
        () => expect(Validators.email('demo@usermaster.com'), isNull));
  });

  group('Validators.password', () {
    test('rechaza contraseña corta',
        () => expect(Validators.password('123'), isNotNull));
    test('acepta 6 o más caracteres',
        () => expect(Validators.password('123456'), isNull));
  });

  group('Validators.confirmPassword', () {
    test('rechaza contraseñas distintas', () => expect(
        Validators.confirmPassword('abcdef', '123456'), isNotNull));
    test('acepta contraseñas iguales',
        () => expect(Validators.confirmPassword('123456', '123456'), isNull));
  });
}