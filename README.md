# Currency Tracker

Это приложение Ruby on Rails, которое отслеживает курсы валют с сайта Центробанка РФ.

## Установка

Убедитесь, что у вас установлены Ruby 3.2.2, Rails 7+ и PostgreSQL. Клонируйте репозиторий и установите зависимости:

```bash
git clone https://github.com/badimalex/currency_tracker
cd currency_tracker
bundle install
rake db:create
rake db:migrate
rake db:seed
```

## Demo
![график курсов валют](https://github.com/badimalex/currency_tracker/blob/main/Screenshot%202023-11-27%20at%2015.56.38.png?raw=true)
![изменение цен](https://github.com/badimalex/currency_tracker/blob/main/Screenshot%202023-11-27%20at%2015.56.42.png?raw=true)
