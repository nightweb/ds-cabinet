# language: ru
@billy
Функционал: Элементы формы регистрации и входа на главной странице

  Сценарий: Вход на главную страницу, проверка наличия элементов формы
    Допустим неавторизованный пользователь открывает "главную страницу"
    То форма регистрации и входа имеет вид "Регистрация, я являюсь ИП"

  Сценарий: Клик на вкладке "Вход" в форме входа и регистрации
    Допустим неавторизованный пользователь открывает "главную страницу"
    Если пользователь кликает на вкладке "Вход" формы регистрации и входа
    То форма регистрации и входа имеет вид "Вход"

  Сценарий: Клик на вкладке "Регистрация" после клика на вкладку "Вход" 
    в форме входа и регистрации
    Допустим неавторизованный пользователь открывает "главную страницу"
    Если пользователь кликает на вкладке "Вход" формы регистрации и входа
      И пользователь кликает на вкладке "Регистрация" формы регистрации и входа
    То форма регистрации и входа имеет вид "Регистрация, я являюсь ИП"

  Сценарий: Клик на переключателе "Я являюсь ИП" в форме входа и регистрации
    Допустим неавторизованный пользователь открывает "главную страницу"
    Если пользователь кликает на переключателе "Я не являюсь ИП"
    То форма регистрации и входа имеет вид "Регистрация, я НЕ являюсь ИП"

  Сценарий: При клике на переключателе "Я являюсь ИП" в форме входа и регистрации
    последующие переключения вкладок формы должны сохранять в неизменном виде, поля
    скрытые и показанные при клике на переключателе.
    Допустим неавторизованный пользователь открывает "главную страницу"
    Если пользователь кликает на переключателе "Я не являюсь ИП"
      И  пользователь кликает на вкладке "Вход" формы регистрации и входа
      И  пользователь кликает на вкладке "Регистрация" формы регистрации и входа
    То форма регистрации и входа имеет вид "Регистрация, я НЕ являюсь ИП"

  Сценарий: При клике на ссылке условий использования должно открываться новое окно
    с заголовком "Условия использования" 
    Допустим неавторизованный пользователь открывает "главную страницу"
    Если пользователь кликает ссылку "Условиями использования" в форме регистрации и входа
    То открывается новое окно

  Сценарий: При клике на ссылке Политики конфиденцальности должно открываться новое окно
    с заголовком "Положение об обработке и защите персональных данных" 
    Допустим неавторизованный пользователь открывает "главную страницу"
    Если пользователь кликает ссылку "Политикой конфиденциальности" в форме регистрации и входа
    То открывается новое окно
      И открывшееся окно имеет заголовок "Положение об обработке и защите персональных данных"

