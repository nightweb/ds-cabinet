# language: ru
#FIXME Перед запуском этого теста надо удалить в тестовой БД все записи Registration.destroy_all
@billy
Функционал: Успешная регистрация ИП и ЮЛ, все обращения к внешним системам 
  выполняются через VCR. 

  Сценарий: Вход на главную страницу, заполнение полей как ИП
    Допустим используется пресет "Батурина"
      И отсутствует объект модели регистрации
      И генератор паролей возвращает правильный пароль
      И компании в Siebel не существует
      И не зарегистрированный пользователь заходит на сайт
    Если правильно заполняет ОГРНИП и телефон и переходит к следующему шагу
      И проверяет свои ОГРНИП, телефон и имя, вводит пароль и переходит к следующему шагу
      И выбирает тарифный план Квартал
      И платежная система подтверждает приложению выполнение платежа
    То регистрация завершена
      И пользователь имеет оплаченный доступ
