# language: ru
@billy
Функционал: Ошибки регистрации ИП, все обращения к внешним системам 
  выполняются через VCR. 

  Сценарий: Вход на главную страницу, ввод ОГРНИП, зарегистрированного
    в системе Siebel
    Допустим используется пресет "Батурина"
      И отсутствует объект модели регистрации
      И компания в Siebel существует
      И не зарегистрированный пользователь заходит на сайт
    Если правильно заполняет ОГРНИП и телефон и переходит к следующему шагу
      И появляется сообщение об ошибке "ОГРНИП уже зарегистрирован"
      И отмена компания в Siebel существует
    То отложен объект модели регистрации
      И задержка 1 сек
      И скриншот "registration - ogrn already exists"
