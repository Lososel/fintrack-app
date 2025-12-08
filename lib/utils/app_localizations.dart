import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // Translation maps
  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'settings': 'Settings',
      'manageYourPreferences': 'Manage your preferences',
      'profile': 'Profile',
      'currencyConverter': 'Currency Converter',
      'notifications': 'Notifications',
      'language': 'Language',
      'theme': 'Theme',
      'helpAndFAQ': 'Help and FAQ',
      'privacyPolicy': 'Privacy Policy',
      'about': 'About',
      'version': 'Version 1.0.0',
      'goodMorning': 'Good morning',
      'goodAfternoon': 'Good afternoon',
      'goodEvening': 'Good evening',
      'goodNight': 'Good night',
      'yourPersonalFinanceManager': 'your personal finance manager',
      'home': 'Home',
      'analytics': 'Analytics',
      'budget': 'Budget',
      'settings': 'Settings',
      'totalBalance': 'Total balance',
      'addNewCard': 'Add new card',
      'manageCards': 'Manage cards',
      'editProfile': 'Edit Profile',
      'logout': 'Logout',
      'saveChanges': 'Save Changes',
      'cancel': 'Cancel',
      'cardAccountName': 'Card/Account name',
      'last4Digits': 'Last 4 digits',
      'accountType': 'Account Type',
      'currentBalance': 'Current balance',
      'primaryPurpose': 'Primary purpose',
      'debitCard': 'Debit Card',
      'creditCard': 'Credit Card',
      'savingsAccount': 'Savings Account',
      'currentExchangeRate': 'Current exchange rate',
      'from': 'From',
      'to': 'To',
      'conversionDetails': 'Conversion details',
      'youSend': 'You send',
      'theyReceive': 'They receive',
      'exchangeRate': 'Exchange rate',
      'income': 'Income',
      'expense': 'Expense',
      'addTransaction': 'Add Transaction',
      'viewAll': 'View all',
      'spendingOverview': 'Spending Overview',
      'monthlyComparison': 'Monthly Comparison',
      'recentTransactions': 'Recent Transactions',
      'noExpensesYet': 'No expenses yet',
      'noTransactionsYet': 'No transactions yet',
      'viewDetails': 'View Details',
      'incomeExpenseTrend': 'Income & Expense Trend',
      'expensesBreakdown': 'Expenses Breakdown',
      'user': 'User',
      'analytics': 'Analytics',
      'trackYourFinancialInsights': 'Track your financial insights',
      'totalSavings': 'Total Savings',
      'day': 'Day',
      'week': 'Week',
      'month': 'Month',
      'year': 'Year',
      'login': 'Login',
      'manageYourMoneyWisely': 'Manage your money wisely',
      'emailAddress': 'Email address',
      'password': 'Password',
      'pleaseEnterEmailAndPassword': 'Please enter email and password',
      'createAccount': 'Create account',
      'createAnAccount': 'Create an account',
      'fullName': 'Full name',
      'alreadyHaveAnAccount': 'Already have an account?',
      'cardAccountNameRequired': 'Card / Account name *',
      'egKaspiGold': 'e.g Kaspi Gold',
      'last4DigitsRequired': 'Last 4 digits *',
      'eg1234': 'e.g 1234',
      'accountTypeRequired': 'Account Type *',
      'debit': 'Debit',
      'credit': 'Credit',
      'savings': 'Savings',
      'checking': 'Checking',
      'currentBalanceRequired': 'Current balance *',
      'primaryPurposeRequired': 'Primary purpose *',
      'egDailySpending': 'e.g Daily spending',
      'cardNameRequired': 'Card name is required',
      'last4DigitsRequiredError': 'Last 4 digits are required',
      'pleaseEnterExactly4Digits': 'Please enter exactly 4 digits',
      'balanceRequired': 'Balance is required',
      'pleaseEnterValidNumber': 'Please enter a valid number',
      'primaryPurposeRequiredError': 'Primary purpose is required',
      'cardAddedSuccessfully': 'Card added successfully',
      'editCard': 'Edit Card',
      'summary': 'Summary',
      'cardAndAccounts': 'Card & Accounts',
      'name': 'Name',
      'email': 'Email',
      'location': 'Location',
      'myCardsAndAccounts': 'My cards & Accounts',
      'acrossCards': 'Across',
      'cards': 'cards',
      'card': 'card',
      'accounts': 'accounts',
      'account': 'account',
      'balance': 'Balance',
      'purpose': 'Purpose',
      'amount': 'Amount',
      'category': 'Category',
      'selectCategory': 'Select category',
      'description': 'Description',
      'enterDescription': 'Enter description',
      'date': 'Date',
      'paymentMethod': 'Payment Method',
      'checkingAccount': 'Checking Account',
      'languageChangedTo': 'Language changed to',
      'cardUpdatedSuccessfully': 'Card updated successfully',
      'areYouSureYouWantToLogout': 'Are you sure you want to logout?',
      'transactions': 'Transactions',
      'selectCurrency': 'Select Currency',
      'selectCategory': 'Select Category',
      'selectPaymentMethod': 'Select Payment Method',
    },
    'ru': {
      'settings': 'Настройки',
      'manageYourPreferences': 'Управляйте своими настройками',
      'profile': 'Профиль',
      'currencyConverter': 'Конвертер валют',
      'notifications': 'Уведомления',
      'language': 'Язык',
      'theme': 'Тема',
      'helpAndFAQ': 'Помощь и FAQ',
      'privacyPolicy': 'Политика конфиденциальности',
      'about': 'О приложении',
      'version': 'Версия 1.0.0',
      'goodMorning': 'Доброе утро',
      'goodAfternoon': 'Добрый день',
      'goodEvening': 'Добрый вечер',
      'goodNight': 'Доброй ночи',
      'yourPersonalFinanceManager': 'ваш личный финансовый менеджер',
      'home': 'Главная',
      'analytics': 'Аналитика',
      'budget': 'Бюджет',
      'settings': 'Настройки',
      'totalBalance': 'Общий баланс',
      'addNewCard': 'Добавить новую карту',
      'manageCards': 'Управление картами',
      'editProfile': 'Редактировать профиль',
      'logout': 'Выйти',
      'saveChanges': 'Сохранить изменения',
      'cancel': 'Отмена',
      'cardAccountName': 'Название карты/счета',
      'last4Digits': 'Последние 4 цифры',
      'accountType': 'Тип счета',
      'currentBalance': 'Текущий баланс',
      'primaryPurpose': 'Основное назначение',
      'debitCard': 'Дебетовая карта',
      'creditCard': 'Кредитная карта',
      'savingsAccount': 'Сберегательный счет',
      'currentExchangeRate': 'Текущий обменный курс',
      'from': 'От',
      'to': 'До',
      'conversionDetails': 'Детали конвертации',
      'youSend': 'Вы отправляете',
      'theyReceive': 'Они получают',
      'exchangeRate': 'Обменный курс',
      'income': 'Доход',
      'expense': 'Расход',
      'addTransaction': 'Добавить транзакцию',
      'viewAll': 'Посмотреть все',
      'spendingOverview': 'Обзор расходов',
      'monthlyComparison': 'Месячное сравнение',
      'recentTransactions': 'Недавние транзакции',
      'noExpensesYet': 'Расходов пока нет',
      'noTransactionsYet': 'Транзакций пока нет',
      'viewDetails': 'Подробнее',
      'incomeExpenseTrend': 'Тренд доходов и расходов',
      'expensesBreakdown': 'Разбивка расходов',
      'user': 'Пользователь',
      'analytics': 'Аналитика',
      'trackYourFinancialInsights': 'Отслеживайте свои финансовые показатели',
      'totalSavings': 'Общие сбережения',
      'day': 'День',
      'week': 'Неделя',
      'month': 'Месяц',
      'year': 'Год',
      'login': 'Войти',
      'manageYourMoneyWisely': 'Управляйте своими деньгами разумно',
      'emailAddress': 'Адрес электронной почты',
      'password': 'Пароль',
      'pleaseEnterEmailAndPassword': 'Пожалуйста, введите email и пароль',
      'createAccount': 'Создать аккаунт',
      'createAnAccount': 'Создать аккаунт',
      'fullName': 'Полное имя',
      'alreadyHaveAnAccount': 'Уже есть аккаунт?',
      'cardAccountNameRequired': 'Название карты / счета *',
      'egKaspiGold': 'например Kaspi Gold',
      'last4DigitsRequired': 'Последние 4 цифры *',
      'eg1234': 'например 1234',
      'accountTypeRequired': 'Тип счета *',
      'debit': 'Дебет',
      'credit': 'Кредит',
      'savings': 'Сбережения',
      'checking': 'Текущий',
      'currentBalanceRequired': 'Текущий баланс *',
      'primaryPurposeRequired': 'Основное назначение *',
      'egDailySpending': 'например Ежедневные расходы',
      'cardNameRequired': 'Название карты обязательно',
      'last4DigitsRequiredError': 'Последние 4 цифры обязательны',
      'pleaseEnterExactly4Digits': 'Пожалуйста, введите ровно 4 цифры',
      'balanceRequired': 'Баланс обязателен',
      'pleaseEnterValidNumber': 'Пожалуйста, введите действительное число',
      'primaryPurposeRequiredError': 'Основное назначение обязательно',
      'cardAddedSuccessfully': 'Карта успешно добавлена',
      'editCard': 'Редактировать карту',
      'summary': 'Сводка',
      'cardAndAccounts': 'Карты и счета',
      'name': 'Имя',
      'email': 'Электронная почта',
      'location': 'Местоположение',
      'myCardsAndAccounts': 'Мои карты и счета',
      'acrossCards': 'По',
      'cards': 'картам',
      'card': 'карте',
      'accounts': 'счетам',
      'account': 'счету',
      'balance': 'Баланс',
      'purpose': 'Назначение',
      'amount': 'Сумма',
      'category': 'Категория',
      'selectCategory': 'Выберите категорию',
      'description': 'Описание',
      'enterDescription': 'Введите описание',
      'date': 'Дата',
      'paymentMethod': 'Способ оплаты',
      'checkingAccount': 'Текущий счет',
      'languageChangedTo': 'Язык изменен на',
      'cardUpdatedSuccessfully': 'Карта успешно обновлена',
      'areYouSureYouWantToLogout': 'Вы уверены, что хотите выйти?',
      'transactions': 'Транзакции',
      'selectCurrency': 'Выберите валюту',
      'selectCategory': 'Выберите категорию',
      'selectPaymentMethod': 'Выберите способ оплаты',
    },
    'kk': {
      'settings': 'Баптаулар',
      'manageYourPreferences': 'Баптауларыңызды басқарыңыз',
      'profile': 'Профиль',
      'currencyConverter': 'Валюта конвертері',
      'notifications': 'Хабарландырулар',
      'language': 'Тіл',
      'theme': 'Тақырып',
      'helpAndFAQ': 'Көмек және FAQ',
      'privacyPolicy': 'Құпиялылық саясаты',
      'about': 'Қолданба туралы',
      'version': 'Нұсқа 1.0.0',
      'goodMorning': 'Қайырлы таң',
      'goodAfternoon': 'Қайырлы күн',
      'goodEvening': 'Қайырлы кеш',
      'goodNight': 'Қайырлы түн',
      'yourPersonalFinanceManager': 'сіздің жеке қаржы менеджеріңіз',
      'home': 'Басты',
      'analytics': 'Аналитика',
      'budget': 'Бюджет',
      'settings': 'Баптаулар',
      'totalBalance': 'Жалпы баланс',
      'addNewCard': 'Жаңа карта қосу',
      'manageCards': 'Карталарды басқару',
      'editProfile': 'Профильді өңдеу',
      'logout': 'Шығу',
      'saveChanges': 'Өзгерістерді сақтау',
      'cancel': 'Болдырмау',
      'cardAccountName': 'Карта/Есеп атауы',
      'last4Digits': 'Соңғы 4 цифр',
      'accountType': 'Есеп түрі',
      'currentBalance': 'Ағымдағы баланс',
      'primaryPurpose': 'Негізгі мақсат',
      'debitCard': 'Дебеттік карта',
      'creditCard': 'Несиелік карта',
      'savingsAccount': 'Жинақтау шоты',
      'currentExchangeRate': 'Ағымдағы айырбас бағамы',
      'from': 'Бастап',
      'to': 'Дейін',
      'conversionDetails': 'Конвертация мәліметтері',
      'youSend': 'Сіз жібересіз',
      'theyReceive': 'Олар алады',
      'exchangeRate': 'Айырбас бағамы',
      'income': 'Кіріс',
      'expense': 'Шығын',
      'addTransaction': 'Транзакция қосу',
      'viewAll': 'Барлығын көру',
      'spendingOverview': 'Шығындарға шолу',
      'monthlyComparison': 'Айлық салыстыру',
      'recentTransactions': 'Соңғы транзакциялар',
      'noExpensesYet': 'Әлі шығындар жоқ',
      'noTransactionsYet': 'Әлі транзакциялар жоқ',
      'viewDetails': 'Толығырақ',
      'incomeExpenseTrend': 'Кіріс пен шығыс тренді',
      'expensesBreakdown': 'Шығындардың бөлінуі',
      'user': 'Пайдаланушы',
      'analytics': 'Аналитика',
      'trackYourFinancialInsights': 'Қаржылық көрсеткіштеріңізді бақылаңыз',
      'totalSavings': 'Жалпы жинақ',
      'day': 'Күн',
      'week': 'Апта',
      'month': 'Ай',
      'year': 'Жыл',
      'login': 'Кіру',
      'manageYourMoneyWisely': 'Ақшаңызды дана басқарыңыз',
      'emailAddress': 'Электрондық пошта мекенжайы',
      'password': 'Құпия сөз',
      'pleaseEnterEmailAndPassword':
          'Электрондық пошта мен құпия сөзді енгізіңіз',
      'createAccount': 'Тіркелгі құру',
      'createAnAccount': 'Тіркелгі құру',
      'fullName': 'Толық аты',
      'alreadyHaveAnAccount': 'Тіркелгіңіз бар ма?',
      'cardAccountNameRequired': 'Карта / Есеп атауы *',
      'egKaspiGold': 'мысалы Kaspi Gold',
      'last4DigitsRequired': 'Соңғы 4 цифр *',
      'eg1234': 'мысалы 1234',
      'accountTypeRequired': 'Есеп түрі *',
      'debit': 'Дебет',
      'credit': 'Несие',
      'savings': 'Жинақтау',
      'checking': 'Ағымдағы',
      'currentBalanceRequired': 'Ағымдағы баланс *',
      'primaryPurposeRequired': 'Негізгі мақсат *',
      'egDailySpending': 'мысалы Күнделікті шығындар',
      'cardNameRequired': 'Карта атауы міндетті',
      'last4DigitsRequiredError': 'Соңғы 4 цифр міндетті',
      'pleaseEnterExactly4Digits': 'Дәл 4 цифр енгізіңіз',
      'balanceRequired': 'Баланс міндетті',
      'pleaseEnterValidNumber': 'Жарамды сан енгізіңіз',
      'primaryPurposeRequiredError': 'Негізгі мақсат міндетті',
      'cardAddedSuccessfully': 'Карта сәтті қосылды',
      'editCard': 'Картаны өңдеу',
      'summary': 'Қорытынды',
      'cardAndAccounts': 'Карталар мен есептер',
      'name': 'Аты',
      'email': 'Электрондық пошта',
      'location': 'Орналасқан жері',
      'myCardsAndAccounts': 'Менің карталарым мен есептерім',
      'acrossCards': 'Бойынша',
      'cards': 'карталар',
      'card': 'карта',
      'accounts': 'есептер',
      'account': 'есеп',
      'balance': 'Баланс',
      'purpose': 'Мақсаты',
      'amount': 'Сома',
      'category': 'Категория',
      'selectCategory': 'Категорияны таңдаңыз',
      'description': 'Сипаттама',
      'enterDescription': 'Сипаттаманы енгізіңіз',
      'date': 'Күні',
      'paymentMethod': 'Төлем әдісі',
      'checkingAccount': 'Ағымдағы есеп',
      'languageChangedTo': 'Тіл өзгертілді',
      'cardUpdatedSuccessfully': 'Карта сәтті жаңартылды',
      'areYouSureYouWantToLogout': 'Шынымен шығуды қалайсыз ба?',
      'transactions': 'Транзакциялар',
      'selectCurrency': 'Валютаны таңдаңыз',
      'selectCategory': 'Категорияны таңдаңыз',
      'selectPaymentMethod': 'Төлем әдісін таңдаңыз',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  // Convenience getters
  String get settings => translate('settings');
  String get manageYourPreferences => translate('manageYourPreferences');
  String get profile => translate('profile');
  String get currencyConverter => translate('currencyConverter');
  String get notifications => translate('notifications');
  String get language => translate('language');
  String get theme => translate('theme');
  String get helpAndFAQ => translate('helpAndFAQ');
  String get privacyPolicy => translate('privacyPolicy');
  String get about => translate('about');
  String get version => translate('version');
  String get goodMorning => translate('goodMorning');
  String get goodAfternoon => translate('goodAfternoon');
  String get goodEvening => translate('goodEvening');
  String get goodNight => translate('goodNight');
  String get yourPersonalFinanceManager =>
      translate('yourPersonalFinanceManager');
  String get home => translate('home');
  String get analytics => translate('analytics');
  String get budget => translate('budget');
  String get totalBalance => translate('totalBalance');
  String get addNewCard => translate('addNewCard');
  String get manageCards => translate('manageCards');
  String get editProfile => translate('editProfile');
  String get logout => translate('logout');
  String get saveChanges => translate('saveChanges');
  String get cancel => translate('cancel');
  String get cardAccountName => translate('cardAccountName');
  String get last4Digits => translate('last4Digits');
  String get accountType => translate('accountType');
  String get currentBalance => translate('currentBalance');
  String get primaryPurpose => translate('primaryPurpose');
  String get debitCard => translate('debitCard');
  String get creditCard => translate('creditCard');
  String get savingsAccount => translate('savingsAccount');
  String get currentExchangeRate => translate('currentExchangeRate');
  String get from => translate('from');
  String get to => translate('to');
  String get conversionDetails => translate('conversionDetails');
  String get youSend => translate('youSend');
  String get theyReceive => translate('theyReceive');
  String get exchangeRate => translate('exchangeRate');
  String get income => translate('income');
  String get expense => translate('expense');
  String get addTransaction => translate('addTransaction');
  String get viewAll => translate('viewAll');
  String get spendingOverview => translate('spendingOverview');
  String get monthlyComparison => translate('monthlyComparison');
  String get recentTransactions => translate('recentTransactions');
  String get noExpensesYet => translate('noExpensesYet');
  String get noTransactionsYet => translate('noTransactionsYet');
  String get viewDetails => translate('viewDetails');
  String get incomeExpenseTrend => translate('incomeExpenseTrend');
  String get expensesBreakdown => translate('expensesBreakdown');
  String get user => translate('user');
  String get trackYourFinancialInsights =>
      translate('trackYourFinancialInsights');
  String get totalSavings => translate('totalSavings');
  String get day => translate('day');
  String get week => translate('week');
  String get month => translate('month');
  String get year => translate('year');
  String get login => translate('login');
  String get manageYourMoneyWisely => translate('manageYourMoneyWisely');
  String get emailAddress => translate('emailAddress');
  String get password => translate('password');
  String get pleaseEnterEmailAndPassword =>
      translate('pleaseEnterEmailAndPassword');
  String get createAccount => translate('createAccount');
  String get createAnAccount => translate('createAnAccount');
  String get fullName => translate('fullName');
  String get alreadyHaveAnAccount => translate('alreadyHaveAnAccount');
  String get cardAccountNameRequired => translate('cardAccountNameRequired');
  String get egKaspiGold => translate('egKaspiGold');
  String get last4DigitsRequired => translate('last4DigitsRequired');
  String get eg1234 => translate('eg1234');
  String get accountTypeRequired => translate('accountTypeRequired');
  String get debit => translate('debit');
  String get credit => translate('credit');
  String get savings => translate('savings');
  String get checking => translate('checking');
  String get currentBalanceRequired => translate('currentBalanceRequired');
  String get primaryPurposeRequired => translate('primaryPurposeRequired');
  String get egDailySpending => translate('egDailySpending');
  String get cardNameRequired => translate('cardNameRequired');
  String get last4DigitsRequiredError => translate('last4DigitsRequiredError');
  String get pleaseEnterExactly4Digits =>
      translate('pleaseEnterExactly4Digits');
  String get balanceRequired => translate('balanceRequired');
  String get pleaseEnterValidNumber => translate('pleaseEnterValidNumber');
  String get primaryPurposeRequiredError =>
      translate('primaryPurposeRequiredError');
  String get cardAddedSuccessfully => translate('cardAddedSuccessfully');
  String get editCard => translate('editCard');
  String get summary => translate('summary');
  String get cardAndAccounts => translate('cardAndAccounts');
  String get name => translate('name');
  String get email => translate('email');
  String get location => translate('location');
  String get myCardsAndAccounts => translate('myCardsAndAccounts');
  String get acrossCards => translate('acrossCards');
  String get cards => translate('cards');
  String get card => translate('card');
  String get accounts => translate('accounts');
  String get account => translate('account');
  String get balance => translate('balance');
  String get purpose => translate('purpose');
  String get amount => translate('amount');
  String get category => translate('category');
  String get selectCategory => translate('selectCategory');
  String get description => translate('description');
  String get enterDescription => translate('enterDescription');
  String get date => translate('date');
  String get paymentMethod => translate('paymentMethod');
  String get checkingAccount => translate('checkingAccount');
  String get languageChangedTo => translate('languageChangedTo');
  String get cardUpdatedSuccessfully => translate('cardUpdatedSuccessfully');
  String get areYouSureYouWantToLogout =>
      translate('areYouSureYouWantToLogout');
  String get transactions => translate('transactions');
  String get selectCurrency => translate('selectCurrency');
  String get selectPaymentMethod => translate('selectPaymentMethod');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ru', 'kk'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
