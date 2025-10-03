import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'di.config.dart';

final sl = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies({String? env}) async =>
    sl.init(environment: env);


