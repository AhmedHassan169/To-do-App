// فانكشن عشان اعمل التاريخ يعمل update عندى ف كل مكان

DateTime dateOnly (DateTime inputDateTime){
 return DateTime(inputDateTime.year, inputDateTime.month, inputDateTime.day);

}