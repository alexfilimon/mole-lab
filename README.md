# Лабораторная по ООАиП

## Задание

Дачная война. В задаче участвуют объекты: дачник, кроты (мужского и женского пола). На игровом поле располагаются грядки, на которых выращивается урожай. Дачник перемещается по полю к ближайшему кроту, который находится на поверхности, и имеет параметры: скорость перемещения и радиус удара. Кроты хаотично перемещаются по полю под землей и хаотично вылезают на поверхность. Если крот вылез на поверхность, то он находится на ней некоторое время и уничтожает какое-то кол-во урожая. При движении под землей крот не видит движения дачника. Если кроты мужского и женского пола встретятся под землей, то они замирают и через некоторое время у них появляется еще один крот. Перед запуском задаются параметры дачника, размер игрового поля, количество и тип кротов. Игра считается оконченной, если будет уничтожен весь урожай, или погибнут все кроты. 

## Основные компоненты

- `Game` - объект игры
- `Gargen` - сад
- `Mole` - класс крота
- `Man` - садовник

## Подробное описание компонентов

### Game

Объект игры: который отвечает за:

- конфигурацию игры
- запуск тактов игры
- проверку окончания игры
  - если все растения поели кроты, то они победили
  - если всех кротов убил садовник, то победил он

### Garden

Сад разбит на 2 протокола:

- `UpperGarden` - верхний сад, который виден садовнику
  - свойства
    - размер поля
    - кроты на воздухе
    - растения
  - методы
    - получить кротов около точки с радиусом
    - убить крота
- `LowerGarden` - нижний сад, который виден кротам
  - свойства
    - размер поля
  - методы
    - родить крота в точке

### Mole

Кротов можно создавать с помощью фабрики `MoleFactory`.

У крота есть свойства:

- позиция
- подземный сад
- пол
- на веоздухе ли он
- текущий такт на воздухе
- текущий такт размножения
- пара для размножения 

И один метод такта.

Во время такта происходит проверка:

- если на воздухе, то меняем счетчик тактов на воздухе и (если уже хватит находится там), то возвращаем под землю
- если в процессе скрещивания, то 
  - меняем счетчик скрещивания
  - если последний такт и пол женский - рождаем нового крота
  - если последний такт, то убираем пару
- если совпала позиция с другим кротом, то создаем пару и начинаем скрещивание
- иначе - передвигаем в рандомном направлении

### Man

Это саодвник.

В ходе тактов происходит проверка:

- если есть крот на воздухе поблизости - убиваем его
- ищем ближайшего крота и двигаемся навстречу к нему
