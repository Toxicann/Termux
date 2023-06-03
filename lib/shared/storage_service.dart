import 'package:get_storage/get_storage.dart';
import 'package:portfolio/shared/colors.dart';

class StorageService {
  static final box = GetStorage();

  static setUserTheme(String theme) {
    box.write('theme', theme);
    print(box.read('theme'));
  }

  static get getUserTheme => box.read('theme');
}
