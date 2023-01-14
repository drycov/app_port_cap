import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocaleString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        //ENGLISH LANGUAGE
        'en': {
// lang
          'base.app.title': 'Network Capacity',
          'lang.localeCode': 'en',
          'lang.localeFlag': '🇺🇸',
          'lang.localeName': 'English',
          'lang.changelang': 'Change Language',
          'lang.choseLangTitle': 'Choose Your Language',
          'func.cancel': 'Cancel',
          'func.submit': 'Submit',

//form login
          'form.remember': 'Remember Me',
          'functions.QRscanner': 'QR Scanner',
          'auth.signIn.label': 'Sign In',
          'auth.email.label': 'Email',
          'auth.password.label': 'Password',
// update profile
          'account.update': 'Update user information',
          'account.update.title.inUser': 'User Updated',
          'account.update.title.sucess':
              'User information successfully updated.',
          'account.title.dn': 'Deportament name',
          'account.title.cp': 'Person position',
          'account.title..profileTitle': 'User information',
          'auth.changePasswordLabelButton': 'Change Password',
          'account.label.update': 'Update Profile',
// settings
          'settings.settings.title': 'Settings',
          'settings.language.title': 'Language',
          'settings.system.title': 'System',
          'settings.account.title': 'Account',
          'settings.account.label.phone': 'Phone Number',
          'settings.account.label.updateProfile': 'Update Profile',
          'settings.account.label.signOut': 'Sign Out',
          'settings.application': 'Application info',
          'settings.application.label.ver': 'Version',
          'settings.application.label.build': 'Build Number',
          'settings.application.label.packageName': 'Package Name',
          'settings.application.additional': 'Additional',
          'home.uidLabel': 'UID',
          'home.label.admin': 'Admin User',

          'app.title':
              ' Technical accounting of equipment and communication lines',

          'object.title': 'Object',
          'object.title.sn': 'Device S/N',
          'object.title.comson': 'Device Commissioning',
          'object.title.liab': 'Device liable',
          'object.title.model': 'Device model',
          'object.title.ip': 'Device IP',
          'object.title.type': 'Device type',
          'object.title.location': 'Device location',
          'object.title.sysName': 'Device sysName',
          'object.title.role': 'Device role',
          'object.title.position': 'Device position',
          'object.title.vlan': 'VLAN s',
          'object.title.port': 'Ports',
          'object.title.timeline': 'Timeline',

// messages
          'msg.info.message': 'Welcome to ',
          'msg.info.logging': '  Logging In...',
          'msg.info.byLogging': 'By logging in you are agree with our',
          'msg.info.TandC': ' Terms & Conditions ',
          'msg.info.and': ' and ',
          'msg.info.privacy': 'Privacy Policy',
          'msg.error.unknown': 'Unknown Error',

          'msg.error.title.signUp': 'Sign Up Failed.',
          'msg.error.text.signUp':
              'There was a problem signing up.  Please try again later.',
          'msg.error.title.signIn': 'Sign In Error',
          'msg.error.text.signIn': 'Email or password incorrect.',
          'msg.error.emailInUse': 'That email address already has an account.',
          'msg.error.updateFail': 'Failed to update user',
          'msg.validator. text.email': 'Please enter a valid email address.',
          'msg.validator. text.password':
              'Password must be at least 6 characters.',
          'msg.validator. text.name': 'Please enter a name.',
          'msg.validator. text.number': 'Please enter a number.',
          'msg.validator. text.notEmpty': 'This is a required field.',
          'msg.validator. text.amount':
              'Please enter a number i.e. 250 - no dollar symbol and no cents',
          'drawer.item.label.support': 'Report an issue'
        },

        //RUSSIAN LANGUAGE
        'ru': {
          'base.app.title': 'Емкость сети',
          'lang.localeCode': 'ru',
          'lang.localeFlag': '🇷🇺',
          'lang.localeName': 'Русский',
          'lang.changelang': 'Изменить язык',
          'lang.choseLangTitle': 'Выберите язык',
          'func.cancel': 'Отмена',
          'func.submit': 'Отправить',

//форма входа
          'form.remember': 'Запомнить меня',
          'functions.QRscanner': 'Сканер QR',
          'auth.signIn.label': 'Войти',
          'auth.email.label': 'Электронная почта',
          'auth.password.label': 'Пароль',
// обновить профиль
          'account.update': 'Обновить информацию о пользователе',
          'account.update.title.inUser': 'Обновлено пользователем',
          'account.update.title.success':
              'Информация о пользователе успешно обновлена.',
          'account.title.dn': 'Название отдела',
          'account.title.cp': 'Должность пользователя',
          'account.title..profileTitle': 'Информация о пользователе',
          'auth.changePasswordLabelButton': 'Изменить пароль',
          'account.label.update': 'Обновить профиль',
// настройки
          'settings.settings.title': 'Настройки',
          'settings.language.title': 'Язык',
          'settings.system.title': 'Система',
          'settings.account.title': 'Учетная запись',
          'settings.account.label.phone': 'Номер телефона',
          'settings.account.label.updateProfile': 'Обновить профиль',
          'settings.account.label.signOut': 'Выйти',

          'settings.application': 'Информация о приложении',
          'settings.application.label.ver': 'Версия',
          'settings.application.label.build': 'Номер сборки',
          'settings.application.label.packageName': 'Имя пакета',
          'settings.application.additional': 'Дополнительно',
          'home.uidLabel': 'UID',
          'home.label.admin': 'Администратор',

          'app.title': 'Технический учет оборудования и линий связи',

          'object.title': 'Объект',
          'object.title.sn': 'Серийный номер устройства',
          'object.title.comson': 'Ввод устройства в эксплуатацию',
          'object.title.liab': 'Ответственное устройство',
          'object.title.model': 'Модель устройства',
          'object.title.ip': 'IP-адрес устройства',
          'object.title.type': 'Тип устройства',
          'object.title.location': 'Местоположение устройства',
          'object.title.sysName': 'Системное имя устройства',
          'object.title.role': 'Роль устройства',
          'object.title.position': 'Положение устройства',
          'object.title.vlan': 'VLAN',
          'object.title.port': 'Порты',
          'object.title.timeline': 'Временная шкала',

// Сообщения
          'msg.info.message': 'Добро пожаловать',
          'msg.info.logging': 'Вход в систему...',
          'msg.info.byLogging': 'Входя в систему, вы соглашаетесь с нашими',
          'msg.info.TandC': 'Положения и условия',
          'msg.info.and': 'и',
          'msg.info.privacy': 'Политика конфиденциальности',
          'msg.error.unknown': 'Неизвестная ошибка',

          'msg.error.title.signUp': 'Ошибка регистрации.',
          'msg.error.text.signUp':
              'Возникла проблема с регистрацией. Пожалуйста, повторите попытку позже.',
          'msg.error.title.signIn': 'Ошибка входа',
          'msg.error.text.signIn':
              'Неверный адрес электронной почты или пароль.',
          'msg.error.emailInUse':
              'У этого адреса электронной почты уже есть учетная запись.',
          'msg.error.updateFail': 'Не удалось обновить пользователя',
          'msg.validator. text.email':
              'Пожалуйста, введите действительный адрес электронной почты.',
          'msg.validator. text.password':
              'Пароль должен содержать не менее 6 символов.',
          'msg.validator. text.name': 'Пожалуйста, введите имя.',
          'msg.validator. text.number': 'Пожалуйста, введите число.',
          'msg.validator. text.notEmpty': 'Это обязательное поле.',
          'msg.validator. текст.сумма':
              "Пожалуйста, введите число, например 250 - без символа доллара и без центов",
          'drawer.item.label.support': 'Сообщить о проблеме'
        },
        //KAZAKH LANGUAGE
        'kz': {
          'base.app.title': 'Желі сыйымдылығы',
          'lang.localeCode': 'kz',
          'lang.localeFlag': '🇰🇿',
          'lang.localeName': 'Қазақ',
          'lang.changelang': 'Тілді өзгерту',
          'lang.choseLangTitle': 'Өз тіліңді таңда',
          'func.cancel': 'Болдырмау',
          'func.submit': 'Жіберу',

//пішінге кіру
          'form.remember': 'Мені есте сақта',
          'functions.QRscanner': 'QR сканері',
          'auth.signIn.label': 'Кіру',
          'auth.email.label': 'Электрондық пошта',
          'auth.password.label': 'Пароль',
// профильді жаңарту
          'account.update': 'Пайдаланушы ақпаратын жаңарту',
          'account.update.title.inUser': 'Пайдаланушы жаңартылды',
          'account.update.title.sucess':
              'Пайдаланушы ақпараты сәтті жаңартылды.',
          'account.title.dn': 'Deportament name',
          'account.title.cp': 'Тұлға лауазымы',
          'account.title..profileTitle': 'Пайдаланушы туралы ақпарат',
          'auth.changePasswordLabelButton': 'Құпия сөзді өзгерту',
          'account.label.update': 'Профильді жаңарту',
// параметрлер
          'settings.settings.title': 'Параметрлер',
          'settings.language.title': 'Тіл',
          'settings.system.title': 'Жүйе',
          'settings.account.title': 'Тіркелгі',
          'settings.account.label.email': 'Электрондық пошта',
          'settings.account.label.phone': 'Телефон нөмірі',
          'settings.account.label.updateProfile': 'Профильді жаңарту',
          'settings.account.label.signOut': 'Шығу',
          'settings.application': 'Қолданба туралы ақпарат',
          'settings.application.label.ver': 'Нұсқа',
          'settings.application.label.build': 'Құрастыру нөмірі',
          'settings.application.label.packageName': 'Бума атауы',
          'settings.application.additional': 'Қосымша',
          'home.uidLabel': 'UID',
          'home.label.admin': 'Әкімші пайдаланушы',

          'app.title':
              'Жабдықтардың және байланыс желілерінің техникалық есебі',

          'object.title': 'Нысан',
          'object.title.sn': 'Device S/N',
          'object.title.comson': 'Құрылғыны іске қосу',
          'object.title.liab': 'Құрылғыға жауапты',
          'object.title.model': 'Құрылғы үлгісі',
          'object.title.ip': 'Құрылғы IP',
          'object.title.type': 'Құрылғы түрі',
          'object.title.location': 'Құрылғы орны',
          'object.title.sysName': 'Device sysName',
          'object.title.role': 'Құрылғы рөлі',
          'object.title.position': 'Құрылғы орны',
          'object.title.vlan': 'VLANs',
          'object.title.port': 'Порттар',
          'object.title.timeline': 'Уақыт шкаласы',

// хабарламалар
          'msg.info.message': 'Қош келдіңіз ',
          'msg.info.logging': ' Жүйеге кіру...',
          'msg.info.byLogging': 'Кіру арқылы сіз бізбен келісесіз',
          'msg.info.TandC': ' Шарттар мен шарттар ',
          'msg.info.and': ' және ',
          'msg.info.privacy': 'Құпиялылық саясаты',
          'msg.error.unknown': 'Белгісіз қате',

          'msg.error.title.signUp': 'Тіркелу сәтсіз аяқталды.',
          'msg.error.text.signUp':
              'Тіркелу кезінде мәселе туындады. Тағы жасауды сәл кейінірек көріңізді өтінеміз.',
          'msg.error.title.signIn': 'Кіру қатесі',
          'msg.error.text.signIn':
              'Электрондық пошта немесе құпия сөз дұрыс емес.',
          'msg.error.emailInUse':
              'Бұл электрондық пошта мекенжайында есептік жазба бар.',
          'msg.error.updateFail': 'Пайдаланушыны жаңарту мүмкін болмады',
          'msg.validator. text.email':
              'Жарамды электрондық пошта мекенжайын енгізіңіз.',
          'msg.validator. text.password':
              'Құпия сөз кемінде 6 таңбадан тұруы керек.',
          'msg.validator. text.name': 'Атын енгізіңіз.',
          'msg.validator. text.number': 'Нөмірді енгізіңіз.',
          'msg.validator. text.notEmpty': 'Бұл міндетті өріс.',
          'msg.validator. text.amount':
              'Санды енгізіңіз, яғни 250 - доллар белгісі және цент жоқ',
          'drawer.item.label.support': 'Мәселе туралы хабарлау'
        },
      };

  static final List locale = [
    {
      'name': '🇺🇸 English',
      'locale': const Locale('en'),
      'langCode': 'en',
    },
    {
      'name': '🇷🇺 Русский',
      'locale': const Locale('ru'),
      'langCode': 'ru',
    },
    {
      'name': '🇰🇿 Қазақ',
      'locale': const Locale('kz'),
      'langCode': 'kz',
    },
  ];
}
