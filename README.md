# README

## Тестовое задание

---

### Версия

`Ruby 2.7.2`

`Rails 6.1.1`

### Развертывание

Скопируйте репозиторий на локальную машину и сделайте `bundle`:

```
$ git clone git@github.com:Lemeri02/store_test.git
```

```
$ cd store_test
```

```
$ bundle
```

### База данных

В папке проекта запустите команды

```
$ rails db:migrate
```

```
$ rails db:seed
```

### Инструкция для запуска и проверки

Лучше команды выполнять в `Postman` или `Insomnia`

Посмотреть все продукты на складе с `id: 1` (всего db:seed создаст 5 складов с продуктами)

```
localhost:3000/stores/1/products
```

Посмотреть продукт с `id: 1` (всего в демо-базе 15 продуктов)

```
localhost:3000/products/1
```

#### Endpoint 1 - перенос продукта со склада на склад.

Ниже приведен пример перемещения со склада `id:1` на склад `id:2` продукта с `sku:SKU35` в количестве `1 единицы`

```
localhost:3000/stores/1/products/move_product?product_sku=SKU35&target_store_id=2&quantity=1
```
где, <br>
`product_sku` - идентификатор продукта (необходимый идентификатор продукта `SKUXX`, можно узнать обращением по адресу `localhost:3000/stores/1/products`)<br>
`target_store_id` - `id` склада назначения, куда нужно переносить продукт <br>
`quantity` - количество продукта


#### Endpoint 2 - реализация продукта

Ниже пример реализации продукта с `sku:SKU32` со склада с `id:1` в количестве `1 единицы`

```
localhost:3000/stores/1/products/sell_product?product_sku=SKU32&quantity=1
```

### Тестирование
Запуск тестов

```
$ rspec spec/requests/ --format documentation
```
