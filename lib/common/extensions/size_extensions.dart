import 'package:miusu/common/screenutil/screen_util.dart';

extension SizeExtensions on num{
  double get w => ScreenUtil().setWidth(this).toDouble();
  double get h => ScreenUtil().setHeight(this).toDouble();
  num get sp => ScreenUtil().setSp(this);
}